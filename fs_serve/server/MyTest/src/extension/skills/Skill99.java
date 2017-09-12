package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *¶·×ªÐÇÒÆ
 */
public class Skill99 extends Skill {

	public Skill99(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==true && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner() && !getOwner().getIsDead() && bf.thirdStep!=StepCons.Victory){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(false);
		playAni(false);
		bf.waitfor(1500);
	}
}
