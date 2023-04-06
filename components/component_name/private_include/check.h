#ifndef __COMPONENT_NAME_CHECK_H__
#define __COMPONENT_NAME_CHECK_H__

#ifdef __cplusplus
extern "C"
{
#endif

#include "log.h"

/**
 * @brief Return a value based on a failed condition.
 *
 * @param condition Condition to evaluate.
 * @param message Message to be written if the condition fails.
 * @param return_value Value to be returned if the condition fails.
 *
 * @return If the condition fails the method will return what was passed on
 * "return_value" parameter, otherwise the method will continue.
 */
#define CMP_CHECK(condition, message, return_value)              \
    if (!(condition))                                            \
    {                                                            \
        CMP_LOGE("%s(%d): %s", __FUNCTION__, __LINE__, message); \
        return (return_value);                                   \
    }

#ifdef __cplusplus
}
#endif
#endif
