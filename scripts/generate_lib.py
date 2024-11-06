import os
from pathlib import Path

def generate_lib_lua(directory_path: str) -> str:
    """
    Generates the contents of a lib.lua file by scanning a directory for Lua/Luau files.
    Excludes init.lua, lib.lua itself and any files starting with '_'.
    """
    # Get all .lua/.luau files in the directory
    path = Path(directory_path)
    lua_files = []
    
    for file in path.glob('*.[lL][uU][aA]*'):
        # Skip lib.lua and files starting with underscore
        if file.stem == 'init' or file.stem == 'lib' or file.stem.startswith('_'):
            continue
        lua_files.append(file.stem)
    
    # Sort for consistent output
    lua_files.sort()
    
    # Generate the lib.lua content
    lines = ['return {']
    
    # Add require statement for each file
    for file in lua_files:
        lines.append(f'    {file} = require(script.Parent.{file}),')
    
    lines.append('}')
    
    return '\n'.join(lines)

def write_lib_file(directory_path: str, dry_run: bool = True) -> None:
    """
    Generates and optionally writes the lib.lua file.
    If dry_run is True, prints the content instead of writing to file.
    """
    content = generate_lib_lua(directory_path)
    
    if dry_run:
        print("Generated lib.lua content:")
        print(content)
    else:
        lib_path = os.path.join(directory_path, 'lib.lua')
        with open(lib_path, 'w') as f:
            f.write(content)
        print(f"Successfully wrote lib.lua to {lib_path}")

# Example usage
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python generate_lib.py <directory_path> [--write]")
        sys.exit(1)
    
    directory = sys.argv[1]
    write_mode = "--write" in sys.argv
    
    write_lib_file(directory, dry_run=not write_mode)