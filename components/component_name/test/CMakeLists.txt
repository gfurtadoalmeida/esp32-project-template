idf_component_register(
    SRCS "test.c"
    INCLUDE_DIRS "../include"
    PRIV_INCLUDE_DIRS "../private_include"
    # Change the component name.
    REQUIRES unity component_name
)