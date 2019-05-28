
#define WM_DecodeSucess     WM_USER+123
#define WM_ReleaseCamera    WM_USER+124


#if defined(_WIN64)

#define DLL_DEBUG 1
#define DLL_EXPORT __declspec(dllexport) 
#define DLL_IMPORT __declspec(dllimport)
#define  WM_DecodeSucess  WM_USER+123
#define WM_ReleaseCamera  WM_USER+124


extern "C"{
extern DLL_EXPORT void GetAppHandle(HWND hParent);
extern DLL_EXPORT int StartDevice();
extern DLL_EXPORT void ReleaseDevice();
extern DLL_EXPORT void ReleaseLostDevice();
extern DLL_EXPORT int GetDecodeString(char *aa,int &len);
extern DLL_EXPORT int GetDevice();

extern DLL_EXPORT void setQRable(bool able);
extern DLL_EXPORT void setBarcode(bool able);
extern DLL_EXPORT void setDMable(bool able);
;extern DLL_EXPORT void setHXable(bool able);
extern DLL_EXPORT void setPDF417able(bool able);

extern DLL_EXPORT void SetLed(BOOL bctrLed);
extern DLL_EXPORT void SetBeep(BOOL bctrlBeep);
extern DLL_EXPORT void SetBeepTime(int ibeepTime);

 extern DLL_EXPORT int StartDevice_Preview(HWND hwndPreview);
  extern DLL_EXPORT void LedTimeControl(int iTime);
  extern DLL_EXPORT void LedControl();
  extern DLL_EXPORT void SetLedMode(int iMode);

//;驱动接口
extern DLL_EXPORT void setColor(int icolor);
extern DLL_EXPORT void setMirror(int imirror);
extern DLL_EXPORT void SetBrightness(int iBrightness);
extern DLL_EXPORT void SetContrast(int iContrast);
extern DLL_EXPORT void SetSharpness(int iSharpness); 
extern DLL_EXPORT void SetGamma(int iGamma);
extern DLL_EXPORT void SetWhiteBalance(int iWhiteBalance);
extern DLL_EXPORT void SetSaturation(int iSaturation);
extern DLL_EXPORT void SetExposure(int iExposure);
extern DLL_EXPORT void SetHue(int iHue);
extern DLL_EXPORT void SoundLong();
extern DLL_EXPORT void Set_Capture(BOOL bcapture);

//;驱动接口


};


#else

void GetAppHandle(HWND hParent);
void ReleaseLostDevice();
void ReleaseDevice();
int StartDevice();
int GetDevice();
void  SetLed(bool bctrLed);
void  SetBeep(bool bctrlBeep);
void SetBeepTime(int BeepTime);
void  setQRable(bool bqr);
void  setDMable(bool bdm);
void  setBarcode(bool bbarcode);
int  GetDecodeString(char *aa,int &len);

#endif