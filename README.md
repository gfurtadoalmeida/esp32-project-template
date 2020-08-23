# ESP32 Project Template

ESP32 project template, including tests and able to work on VS Code.  

## Features

* It compiles 🚀
* Prepared for tests.
* VS Code task for tests:
  * `Build test`
  * `Flash test`
  * `Monitor test`
  * `Build, flash and start a monitor for the tests`

Note: for VS Code it's highly recommended to install the official [ESP-IDF Extension](https://marketplace.visualstudio.com/items?itemName=espressif.esp-idf-extension), for a better experience.

## You Need to Change

* [CMakeLists.txt](/CMakeLists.txt):
  * Change the `project-name`.
* [/.vscode/settings.json](/.vscode/settings.json):
  * Change `idf.portWin` to the COM port that your device is connected.
  * Change `idf.openOcdConfigs` based on your device.
* [/test/CMakeLists.txt](/test/CMakeLists.txt):
  * Change the `component-name` on the test components.
  * Add more components to the test runner, if needed.
* [/components/component_name](/components/component_name/):
  * Change the folder name.
  * [CMakeLists.txt](/components/component_name/CMakeLists.txt):
    * Add your sources and requires.
  * [Kconfig](/components/component_name/Kconfig):
    * Add your configurations or delete the file if not needed.
  * [/private_include](/components/component_name/private_include/):
    * [common.h](/components/component_name/private_include/common.h):
      * Change `COMPONENT_NAME_TAG` name and value.
      * Change `COMP_NAME_CHECK` name.
    * [config.h](/components/component_name/private_include/config.h):
      * Add your configurations or delete the file if not needed.
      * Keep in mind that the names defined on the KConfig file are translated with a `CONFIG_` prefix (i.e.: `COMP_NAME_CONFIG_ONE` -> `CONFIG_COMP_NAME_CONFIG_ONE`).
  * [/test](/components/component_name/test/):
    * [CMakeLists.txt](/components/component_name/test/CMakeLists.txt):
      * Change the `component_name`.
    * [test.c](/components/component_name/test/test.c):
      * Add your tests.
