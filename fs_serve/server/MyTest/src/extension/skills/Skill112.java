package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *忠心耿耿 一张已公开的黑情报即将被接收时，可以抽一张牌，将其放置在自己面前
 */
public class Skill112 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==StepCons.RecieveNowInfo && bf.sendingcard.shared && bf.sendingcard.getColor()>2)return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1500);
		bf.drawCard(getOwner(),bf.getCardFromCardPack(1),1,null);
		bf.waitfor(1500);
		bf.sendTarget=getOwner();
	}
	
}
