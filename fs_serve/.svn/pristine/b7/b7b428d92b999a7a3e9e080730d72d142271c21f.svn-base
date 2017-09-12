package extension.tasks;

/**
 *当一位男性宣告胜利时，你获得的黑情报少于等于一张
 */
public class Task8 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.victoryMan!=null && bf.victoryMan.sex>=1){
			return owner.blackCards.size()==0;
		}
		return super.check();
	}

}
