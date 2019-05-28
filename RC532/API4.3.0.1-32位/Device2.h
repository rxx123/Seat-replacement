#ifndef _DEVICE_2_H
#define _DEVICE_2_H

#define WM_DecodeSucess     WM_USER+123
#define WM_ReleaseCamera    WM_USER+124

void GetAppHandle(HWND hParent);//, HWND hChild=NULL); //hParent,父窗口，接收解码消息；hChild，子窗口，预览窗口
void ReleaseDevice();
void ReleaseLostDevice();
int  StartDevice();
void SetLed(int bctrLed);
void SetBeep(bool bctrlBeep);
void setQRable(bool bqr);
void setDMable(bool bdm);
void setBarcode(bool bbarcode);
void setPDF417(bool bEnable);
void setHXable(bool bhx);
int GetDecodeString(char *aa, int &len);
void SetDecodeTime(int idecodeTime);
void SetBeepTime(int nBeepTime);



#endif