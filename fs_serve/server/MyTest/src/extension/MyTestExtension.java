package extension;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;

import extension.serv.ServBase;
import extension.serv.ServBattle;
import extension.serv.ServRoom;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.events.InternalEventObject;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class MyTestExtension extends AbstractExtension {
	private String currZone;
	private Zone zone;
	private ExtensionHelper helper;
	public void init()
	{
		helper = ExtensionHelper.instance();
		currZone 	= this.getOwnerZone();
		zone		= helper.getZone(currZone);
		LoginValidate lv=(LoginValidate)zone.getExtension("login");
	}
	@Override
	public void handleRequest(String arg0, ActionscriptObject arg1, User arg2,
			int arg3) {

	}

	@Override
	public void handleRequest(String arg0, String[] arg1, User arg2, int arg3) {

	}

	@Override
	public void handleInternalEvent(InternalEventObject arg0) {

	}

}
