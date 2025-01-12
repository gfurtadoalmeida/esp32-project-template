# ESP32 - Project Template

[![GitHub Release Status][git-bagdge-release]][git-release] [![Bugs][sonar-badge-bugs]][sonar-home] [![Code Smells][sonar-badge-smells]][sonar-home] [![Security Rating][sonar-badge-security]][sonar-home] [![Quality Gate Status][sonar-badge-quality]][sonar-home]  

ESP32 project template with build pipeline, enhanced VS Code support and more.  

## Characteristics

* ESP-IDF: [v5.3](https://docs.espressif.com/projects/esp-idf/en/v5.3/esp32/index.html)
* GitHub Workflows: 🚀
  * Development: [Sonar Cloud](https://sonarcloud.io/) integration when building the component.
  * Release: packages the component and generates release notes.
* Testing: 🧪
  * VSCode [tasks](https://code.visualstudio.com/docs/editor/tasks) for tests (requires [ESP-IDF extension](https://marketplace.visualstudio.com/items?itemName=espressif.esp-idf-extension)).
  * Watchdogs disabled when testing.
* Helper macros with TAG added for:
  * Logging.
  * Assertions.
* Configuration: sample [Kconfig](/components/component_name/Kconfig) file for component configuration through [menuconfig](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/kconfig.html).
* [Newlib nano formatting](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/performance/size.html?#newlib-nano-formatting) enabled for `printf/scanf`:
  * Binary size reduction (25KB~50KB) as they are already in ESP32 ROM.
  * Stack usage reduction for functions that call string formatting functions.
  * Increased performance as functions in ROM run faster than functions from flash.
  * Functions in ROM can run when flash instruction cache is disabled.

## Usage

1. Clone the repository (or download the [latest release][git-release]):

   ```sh
   git clone "https://github.com/gfurtadoalmeida/esp32-project-template.git" --depth=1 --branch=master
   rm -rf esp32-project-template/.git
   ```

2. Rename the project:

   ```pwsh
   .\Rename-Project.ps1 "C:\projects\github\awesome_component_folder" awesome_component_name
   ```

3. Delete the script:  
   Delete the [Rename-Project.ps1](../../Rename-Project.ps1) script as it has no more use.

## Documentation

Everything is at the [docs](/docs) folder.

## Contributing

To contribute to this project make sure to read our [CONTRIBUTING.md](/docs/CONTRIBUTING.md) file.

[git-bagdge-release]: https://github.com/gfurtadoalmeida/esp32-project-template/actions/workflows/release.yml/badge.svg
[git-release]: https://github.com/gfurtadoalmeida/esp32-project-template/releases
[sonar-badge-bugs]: https://sonarcloud.io/api/project_badges/measure?project=esp32_project_template&metric=bugs
[sonar-badge-quality]: https://sonarcloud.io/api/project_badges/measure?project=esp32_project_template&metric=alert_status
[sonar-badge-security]: https://sonarcloud.io/api/project_badges/measure?project=esp32_project_template&metric=security_rating
[sonar-badge-smells]: https://sonarcloud.io/api/project_badges/measure?project=esp32_project_template&metric=code_smells
[sonar-home]: https://sonarcloud.io/project/overview?id=esp32_project_template
