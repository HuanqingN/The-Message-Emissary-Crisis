package extension.tasks;
/**
 *获得五张或以上的红蓝情报
 */
public class Task17 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return (owner.redCards.size()+owner.blueCards.size())>=5;
		}
		return false;
	}
}
