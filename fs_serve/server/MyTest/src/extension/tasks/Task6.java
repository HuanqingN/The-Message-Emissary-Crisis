package extension.tasks;

import it.gotoandplay.smartfoxserver.SmartFoxServer;

/**
 *获得三张或以上的蓝情报
 */
public class Task6 extends TaskBase{

	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return owner.blueCards.size()>=3;
		}
		return false;
	}

}
