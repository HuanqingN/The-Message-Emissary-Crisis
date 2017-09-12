package extension.tasks;

/**
 *获得三张或以上的红情报
 */
public class Task7 extends TaskBase{

	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return owner.redCards.size()>=3;
		}
		return false;
	}

}
