# Using the Template

## 1. Clone the Repository

Clone this repository, preferably using the following commands:

```bash
git clone "https://github.com/gfurtadoalmeida/esp32-project-template.git" --depth=1 --branch=master
rm -rf esp32-project-template/.git
```

## 2. Rename the Project

Run the [Rename-Project.ps1](../../Rename-Project.ps1) script passing the full project path and the project name.  

```bash
.\Rename-Project.ps1 "C:\projects\github\my_awesome_component_folder" my_awesome_component_name
```

The script will rename files, directories and find and replace texts on some files, to give you a custom component with the correct structure and names.

## 3. Delete the Script

After executing the [Rename-Project.ps1](../../Rename-Project.ps1) script, you can delete it as it has no more use.
