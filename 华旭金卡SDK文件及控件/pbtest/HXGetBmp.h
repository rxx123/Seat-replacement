#define HXBMP_API __declspec(dllexport)

extern HXBMP_API int PASCAL HX_GetBmp(char * WLT_File, char * BMP_File, int intf);
/*
  说    明：本函数用于将wlt文件解码成bmp文件。
参    数：Wlt_File  ----- wlt文件名(包含绝对路径)
          BMP_File  ----- 生成的Bmp文件名(包含绝对路径)
          intf       ----- 阅读设备通讯接口类型（1-RS-232C，2-USB）
返 回 值：意义
1	相片解码解码正确
0	调用sdtapi.dll错误
-1	相片解码错误
-2	wlt文件后缀错误
-3	wlt文件打开错误
-4	wlt文件格式错误
-5	软件未授权
-6	设备连接错误
123 文件名错误
注意事项
1、	wlt文件的后缀要固定为".wlt",如：xp.wlt，BMP文件的后缀要固定为".bmp"；
2、	本函数要与sdtapi.dll、WltRS.dll关联使用,并确认通讯端口处于关闭状态；
 




*/
