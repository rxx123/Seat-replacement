/** TxOpenPrinter的第一个参数 */
/**@{*/
#define TX_TYPE_NONE       0
#define TX_TYPE_USB        1
#define TX_TYPE_LPT        2
#define TX_TYPE_COM        3
#define TX_TYPE_MEM        4
#define TX_TYPE_FD         5
/**@}*/

/** 打印机状态 */
/**@{*/
#define TX_STAT_NOERROR    0x0008 /*无故障*/
#define TX_STAT_SELECT     0x0010 /*处于联机状态*/
#define TX_STAT_PAPEREND   0x0020 /*缺纸*/
#define TX_STAT_BUSY       0x0080 /*繁忙*/
#define TX_STAT_DRAW_HIGH  0x0100
#define TX_STAT_COVER      0x0200
#define TX_STAT_ERROR      0x0400
#define TX_STAT_RCV_ERR    0x0800 /* Recoverable error */
#define TX_STAT_CUT_ERR    0x1000 /* Autocutter error */
#define TX_STAT_URCV_ERR   0x2000 /* Unrecoverable error */
#define TX_STAT_ARCV_ERR   0x4000 /* Auto-recoverable error */
#define TX_STAT_PAPER_NE   0x8000 /* paper near-end */
/**@}*/

/** TxDoFunction的func参数 */
/**@{*/
#define TX_FONT_SIZE       1  /*放大系数，0为原始大小，1为增大1倍，如此类推，最大为7；参数1为宽，参数2为高*/
#define TX_FONT_ULINE      2  /*下划线*/
#define TX_FONT_BOLD       3  /*粗体*/
#define TX_SEL_FONT        4  /*选择英文字体*/
#define TX_FONT_ROTATE     5  /*旋转90度*/
#define TX_ALIGN           6  /*参数为TX_ALIGN_XXX*/
#define TX_CHINESE_MODE    7  /*开关中文模式*/
#define TX_FEED            10 /*执行走纸*/
#define TX_UNIT_TYPE       11 /*设置动作单位*/
#define TX_CUT             12 /*执行切纸，第一参数指明类型，第二参数指明切纸前的走纸距离*/
#define TX_HOR_POS         13 /*绝对水平定位*/
#define TX_LINE_SP         14 /*设置行间距*/
#define TX_BW_REVERSE      15 /*设置字体黑白翻转*/
#define TX_UPSIDE_DOWN     16 /*设置倒置打印*/
#define TX_INET_CHARS      17 /*选择国际字符集*/
#define TX_CODE_PAGE       18 /*选择字符代码表*/
#define TX_CH_ROTATE       19 /*设定汉字旋转*/
#define TX_CHK_BMARK       20 /*寻找黑标*/
#define TX_SET_BMARK       21 /*设置黑标相关偏移量*/
#define TX_PRINT_LOGO      22 /*打印已下载好的LOGO*/
#define TX_BARCODE_HEIGHT  23 /*设定条码高度*/
#define TX_BARCODE_WIDTH   24 /*设定条码宽度*/
#define TX_BARCODE_FONT    25 /*选择HRI字符的打印位置*/
#define TX_FEED_REV        26 /*执行逆向走纸*/
#define TX_QR_DOTSIZE      27 /*设置QR码的点大小，2<param1<10*/
#define TX_QR_ERRLEVEL     28 /*设置QR码的交错等级*/
/**@}*/

/** TxDoFunction的参数（需对应功能） */
/**@{*/
#define TX_ON              1
#define TX_OFF             0
#define TX_CUT_FULL        0  /*对应TX_CUT*/
#define TX_CUT_PARTIAL     1
#define TX_PURECUT_FULL    2  /*与黑标无关的切纸*/
#define TX_PURECUT_PARTIAL 3
#define TX_FONT_A          0  /*对应TX_SEL_FONT*/
#define TX_FONT_B          1
#define TX_ALIGN_LEFT      0  /*对应TX_ALIGN*/
#define TX_ALIGN_CENTER    1
#define TX_ALIGN_RIGHT     2
#define TX_SIZE_1X         0  /*对应TX_FONT_SIZE*/
#define TX_SIZE_2X         1
#define TX_SIZE_3X         2
#define TX_SIZE_4X         3
#define TX_SIZE_5X         4
#define TX_SIZE_6X         5
#define TX_SIZE_7X         6
#define TX_SIZE_8X         7
#define TX_UNIT_PIXEL      0  /*对应TX_UNIT_TYPE*/
#define TX_UNIT_MM         1
#define TX_CH_ROTATE_NONE  0  /*对应TX_CH_ROTATE*/
#define TX_CH_ROTATE_LEFT  1
#define TX_CH_ROTATE_RIGHT 2
#define TX_BM_START        1  /*起始打印位置相对于黑标检测位置的偏移量*/
#define TX_BM_TEAR         2  /*切/撕纸位置相对于黑标检测位置的偏移量*/
#define TX_LOGO_1X1        0  /*对应TX_PRINT_LOGO*/
#define TX_LOGO_1X2        1  /*203x101*/
#define TX_LOGO_2X1        2  /*101x203*/
#define TX_LOGO_2X2        3  /*101x101*/
#define TX_BAR_FONT_NONE   0  /*对应TX_BARCODE_FONT*/
#define TX_BAR_FONT_UP     1
#define TX_BAR_FONT_DOWN   2
#define TX_BAR_FONT_BOTH   3
/**@}*/

/** 条码类型 */
/**@{*/
#define TX_BAR_UPCA        65
#define TX_BAR_UPCE        66
#define TX_BAR_EAN13       67
#define TX_BAR_EAN8        68
#define TX_BAR_CODE39      69
#define TX_BAR_ITF         70
#define TX_BAR_CODABAR     71
#define TX_BAR_CODE93      72
#define TX_BAR_CODE128     73
/**@}*/

/** 串口设置 */
/**@{*/
#define TX_SER_BAUD_MASK   0xFF000000 /* 波特率 */
#define TX_SER_BAUD9600    0x00000000
#define TX_SER_BAUD19200   0x01000000
#define TX_SER_BAUD38400   0x02000000
#define TX_SER_BAUD57600   0x03000000
#define TX_SER_BAUD115200  0x04000000
#define TX_SER_DATA_MASK   0x00FF0000 /* 数据位 */
#define TX_SER_DATA_8BITS  0x00000000
#define TX_SER_DATA_7BITS  0x00010000
#define TX_SER_PARITY_MASK 0x0000FF00 /* 校验 */
#define TX_SER_PARITY_NONE 0x00000000
#define TX_SER_PARITY_EVEN 0x00000100
#define TX_SER_PARITY_ODD  0x00000200
#define TX_SER_STOP_MASK   0x000000F0 /* 停止位 */
#define TX_SER_STOP_1BITS  0x00000000
#define TX_SER_STOP_15BITS 0x00000010
#define TX_SER_STOP_2BITS  0x00000020
#define TX_SER_FLOW_MASK   0x0000000F /* 流控制 */
#define TX_SER_FLOW_NONE   0x00000000
#define TX_SER_FLOW_HARD   0x00000001
#define TX_SER_FLOW_SOFT   0x00000002
/**@}*/

/** QR码纠错等级 */
/**@{*/
#define TX_QR_ERRLEVEL_L   0x31
#define TX_QR_ERRLEVEL_M   0x32
#define TX_QR_ERRLEVEL_Q   0x33
#define TX_QR_ERRLEVEL_H   0x34
/**@}*/


/** 在非Windows系统，补充定义 */
/**@{*/
#ifndef BOOL
#define BOOL int
#endif
#ifndef WINAPI
#define WINAPI
#endif
#ifndef DWORD
#define DWORD unsigned long
#endif
#ifndef DWORD_PTR
#define DWORD_PTR unsigned long
#endif
#ifndef WORD
#define WORD unsigned short
#endif
#ifndef BYTE
#define BYTE unsigned char
#define LPBYTE BYTE*
#endif
/**@}*/

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief 连接打印机。需在所有函数前执行。
 * @param Type  : TX_TYPE_XXX
 * @param Idx   : 从0开始
 * @return 操作是否成功
 */
BOOL WINAPI TxOpenPrinter(DWORD Type, DWORD_PTR Idx);

/**
 * @brief 输出指定的缓冲
 * @param buf  : 为缓冲区指针
 * @param len  : 为缓冲区长度
 * @return 操作是否成功
 */
BOOL WINAPI TxWritePrinter(const char* buf, DWORD len);

/**
 * @brief 从打印机读取数据
 * @param buf  : 为接收缓冲
 * @param len  : 为欲读取的字节数
 * @return 返回实际的字节数
 */
DWORD WINAPI TxReadPrinter(char* buf, DWORD len);

/**
 * @brief 获取打印机状态
 * @return 返回值为TX_STAT_XXXX，调用失败则为0。
 * 当类型为TX_TYPE_MEM时，返回内部数据长度。
 */
DWORD WINAPI TxGetStatus();

/**
 * @brief 与TxGetStatus类似，区别是USB接口通过指令查询状态。
 * @return 与TxGetStatus相同
 */
DWORD WINAPI TxGetStatus2();

/**
 * @brief 关闭连接
 */
void WINAPI TxClosePrinter();

/**
 * @brief 发送初始化指令
 */
void WINAPI TxInit();

/**
 * @brief 输出字符串（以\0结束）
 * @param str  : 字符串
 */
void WINAPI TxOutputString(char* str);

/**
 * @brief 输出回车、换行
 */
void WINAPI TxNewline();

/**
 * @brief 输出字符串（以\0结束），并自动添加回车、换行
 * @param str  : 字符串
 */
void WINAPI TxOutputStringLn(char* str);

/**
 * @brief 执行特殊功能。
 * @param func  : 功能类型
 * @param param1  : 参数一
 * @param param2  : 参数二
 * @note 有的功能需要传入两个参数，有的功能只需要一个参数（param2=0）。
 */
void WINAPI TxDoFunction(DWORD func, int param1, int param2);

/**
 * @brief 恢复字体效果（大小、粗体等）为原始状态。
 */
void WINAPI TxResetFont();


/**
 * @brief 打印条码
 * @param type  : 条码类型
 * @param str  : 条码内容
 * @return 操作是否成功
 */
BOOL WINAPI TxPrintBarcode(DWORD type, char* str);

/**
 * @brief 打印图形文件
 * @param path  : 图形文件完整路径
 * @return 操作是否成功
 */
BOOL WINAPI TxPrintImage(const char* path);

/**
 * @brief 设置串口参数
 * @param attr  : 属性组合
 */
void WINAPI TxSetupSerial(DWORD attr);

/**
 * @brief 打印QR码
 * @param data  : 内容指针
 * @param len  : 内容长度
 */
void WINAPI TxPrintQRcode(const char *data, WORD len);

#ifdef __cplusplus
}
#endif
