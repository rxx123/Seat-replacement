package com.inspiry.demo;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;

public class IndexFrame extends JFrame implements WindowListener{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private final Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
	
	private JButton putDataButton;
	
	private JButton delDataButton;
	
	private JTextArea dataTextArea;
	
	private int startDeviceState;
	
	
	public IndexFrame()
	{
	   super();
	   this.setBounds((screenSize.width - 400)/2, (screenSize.height - 300)/2, 400, 300);
	   this.addWindowListener(this);
	   this.getContentPane().setLayout(null);
	   this.add(getPutDataButton(),null);
	   this.add(getDelDataButton(),null);
	   this.add(getDataTextArea(),null);
	   this.setTitle("Inspiry_532 ");
	}
	
	private JButton getPutDataButton(){
		if(putDataButton == null){
			putDataButton = new JButton();
			putDataButton.setBounds(20, 20, 120, 30);
			putDataButton.setText("获取解码信息");
			putDataButton.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					String decodeString = Inspiry532Utils.getDecodeString().trim() ;
					if(decodeString != null && decodeString.length() >0){
						System.out.println("解码信息：" + decodeString + "长度：" + decodeString.length());
						dataTextArea.setText(decodeString);
						Inspiry532Utils.sleepNotifyEngine();
					}
				}
			});
		}
		return putDataButton;
	}
	
	private JButton getDelDataButton(){
		if(delDataButton == null){
			delDataButton = new JButton();
			delDataButton.setBounds(150, 20, 80, 30);
			delDataButton.setText("清除");
			delDataButton.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					dataTextArea.setText("");
				}
			});
		}
		return delDataButton;
	}
	
	private JTextArea getDataTextArea(){
		if(dataTextArea == null ){
			dataTextArea = new JTextArea();
			dataTextArea.setBounds(20, 60, 340, 150);
		}
		return dataTextArea;
	}




	@Override
	public void windowClosing(WindowEvent e) {
		Inspiry532Utils.ReleaseDevice();
		System.exit(0);  
		
	}

	/**
	 * 窗体打开后，获取设备并启动设备
	 * 
	 */
	@Override
	public void windowOpened(WindowEvent e) {
		Inspiry532Utils.initInspiry532();
	}
	
	/**
	 * 根据设备启动状态弹出提示信息
	 * 
	 * @param startDeviceState
	 */
	@SuppressWarnings("unused")
	private void showMessageDialogWithStartDeviceState(){
		switch (this.startDeviceState) {
		case 1:
			System.out.println("开启设备成功");
			break;
		case -1:
			JOptionPane.showMessageDialog(this, "设备已被启动");
			break;
		case -2:
			JOptionPane.showMessageDialog(this, "没有找到设备");
			break;
		case -3:
			JOptionPane.showMessageDialog(this, "设备初始化失败");
			break;

		default:
			break;
		}
	}

	@Override
	public void windowClosed(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowIconified(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowDeiconified(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowActivated(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowDeactivated(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	

	
}
