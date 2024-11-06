import re
import os
from pathlib import Path

def read_api_md(api_md_path: str) -> dict:
    """Read and parse the api.md file to extract documentation for each function."""
    with open(api_md_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    docs = {}
    
    section_terminator_tuples = re.findall(r'###([\s\S]*?)(?=(##|\Z))', content)
    
    for section_terminator_tuple in section_terminator_tuples:
        section = section_terminator_tuple[0]

        # Remove leading and trailing whitespace
        section = section.strip()

        # Remove the ### from the start of the section
        section = re.sub(r'###\s', '', section, 1)

        # Extract function name - it's the first word in the section
        func_name, description = re.split(r'\s', section, 1)

        # Remove the tags section
        description = re.sub(r'<span class="tags">([\s\S]*?)<\/span>[\s]*', '', description)

        # Remove any horizontal rules
        description = re.sub(r'<hr>', '', description)

        # Remove remaining whitespace
        description = description.strip()

        # Create the moonwave doc comment
        doc_comment = '--[=[\n\n'
        for line_of_description in description.split('\n'):
            doc_comment += f'\t{line_of_description}\n'
        doc_comment += '\n]=]'
        
        docs[func_name.lower()] = doc_comment
    
    return docs

def get_function_name_from_file(file_path: str) -> str:
    """Get the function name from a file path."""
    return Path(file_path).stem

def get_function_doc_comment(docs: dict, func_name: str) -> str:
    """Get the doc comment for a function from the parsed api.md documentation."""
    return docs.get(func_name.lower())

def find_function_position(file_path: str) -> int:
    """Find the position of the function definition in a file."""
    func_name = get_function_name_from_file(file_path)
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    match = re.search(r'^local function ' + func_name + '[\(<]', content, re.MULTILINE)
    if match:
        return match.start()
    match = re.search(r'^(local\s)?' + func_name + ' ?= ?function', content, re.MULTILINE)
    return match.start() if match else -1

def get_doc_injected_source(file_path: str, doc_comment: str):
    """Inject a doc comment into a function in a file."""
    
    function_position = find_function_position(file_path)
    if function_position == -1:
        return None
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    content = content[:function_position] + doc_comment + "\n\n" + content[function_position:]
    return content    

def inject_doc_comment(file: str, docs: dict, dry_run: bool = True):
    func_name = get_function_name_from_file(file)
    doc_comment = get_function_doc_comment(docs, func_name) 
    if doc_comment is None:
        return False, f"Function {func_name} not found in api.md"

    injected_source = get_doc_injected_source(file, doc_comment)
    if not injected_source:
        return False, f"Failed to inject doc comment for {func_name} in {file}"
        
    if dry_run:
        return True, "dry run: doc comment not written"
    else:
        with open(file, 'w', encoding='utf-8') as f:
            f.write(injected_source)
        return True, f"Successfully wrote doc comment to {file}"

if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python doc_comments.py <api.md path> <directory_path> [--inject]")
        sys.exit(1)

    api_md_path = sys.argv[1]
    directory_path = sys.argv[2]
    dry_run = "--inject" not in sys.argv

    docs = read_api_md(api_md_path)

    path = Path(directory_path)
    files_to_inject = []
    for file in path.glob("*.[lL][uU][aA]*"):
        if file.stem in ['init', 'lib', 'Error', 'None', 'Types', 'Symbol'] or file.stem.startswith('_'):
            continue
        files_to_inject.append(file)

    success_files = {}
    problem_files = {}

    for file in files_to_inject:
        success, result = inject_doc_comment(file, docs, dry_run)
        if success:
            success_files[file] = result
        else:
            problem_files[file] = result

    print(len(success_files), "doc comments successfully " + ("generated" if dry_run else "injected") + ".")
    if not problem_files:
        print("All doc comments successfully injected!")
    else:
        print("Problems encountered:")
        for file, result in problem_files.items():
            print(f"\t{file}: {result}")