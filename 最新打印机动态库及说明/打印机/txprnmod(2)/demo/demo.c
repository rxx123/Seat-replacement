#if defined(_WINDOWS) || defined(WIN32)
#include <windows.h>
#include <tchar.h>
#else
#define _tmain main
#define __cdecl
#endif
#include <stdio.h>
#include "export.h"

void do_print(DWORD type)
{
	DWORD a;
	//char *p;
	//FILE *fp;
	if(TxOpenPrinter(type,0))
	{
		if(TX_TYPE_COM==type)
			TxSetupSerial(TX_SER_BAUD38400|TX_SER_DATA_8BITS|TX_SER_PARITY_NONE|TX_SER_STOP_1BITS|TX_SER_FLOW_HARD);
		printf("open printer success\n");
		a=TxGetStatus();
		printf("status=%lXh\n",a);
#if 1
		TxInit();
		TxDoFunction(TX_FONT_ULINE,TX_ON,0);
		TxOutputStringLn("This is Font A with underline.");
		TxDoFunction(TX_SEL_FONT,TX_FONT_B,0);
		TxDoFunction(TX_FONT_ULINE,TX_OFF,0);
		TxDoFunction(TX_FONT_BOLD,TX_ON,0);
		TxOutputStringLn("This is Font B with bold.");
		TxResetFont();
		TxDoFunction(TX_ALIGN,TX_ALIGN_CENTER,0);
		TxOutputStringLn("center");
		TxDoFunction(TX_ALIGN,TX_ALIGN_RIGHT,0);
		TxOutputStringLn("right");
		TxDoFunction(TX_ALIGN,TX_ALIGN_LEFT,0);
		TxDoFunction(TX_FONT_ROTATE,TX_ON,0);
		TxOutputStringLn("left & rotating");
		TxResetFont();
		TxDoFunction(TX_CHINESE_MODE,TX_ON,0);
		TxOutputStringLn("����");
		TxDoFunction(TX_FONT_SIZE,TX_SIZE_3X,TX_SIZE_2X);
		TxDoFunction(TX_UNIT_TYPE,TX_UNIT_MM,0);
		TxDoFunction(TX_HOR_POS,20,0);
		TxOutputStringLn("�Ŵ�Abc");
		TxResetFont();
		TxDoFunction(TX_FEED,30,0);
		TxOutputStringLn("feed 30mm");
		TxDoFunction(TX_BARCODE_HEIGHT,15,0);
		TxPrintBarcode(TX_BAR_UPCA,"12345678901");
		TxPrintImage("a1.png");
		TxDoFunction(TX_UNIT_TYPE,TX_UNIT_PIXEL,0);
		TxDoFunction(TX_FEED,140,0);
		TxDoFunction(TX_CUT,TX_CUT_FULL,0);
		//a=TxGetStatus();
		//printf("status=%u\n", a);
		//p=malloc(a);
		//TxReadPrinter(p,a);
		//fp=fopen("dump","wb");
		//fwrite(p,1,a,fp);
		//free(p);
		TxDoFunction(TX_QR_DOTSIZE,6,0);
		TxDoFunction(TX_QR_ERRLEVEL,TX_QR_ERRLEVEL_M,0);
		TxPrintQRcode("ABCD",4);
#endif
		TxClosePrinter();
	}
	else
		printf("open printer failure\n");
}

int __cdecl _tmain(int argc, char* argv[])
{
	int in;
	puts("select one port to output:");
	puts("1. USB");
	puts("2. LPT");
	puts("3. COM (38400,8,N,1)");
	printf("choose: ");
	fflush(stdout);
	in=getchar();
	if('1'==in)
		do_print(TX_TYPE_USB);
	else if('2'==in)
		do_print(TX_TYPE_LPT);
	else if('3'==in)
		do_print(TX_TYPE_COM);
	//else if('4'==in)
	//	do_print(4);
	else
		puts("wrong selection!");
	return 0;
}
