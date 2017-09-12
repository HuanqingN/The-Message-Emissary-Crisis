package extension.controller;

import java.nio.channels.SocketChannel;
import java.util.LinkedList;

import extension.cons.SystemInfoType;
import extension.controller.RoomController.RoomCtrl;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class RoomController extends BaseController {
	private AbstractExtension ext=null;
	public enum RoomCtrl{
		ErrorInfo(3,11),OnBagUpdata(3,13),OnMoneyUpdata(3,14);
		private int handerIndex;
		private int functionIndex;
		private RoomCtrl(int value1,int value2){
			this.setHanderIndex(value1);
			this.setFunctionIndex(value2);
		}
		public int getHanderIndex() {
			return handerIndex;
		}
		public void setHanderIndex(int handerIndex) {
			this.handerIndex = handerIndex;
		}
		public int getFunctionIndex() {
			return functionIndex;
		}
		public void setFunctionIndex(int functionIndex) {
			this.functionIndex = functionIndex;
		}
	}
	public RoomController(AbstractExtension ae){
		ext=ae;
	}
	public void send(RoomCtrl rc,ActionscriptObject resp,User u) {
		resp.putNumber("h",rc.getHanderIndex());
		resp.putNumber("f",rc.getFunctionIndex());
		LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
		rec.add(u.getChannel());
		ext.sendResponse(resp, -1, u,rec);
	}
	public void send(RoomCtrl rc,int errCode,User u) {
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",rc.getHanderIndex());
		resp.putNumber("f",rc.getFunctionIndex());
		resp.putNumber("type",errCode);
		LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
		rec.add(u.getChannel());
		ext.sendResponse(resp, -1, u,rec);
	}
}
