import com.tx.Const;
import com.tx.Printer;

public class Demo{
	static public void main(String[] args){
		final Printer ptr = new Printer();
		if(ptr.open(Const.TX_TYPE_COM, 0)){
			ptr.setupSerial(Const.TX_SER_BAUD38400|Const.TX_SER_DATA_8BITS
				|Const.TX_SER_PARITY_NONE|Const.TX_SER_STOP_1BITS|Const.TX_SER_FLOW_HARD);
			System.out.println("open printer success");
			int a = ptr.getStatus();
			System.out.println(String.format("status=%X\n", a));
			ptr.init();
			ptr.doFunction(Const.TX_FONT_ULINE, Const.TX_ON, 0);
			ptr.outputStringLn("This is Font A with underline.");
			ptr.doFunction(Const.TX_SEL_FONT, Const.TX_FONT_B, 0);
			ptr.doFunction(Const.TX_FONT_ULINE, Const.TX_OFF, 0);
			ptr.doFunction(Const.TX_FONT_BOLD, Const.TX_ON, 0);
			ptr.outputStringLn("This is Font B with bold.");
			ptr.resetFont();
			ptr.doFunction(Const.TX_ALIGN, Const.TX_ALIGN_CENTER, 0);
			ptr.outputStringLn("center");
			ptr.doFunction(Const.TX_ALIGN, Const.TX_ALIGN_RIGHT, 0);
			ptr.outputStringLn("right");
			ptr.doFunction(Const.TX_ALIGN, Const.TX_ALIGN_LEFT, 0);
			ptr.doFunction(Const.TX_FONT_ROTATE, Const.TX_ON, 0);
			ptr.outputStringLn("left & rotating");
			ptr.resetFont();
			ptr.doFunction(Const.TX_CHINESE_MODE, Const.TX_ON, 0);
			ptr.outputStringLn("中文");
			ptr.doFunction(Const.TX_FONT_SIZE, Const.TX_SIZE_3X, Const.TX_SIZE_2X);
			ptr.doFunction(Const.TX_UNIT_TYPE, Const.TX_UNIT_MM, 0);
			ptr.doFunction(Const.TX_HOR_POS, 20, 0);
			ptr.outputStringLn("放大Abc");
			ptr.resetFont();
			ptr.doFunction(Const.TX_FEED, 30, 0);
			ptr.outputStringLn("feed 30mm");
			ptr.doFunction(Const.TX_BARCODE_HEIGHT, 15, 0);
			ptr.printBarcode(Const.TX_BAR_UPCA, "12345678901");
			ptr.printImage("a1.png");
			ptr.doFunction(Const.TX_UNIT_TYPE, Const.TX_UNIT_PIXEL, 0);
			ptr.doFunction(Const.TX_FEED, 140, 0);
			ptr.doFunction(Const.TX_CUT, Const.TX_CUT_FULL, 0);
			ptr.close();
		}
	}
}
