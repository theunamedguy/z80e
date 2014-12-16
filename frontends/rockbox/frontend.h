/* a header for frontend-specific macros */
#include "plugin.h"
#include <tlsf.h>
#define malloc tlsf_malloc
#define calloc tlsf_calloc
#define realloc tlsf_realloc
#define free tlsf_free
#define printf LOGF
