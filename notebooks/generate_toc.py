import os
import yaml

# Custom Dumper to preserve indentation for nested lists
class IndentDumper(yaml.Dumper):
    def increase_indent(self, flow=False, indentless=False):
        return super().increase_indent(flow, False)

def generate_toc(directory):
    toc = {
        'format': 'jb-book',
        'root': 'intro',
        'chapters': []
    }

    def find_ipynb_files(dir_path):
        ipynb_files = []
        subdirs = []

        for root, dirs, files in os.walk(dir_path):
            dirs[:] = [d for d in dirs if not d.startswith(('_', '.'))]

            if root == dir_path:
                collected = []
                for file in files:
                    if file.endswith('.ipynb'):
                        relpath = os.path.relpath(os.path.join(root, file), dir_path).replace('.ipynb', '')
                        collected.append(relpath)
                ipynb_files = sorted(collected, key=str.lower)
            else:
                subdir_relpath = os.path.normpath(os.path.relpath(root, dir_path))
                subdir_files = []
                for file in sorted(files, key=str.lower):
                    if file.endswith('.ipynb'):
                        relpath = os.path.relpath(os.path.join(root, file), dir_path).replace('.ipynb', '')
                        subdir_files.append(os.path.normpath(relpath))

                if subdir_files:
                    main_file = os.path.normpath(f"{subdir_relpath}/{os.path.basename(root)}")
                    section_files = sorted([f for f in subdir_files if f != main_file], key=str.lower)
                    subdirs.append((main_file, section_files))

        return ipynb_files, subdirs

    ipynb_files, subdirs = find_ipynb_files(directory)

    for file in ipynb_files:
        toc['chapters'].append({'file': file})

    for main_file, section_files in subdirs:
        section_items = [{'file': file} for file in section_files]
        toc['chapters'].append({
            'file': main_file,
            'sections': section_items
        })

    toc_filename = os.path.join(directory, '_toc.yml')
    with open(toc_filename, 'w') as f:
        yaml.dump(toc, f, Dumper=IndentDumper, default_flow_style=False, sort_keys=False)

    print(f"_toc.yml file has been created in {directory}")

# Example usage
directory_path = './'  # Change this to your directory path
generate_toc(directory_path)

