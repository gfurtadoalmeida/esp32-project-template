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
    CMP_LOGI("something was done");
}

#ifdef __cplusplus
}
#endif