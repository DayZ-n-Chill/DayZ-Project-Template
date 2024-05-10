import os

def load_project_directory(config_path):
    """Loads the project directory path from a configuration file."""
    try:
        with open(config_path, 'r') as file:
            for line in file:
                if line.strip().startswith('PROJECTDIR'):
                    return line.strip().split('=')[1].strip()
    except FileNotFoundError:
        print("\033[91m" + f"Configuration file not found: {config_path}" + "\033[0m")  # Red
    except Exception as e:
        print("\033[91m" + f"Error reading from configuration file: {e}" + "\033[0m")  # Red
    return None

def replace_text_in_files(root_dir, old_text, new_text):
    files_read = 0
    files_modified = 0
    for subdir, dirs, files in os.walk(root_dir):
        print("\033[96m" + f"Reading directory: {subdir}" + "\033[0m")  # Cyan
        for file in files:
            file_path = os.path.join(subdir, file)
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                files_read += 1
                print("\033[97m" + f"Reading file: {file_path}" + "\033[0m")  # White
            except UnicodeDecodeError:
                try:
                    with open(file_path, 'r', encoding='windows-1252') as f:
                        content = f.read()
                    files_read += 1
                    print("\033[97m" + f"Reading file with alternate encoding: {file_path}" + "\033[0m")  # White
                except UnicodeDecodeError:
                    print("\033[91m" + f"Failed to read file {file_path} with any encoding." + "\033[0m")  # Red
                    continue  # Skip this file if it can't be read with both encodings
            if old_text in content:
                updated_content = content.replace(old_text, new_text)
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(updated_content)
                files_modified += 1
                print("\033[92m" + f"Modified file: {file_path}" + "\033[0m")  # Green
    return files_read, files_modified

def rename_folders(root_dir, old_name, new_name):
    for subdir, dirs, _ in os.walk(root_dir, topdown=False):
        for dir in dirs:
            if dir == old_name:
                old_dir_path = os.path.join(subdir, dir)
                new_dir_path = os.path.join(subdir, new_name)
                os.rename(old_dir_path, new_dir_path)
                print("\033[95m" + f"Renamed folder from {old_dir_path} to {new_dir_path}" + "\033[0m")  # Purple

config_path = os.path.join("e:", os.sep, "DayZ Projects", "DayZ-Project-Template", "Utils", "Shared", "Globals.cfg")
project_dir = load_project_directory(config_path)
if not project_dir:
    print("\033[91m" + "Failed to load the project directory. Exiting." + "\033[0m")  # Red
    exit(1)

new_mod_name = input("Enter your new mod name to replace 'Mod-Name': ").strip()
if not new_mod_name:
    print("\033[91m" + "No mod name entered. Exiting." + "\033[0m")  # Red
    exit(1)

files_read, files_modified = replace_text_in_files(project_dir, "Mod-Name", new_mod_name)
rename_folders(project_dir, "Mod-Name", new_mod_name)

print("\033[92m" + f"Modification process is complete. Files read: {files_read}, Files modified: {files_modified}" + "\033[0m")  # Green
