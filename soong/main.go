package sm6150

import (
    "android/soong/android"
)

func init() {
    android.RegisterModuleType("motorola_sm6150_init_library_static", initLibraryFactory)
}
