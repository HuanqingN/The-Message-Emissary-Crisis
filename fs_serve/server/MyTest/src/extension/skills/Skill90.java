package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *隐踪匿迹：你的回合开始时，盖伏此角色牌
 */
public class Skill90 extends Skill {
	public Skill90(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(getOwner().getIsOpen() && getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && bf.nowStep==StepCons.StepBegin)return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		tvo.sponsor=getOwner().getUid();
		getOwner().setIsOpen(false);
		playAni(false);
		bf.waitfor(2000);
	}
	
}
