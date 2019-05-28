#ifdef  _WIN32
#define STDCALL  __stdcall
#else
#define STDCALL
#endif
#ifndef SDTAPI_
#define SDTAPI_
#ifdef __cplusplus
extern "C"{
#endif 
/**********************************************************
 ********************** 端口类API *************************
 **********************************************************/
int STDCALL SDT_GetCOMBaud(int iComID,unsigned int *puiBaud);
int STDCALL SDT_SetCOMBaud(int iComID,unsigned int  uiCurrBaud,unsigned int  uiSetBaud);
int STDCALL SDT_OpenPort(int iPortID);
int STDCALL SDT_ClosePort(int iPortID);

/**********************************************************
 ********************** SAM类API **************************
 **********************************************************/
int STDCALL SDT_GetSAMStatus(int iPortID,int iIfOpen);
int STDCALL SDT_ResetSAM(int iPortID,int iIfOpen);
int STDCALL SDT_SetMaxRFByte(int iPortID,unsigned char ucByte,int bIfOpen);
int STDCALL SDT_GetSAMID(int iPortID,unsigned char *pucSAMID,int iIfOpen);
int STDCALL SDT_GetSAMIDToStr(int iPortID,char *pcSAMID,int iIfOpen);

/**********************************************************
 ******************* 身份证卡类API ************************
 **********************************************************/
int STDCALL SDT_StartFindIDCard(int iPortID,unsigned char *pucManaInfo,int iIfOpen);
int STDCALL SDT_SelectIDCard(int iPortID,unsigned char *pucManaMsg,int iIfOpen);
int STDCALL SDT_ReadBaseMsg(int iPortID,unsigned char * pucCHMsg,unsigned int *	puiCHMsgLen,unsigned char * pucPHMsg,unsigned int  *puiPHMsgLen,int iIfOpen);
int STDCALL SDT_ReadMngInfo(int iPortID,unsigned char * pucManageMsg,int iIfOpen);
int STDCALL SDT_ReadNewAppMsg(int iPortID,unsigned char * pucAppMsg,unsigned int *	puiAppMsgLen,int iIfOpen);


#ifdef __cplusplus
}
#endif 
#endif