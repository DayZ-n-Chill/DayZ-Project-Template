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
        print("\033[91m" + f"Error reading configuration: {e}" + "\033[0m")  # Red
    return None

def replace_text_in_file(file_path, old_text, new_text):
    """Replaces text in a single file, logs changes, with error handling."""
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
        new_content = content.replace(old_text, new_text)
        if content != new_content:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(new_content)
            print("\033[92m" + f"Updated {file_path}" + "\033[0m")  # Green
            print_changes(content, new_content)
        else:
            print("\033[93m" + f"No changes needed in {file_path}" + "\033[0m")  # Yellow
    except FileNotFoundError:
        print("\033[91m" + f"File not found: {file_path}" + "\033[0m")  # Red
    except Exception as e:
        print("\033[91m" + f"Failed to update {file_path}: {e}" + "\033[0m")  # Red

def print_changes(old_content, new_content):
    """Prints differences between old and new content."""
    from difflib import unified_diff
    diff = unified_diff(old_content.splitlines(), new_content.splitlines(), lineterm='', fromfile='before', tofile='after')
    for line in diff:
        print(line)

def main():
    config_path = r"E:\DayZ Projects\DayZ-Project-Template\Utils\Shared\Globals.cfg"
    project_dir = load_project_directory(config_path)
    if not project_dir:
        print("\033[91m" + "Failed to load the project directory from configuration. Exiting." + "\033[0m")  # Red
        return
    
    new_mod_name = input("\033[93m" + "Enter the new mod name to replace 'Mod-Name': " + "\033[0m").strip()  # Yellow
    if not new_mod_name:
        print("\033[91m" + "No mod name entered. Exiting." + "\033[0m")  # Red
        return

    files_to_modify = {
        "BuildMods.bat": os.path.join(project_dir, "Utils", "Batch", "Build", "BuildMods.bat"),
        "Globals.cfg": os.path.join(project_dir, "Utils", "Shared", "Globals.cfg"),
        "config.cpp": os.path.join(project_dir, "Mod-Name", "Scripts", "config.cpp"),
        "dayz.gproj": os.path.join(project_dir, "Mod-Name", "Workbench", "dayz.gproj"),
        "DayZTools.c": os.path.join(project_dir, "Mod-Name", "Workbench", "ToolAddons", "Plugins", "DayZTools.c")
    }

    for file_description, file_path in files_to_modify.items():
        replace_text_in_file(file_path, "Mod-Name", new_mod_name)

    print("\033[92m" + "Modification process is complete. Thank you for using DayZ n Chill Dev Tools!" + "\033[0m")  # Green

if __name__ == "__main__":
    main()
