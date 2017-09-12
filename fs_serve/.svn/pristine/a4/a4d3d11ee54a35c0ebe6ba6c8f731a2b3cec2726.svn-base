package extension.serv;

import java.util.ArrayList;
import java.util.HashMap;

import extension.WUser;
import extension.manage.BattleCtrl;
import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.db.DbManager;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;

public class ServBase {
	private AbstractExtension ext;  //扩展类实例
	public Zone zone;				//地带
	public DbManager db;
	public ArrayList<Object> so;    //
	public HashMap<Integer, WUser> users;
	public HashMap<Room,Object> getRoomhash(){
		return (HashMap<Room,Object>)so.get(0);
	}
	public HashMap<Integer,BattleCtrl> getBlist(){
		return (HashMap<Integer,BattleCtrl>)so.get(1);
	}
	public AbstractExtension getExt() {
		return ext;
	}
	public void setExt(AbstractExtension ext) {
		this.ext = ext;
	}
}
