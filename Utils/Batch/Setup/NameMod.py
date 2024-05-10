import os
import configparser

def load_config():
    config = configparser.ConfigParser()
    config_path = os.path.join(os.path.dirname(__file__), '../Shared/Globals.cfg')
    config.read(config_path)
    return config['DEFAULT']

def color_text(text, color):
    colors = {
        'cyan': '\033[96m',       # Informational elements
        'yellow': '\033[93m',     # Questions
        'white': '\033[97m',      # Options
        'purple': '\033[95m',     # Changes
        'green': '\033[92m',      # Success messages
        'red': '\033[91m',        # Error messages
        'reset': '\033[0m'
    }
    return f"{colors[color]}{text}{colors['reset']}"

def normalize_mod_name(mod_name):
    print(color_text("For best practice reasons, it is recommended to use camelCase or underscores instead of spaces.", 'cyan'))
    options = {
        '1': 'camelCase',
        '2': 'underscores',
        '3': 'continue with spaces'
    }
    for key, value in options.items():
        print(color_text(f"{key}: {value}", 'white'))
    choice = input(color_text("Choose an option (1, 2, or 3): ", 'yellow')).strip()
    
    if choice == '1':
        return ''.join(word.capitalize() for word in mod_name.split())
    elif choice == '2':
        return mod_name.replace(' ', '_')
    else:
        return mod_name

def replace_mod_name_in_files(root_dir, new_mod_name):
    text_file_extensions = ['.py', '.txt', '.cfg', '.xml']  # Add more file extensions as needed
    for subdir, dirs, files in os.walk(root_dir):
        # Skip .git directory and any other directories you don't want to process
        dirs[:] = [d for d in dirs if d not in ['.git']]
        for file in files:
            if any(file.endswith(ext) for ext in text_file_extensions):
                file_path = os.path.join(subdir, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                    new_content = content.replace("Mod-Name", new_mod_name)
                    if new_content != content:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            f.write(new_content)
                        print(color_text(f"Updated mod name in {file_path}", 'purple'))
                except UnicodeDecodeError as e:
                    print(color_text(f"Could not read {file_path} due to encoding issue: {e}", 'red'))
                except Exception as e:
                    print(color_text(f"Error processing {file_path}: {e}", 'red'))

def main():
    config = load_config()
    root_dir = config.get('PROJECTDIR', os.getcwd())  # Ensure this is the correct path
    mod_name = input(color_text("What would you like to call your mod? ", 'yellow'))
    if ' ' in mod_name:
        mod_name = normalize_mod_name(mod_name)
    replace_mod_name_in_files(root_dir, mod_name)
    print(color_text("All modifications are complete.", 'green'))

if __name__ == "__main__":
    main()
