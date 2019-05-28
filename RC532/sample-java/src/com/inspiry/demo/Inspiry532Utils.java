package com.inspiry.demo;


import com.inspiry.api.InspiryDeviceAPIFor532;
import com.sun.jna.ptr.IntByReference;

public class Inspiry532Utils {
	
	/**
	 * inspiry_532 设备初始化
	 * 
	 * @return 1.成功 2.失败
	 */
	public static int initInspiry532(){
		if(InspiryDeviceAPIFor532.INSTANCE.GetDevice() == 1){
			System.out.println("成功获取设备");
			int startDeviceState =  InspiryDeviceAPIFor532.INSTANCE.StartDevice();
			if(startDeviceState == 1){
				System.out.println("设备启动成功");
				InspiryDeviceAPIFor532.INSTANCE.SetLed(true);
				InspiryDeviceAPIFor532.INSTANCE.setQRable(true);
				InspiryDeviceAPIFor532.INSTANCE.setDMable(true);
				InspiryDeviceAPIFor532.INSTANCE.setBarcode(true);
				InspiryDeviceAPIFor532.INSTANCE.SetBeepTime(300);
				System.out.println("设备初始化完成");
				return 1;
			}
		}else {
			System.out.println("设备获取失败");
		}
		return 0;
	}
	
	/**
	 * 获取解码信息
	 * 
	 * @return
	 */
	public static String getDecodeString(){
		InspiryDeviceAPIFor532.INSTANCE.SetLed(false);
		InspiryDeviceAPIFor532.INSTANCE.setQRable(false);
		InspiryDeviceAPIFor532.INSTANCE.setDMable(false);
		
		byte Decodes[] = new byte[512];
		IntByReference lengthRe = new IntByReference(); 
		InspiryDeviceAPIFor532.INSTANCE.GetDecodeString(Decodes,lengthRe);
		System.out.println("二维码数据长度：" + lengthRe.getValue());
		String decodeString = new String(Decodes,0,lengthRe.getValue()) ;
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		InspiryDeviceAPIFor532.INSTANCE.SetLed(true);
		InspiryDeviceAPIFor532.INSTANCE.setQRable(true);
		InspiryDeviceAPIFor532.INSTANCE.setDMable(true);
		
		return decodeString;
	}
		
	public static void ReleaseDevice(){
		InspiryDeviceAPIFor532.INSTANCE.ReleaseDevice();
	}
}
