#ifdef __cplusplus
extern "C"
{
#endif

#include "component_name/component_name.h"
#include "assertion.h"
#include "config.h"
#include "log.h"

void component_name_do_something()
{
    CMP_LOGI("config value: %d", CONFIG_COMP_NAME_CONFIG_ONE);
}

#ifdef __cplusplus
}
#endif