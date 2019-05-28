package com.inspiry.api;

import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.ptr.IntByReference;

/**
 * Inspiry_532 Java API
 * @author hao123yinlong
 *
 */
public interface InspiryDeviceAPIFor532 extends Library {
	/**
	 * 启动设备
	 * 
	 * @return
	 * 
	 * 	1 设备启动成功, -1 设备启动, -2 没有找到设备, -3 设备初始化失败
	 */
	public abstract int StartDevice(); 
	
	/**
	 * 查找设备
	 * 
	 * 
	 * @return
	 * 
	 *  1，表示查找设备成功,  -1，表示查找设备失败
	 * 	
	 */
	public abstract int GetDevice();
	
	/**
	 * 释放摄像头
	 */
	public abstract void ReleaseDevice();
	
	/**
	 *  人为拔出设备时，需要释放的摄像头资源
	 */
	public abstract void ReleaseLostDevice();
	
	/**
	 * 设置LED灯的开启关闭
	 * 
	 * @param bctrLed	true时，LED开启；false时,LED关闭 ,默认true
	 */
	public abstract void  SetLed(Boolean bctrLed);
	
	/**
	 * 设置蜂鸣器的开启关闭
	 * 
	 * @param bctrlBeep  true时，蜂鸣开启；false时,蜂鸣关闭 ,默认true
	 */
	public abstract void  SetBeep(Boolean bctrlBeep);
	
	/**
	 * 设定解码成功后的蜂鸣时间
	 * 
	 * @param BeepTime
	 */
	public abstract void SetBeepTime(int BeepTime);
	
	/**
	 * 设置QR引擎状态
	 * 
	 * @param bqr true时，qr引擎开启；false时qr引擎关闭 .默认为 false
	 */
	public abstract void  setQRable(Boolean bqr);
	
	/**
	 * 设置DM引擎状态
	 * 
	 * @param bdm true时，dm引擎开启；false时dm引擎关闭 。默认为 false
	 */
	public abstract void  setDMable(Boolean bdm);
	
	/**
	 * 设置一维引擎状态
	 * 
	 * @param bbarcode true时，一维引擎开启；false时一维引擎关闭
	 */
	public abstract void  setBarcode(Boolean bbarcode);
	
	/**
	 *  获取解码信息
	 * 
	 * @param decodeString 获取解码信息的指针
	 * @param length	长度
	 */
	public abstract void  GetDecodeString(byte[] decodeString , IntByReference length);
	
	
	InspiryDeviceAPIFor532 INSTANCE = (InspiryDeviceAPIFor532) Native.loadLibrary("dll_camera.dll", InspiryDeviceAPIFor532.class);  
	
}
