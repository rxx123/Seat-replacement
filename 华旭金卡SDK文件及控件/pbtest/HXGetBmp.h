#define HXBMP_API __declspec(dllexport)

extern HXBMP_API int PASCAL HX_GetBmp(char * WLT_File, char * BMP_File, int intf);
/*
  ˵    �������������ڽ�wlt�ļ������bmp�ļ���
��    ����Wlt_File  ----- wlt�ļ���(��������·��)
          BMP_File  ----- ���ɵ�Bmp�ļ���(��������·��)
          intf       ----- �Ķ��豸ͨѶ�ӿ����ͣ�1-RS-232C��2-USB��
�� �� ֵ������
1	��Ƭ���������ȷ
0	����sdtapi.dll����
-1	��Ƭ�������
-2	wlt�ļ���׺����
-3	wlt�ļ��򿪴���
-4	wlt�ļ���ʽ����
-5	���δ��Ȩ
-6	�豸���Ӵ���
123 �ļ�������
ע������
1��	wlt�ļ��ĺ�׺Ҫ�̶�Ϊ".wlt",�磺xp.wlt��BMP�ļ��ĺ�׺Ҫ�̶�Ϊ".bmp"��
2��	������Ҫ��sdtapi.dll��WltRS.dll����ʹ��,��ȷ��ͨѶ�˿ڴ��ڹر�״̬��
 




*/
