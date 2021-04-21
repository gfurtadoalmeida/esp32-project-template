cmake_minimum_required(VERSION 3.13)

if(POLICY CMP0076)
    cmake_policy(SET CMP0076 NEW)
endif()

set(EXTRA_COMPONENT_DIRS "../components")

# Change the component name and add more if needed.
set(TEST_COMPONENTS "component_name" CACHE STRING "List of components to test")

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(test_runner)
