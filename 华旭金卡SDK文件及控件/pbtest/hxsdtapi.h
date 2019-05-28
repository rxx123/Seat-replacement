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
__declspec( dllexport) int PASCAL HX_SDT_GetCOMBaud(int iComID, int *puiBaud);
__declspec( dllexport) int PASCAL HX_SDT_SetCOMBaud(int iComID, int  uiCurrBaud, int  uiSetBaud);
__declspec( dllexport) int PASCAL HX_SDT_OpenPort(int iPortID);
__declspec( dllexport) int PASCAL HX_SDT_ClosePort(int iPortID);

/**********************************************************
 ********************** SAM类API **************************
 **********************************************************/
__declspec( dllexport) int PASCAL HX_SDT_GetSAMStatus(int iPortID,int iIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_ResetSAM(int iPortID,int iIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_SetMaxRFByte(int iPortID, char ucByte,int bIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_GetSAMID(int iPortID, char *pucSAMID,int iIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_GetSAMIDToStr(int iPortID,char *pcSAMID,int iIfOpen);

/**********************************************************
 ******************* 身份证卡类API ************************
 **********************************************************/
__declspec( dllexport) int PASCAL HX_SDT_StartFindIDCard(int iPortID, char *pucManaInfo,int iIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_SelectIDCard(int iPortID, char *pucManaMsg,int iIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_ReadBaseMsg(int iPortID, char * cName, char * cSex,
													  char * cFolk, char * cBirth, char * cAddress,
													  char * cIDNu, char * cSignDepart, char * cUseLife,
													 int * puiCHMsgLen, char * pucPHMsg, int *puiPHMsgLen,int iIfOpen)
__declspec( dllexport) int PASCAL HX_SDT_ReadMngInfo(int iPortID, char * pucManageMsg,int iIfOpen);
__declspec( dllexport) int PASCAL HX_SDT_ReadNewAppMsg(int iPortID, char * pucAppMsg, int *	puiAppMsgLen,int iIfOpen);


#ifdef __cplusplus
}
#endif 
#endif