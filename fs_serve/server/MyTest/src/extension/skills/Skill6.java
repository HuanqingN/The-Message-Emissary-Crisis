package extension.skills;

import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 *¶´Ï¤
 */
public class Skill6 extends Skill {
	
	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==true && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).sid==0 && ((TargetVO)bf.nowSettlement).disabled==false){
			int cindex=((TargetVO)bf.nowSettlement).cid;
			if(cindex==5)return true;
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
