
#include <windows.h>
#include <stdio.h>
#include <time.h>

#define WltUSB_API __declspec(dllexport)

extern WltUSB_API int PASCAL GetBmp(char * Wlt_File,int intf);


