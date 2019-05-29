/** TxOpenPrinter�ĵ�һ������ */
/**@{*/
#define TX_TYPE_NONE       0
#define TX_TYPE_USB        1
#define TX_TYPE_LPT        2
#define TX_TYPE_COM        3
#define TX_TYPE_MEM        4
#define TX_TYPE_FD         5
/**@}*/

/** ��ӡ��״̬ */
/**@{*/
#define TX_STAT_NOERROR    0x0008 /*�޹���*/
#define TX_STAT_SELECT     0x0010 /*��������״̬*/
#define TX_STAT_PAPEREND   0x0020 /*ȱֽ*/
#define TX_STAT_BUSY       0x0080 /*��æ*/
#define TX_STAT_DRAW_HIGH  0x0100
#define TX_STAT_COVER      0x0200
#define TX_STAT_ERROR      0x0400
#define TX_STAT_RCV_ERR    0x0800 /* Recoverable error */
#define TX_STAT_CUT_ERR    0x1000 /* Autocutter error */
#define TX_STAT_URCV_ERR   0x2000 /* Unrecoverable error */
#define TX_STAT_ARCV_ERR   0x4000 /* Auto-recoverable error */
#define TX_STAT_PAPER_NE   0x8000 /* paper near-end */
/**@}*/

/** TxDoFunction��func���� */
/**@{*/
#define TX_FONT_SIZE       1  /*�Ŵ�ϵ����0Ϊԭʼ��С��1Ϊ����1����������ƣ����Ϊ7������1Ϊ������2Ϊ��*/
#define TX_FONT_ULINE      2  /*�»���*/
#define TX_FONT_BOLD       3  /*����*/
#define TX_SEL_FONT        4  /*ѡ��Ӣ������*/
#define TX_FONT_ROTATE     5  /*��ת90��*/
#define TX_ALIGN           6  /*����ΪTX_ALIGN_XXX*/
#define TX_CHINESE_MODE    7  /*��������ģʽ*/
#define TX_FEED            10 /*ִ����ֽ*/
#define TX_UNIT_TYPE       11 /*���ö�����λ*/
#define TX_CUT             12 /*ִ����ֽ����һ����ָ�����ͣ��ڶ�����ָ����ֽǰ����ֽ����*/
#define TX_HOR_POS         13 /*����ˮƽ��λ*/
#define TX_LINE_SP         14 /*�����м��*/
#define TX_BW_REVERSE      15 /*��������ڰ׷�ת*/
#define TX_UPSIDE_DOWN     16 /*���õ��ô�ӡ*/
#define TX_INET_CHARS      17 /*ѡ������ַ���*/
#define TX_CODE_PAGE       18 /*ѡ���ַ������*/
#define TX_CH_ROTATE       19 /*�趨������ת*/
#define TX_CHK_BMARK       20 /*Ѱ�Һڱ�*/
#define TX_SET_BMARK       21 /*���úڱ����ƫ����*/
#define TX_PRINT_LOGO      22 /*��ӡ�����غõ�LOGO*/
#define TX_BARCODE_HEIGHT  23 /*�趨����߶�*/
#define TX_BARCODE_WIDTH   24 /*�趨������*/
#define TX_BARCODE_FONT    25 /*ѡ��HRI�ַ��Ĵ�ӡλ��*/
#define TX_FEED_REV        26 /*ִ��������ֽ*/
#define TX_QR_DOTSIZE      27 /*����QR��ĵ��С��2<param1<10*/
#define TX_QR_ERRLEVEL     28 /*����QR��Ľ���ȼ�*/
/**@}*/

/** TxDoFunction�Ĳ��������Ӧ���ܣ� */
/**@{*/
#define TX_ON              1
#define TX_OFF             0
#define TX_CUT_FULL        0  /*��ӦTX_CUT*/
#define TX_CUT_PARTIAL     1
#define TX_PURECUT_FULL    2  /*��ڱ��޹ص���ֽ*/
#define TX_PURECUT_PARTIAL 3
#define TX_FONT_A          0  /*��ӦTX_SEL_FONT*/
#define TX_FONT_B          1
#define TX_ALIGN_LEFT      0  /*��ӦTX_ALIGN*/
#define TX_ALIGN_CENTER    1
#define TX_ALIGN_RIGHT     2
#define TX_SIZE_1X         0  /*��ӦTX_FONT_SIZE*/
#define TX_SIZE_2X         1
#define TX_SIZE_3X         2
#define TX_SIZE_4X         3
#define TX_SIZE_5X         4
#define TX_SIZE_6X         5
#define TX_SIZE_7X         6
#define TX_SIZE_8X         7
#define TX_UNIT_PIXEL      0  /*��ӦTX_UNIT_TYPE*/
#define TX_UNIT_MM         1
#define TX_CH_ROTATE_NONE  0  /*��ӦTX_CH_ROTATE*/
#define TX_CH_ROTATE_LEFT  1
#define TX_CH_ROTATE_RIGHT 2
#define TX_BM_START        1  /*��ʼ��ӡλ������ںڱ���λ�õ�ƫ����*/
#define TX_BM_TEAR         2  /*��/˺ֽλ������ںڱ���λ�õ�ƫ����*/
#define TX_LOGO_1X1        0  /*��ӦTX_PRINT_LOGO*/
#define TX_LOGO_1X2        1  /*203x101*/
#define TX_LOGO_2X1        2  /*101x203*/
#define TX_LOGO_2X2        3  /*101x101*/
#define TX_BAR_FONT_NONE   0  /*��ӦTX_BARCODE_FONT*/
#define TX_BAR_FONT_UP     1
#define TX_BAR_FONT_DOWN   2
#define TX_BAR_FONT_BOTH   3
/**@}*/

/** �������� */
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

/** �������� */
/**@{*/
#define TX_SER_BAUD_MASK   0xFF000000 /* ������ */
#define TX_SER_BAUD9600    0x00000000
#define TX_SER_BAUD19200   0x01000000
#define TX_SER_BAUD38400   0x02000000
#define TX_SER_BAUD57600   0x03000000
#define TX_SER_BAUD115200  0x04000000
#define TX_SER_DATA_MASK   0x00FF0000 /* ����λ */
#define TX_SER_DATA_8BITS  0x00000000
#define TX_SER_DATA_7BITS  0x00010000
#define TX_SER_PARITY_MASK 0x0000FF00 /* У�� */
#define TX_SER_PARITY_NONE 0x00000000
#define TX_SER_PARITY_EVEN 0x00000100
#define TX_SER_PARITY_ODD  0x00000200
#define TX_SER_STOP_MASK   0x000000F0 /* ֹͣλ */
#define TX_SER_STOP_1BITS  0x00000000
#define TX_SER_STOP_15BITS 0x00000010
#define TX_SER_STOP_2BITS  0x00000020
#define TX_SER_FLOW_MASK   0x0000000F /* ������ */
#define TX_SER_FLOW_NONE   0x00000000
#define TX_SER_FLOW_HARD   0x00000001
#define TX_SER_FLOW_SOFT   0x00000002
/**@}*/

/** QR�����ȼ� */
/**@{*/
#define TX_QR_ERRLEVEL_L   0x31
#define TX_QR_ERRLEVEL_M   0x32
#define TX_QR_ERRLEVEL_Q   0x33
#define TX_QR_ERRLEVEL_H   0x34
/**@}*/


/** �ڷ�Windowsϵͳ�����䶨�� */
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
 * @brief ���Ӵ�ӡ�����������к���ǰִ�С�
 * @param Type  : TX_TYPE_XXX
 * @param Idx   : ��0��ʼ
 * @return �����Ƿ�ɹ�
 */
BOOL WINAPI TxOpenPrinter(DWORD Type, DWORD_PTR Idx);

/**
 * @brief ���ָ���Ļ���
 * @param buf  : Ϊ������ָ��
 * @param len  : Ϊ����������
 * @return �����Ƿ�ɹ�
 */
BOOL WINAPI TxWritePrinter(const char* buf, DWORD len);

/**
 * @brief �Ӵ�ӡ����ȡ����
 * @param buf  : Ϊ���ջ���
 * @param len  : Ϊ����ȡ���ֽ���
 * @return ����ʵ�ʵ��ֽ���
 */
DWORD WINAPI TxReadPrinter(char* buf, DWORD len);

/**
 * @brief ��ȡ��ӡ��״̬
 * @return ����ֵΪTX_STAT_XXXX������ʧ����Ϊ0��
 * ������ΪTX_TYPE_MEMʱ�������ڲ����ݳ��ȡ�
 */
DWORD WINAPI TxGetStatus();

/**
 * @brief ��TxGetStatus���ƣ�������USB�ӿ�ͨ��ָ���ѯ״̬��
 * @return ��TxGetStatus��ͬ
 */
DWORD WINAPI TxGetStatus2();

/**
 * @brief �ر�����
 */
void WINAPI TxClosePrinter();

/**
 * @brief ���ͳ�ʼ��ָ��
 */
void WINAPI TxInit();

/**
 * @brief ����ַ�������\0������
 * @param str  : �ַ���
 */
void WINAPI TxOutputString(char* str);

/**
 * @brief ����س�������
 */
void WINAPI TxNewline();

/**
 * @brief ����ַ�������\0�����������Զ���ӻس�������
 * @param str  : �ַ���
 */
void WINAPI TxOutputStringLn(char* str);

/**
 * @brief ִ�����⹦�ܡ�
 * @param func  : ��������
 * @param param1  : ����һ
 * @param param2  : ������
 * @note �еĹ�����Ҫ���������������еĹ���ֻ��Ҫһ��������param2=0����
 */
void WINAPI TxDoFunction(DWORD func, int param1, int param2);

/**
 * @brief �ָ�����Ч������С������ȣ�Ϊԭʼ״̬��
 */
void WINAPI TxResetFont();


/**
 * @brief ��ӡ����
 * @param type  : ��������
 * @param str  : ��������
 * @return �����Ƿ�ɹ�
 */
BOOL WINAPI TxPrintBarcode(DWORD type, char* str);

/**
 * @brief ��ӡͼ���ļ�
 * @param path  : ͼ���ļ�����·��
 * @return �����Ƿ�ɹ�
 */
BOOL WINAPI TxPrintImage(const char* path);

/**
 * @brief ���ô��ڲ���
 * @param attr  : �������
 */
void WINAPI TxSetupSerial(DWORD attr);

/**
 * @brief ��ӡQR��
 * @param data  : ����ָ��
 * @param len  : ���ݳ���
 */
void WINAPI TxPrintQRcode(const char *data, WORD len);

#ifdef __cplusplus
}
#endif
