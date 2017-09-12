package extension.tasks;
/**
 *获得四张或以上的红情报，或者四张或以上的蓝情报
 */
public class Task25 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return (owner.blueCards.size()>=4 || owner.redCards.size()>=4);
		}
		return super.check();
	}
}
