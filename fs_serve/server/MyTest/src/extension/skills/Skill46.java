package extension.skills;

import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**º”√‹**/
public class Skill46 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && bf.nowPlayer.getUid()==getOwner().getUid() && bf.thirdStep!=StepCons.Victory){
			if(bf.nowStep==StepCons.InfoSend)return true;
		}
		return false;
	}

	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		getOwner().skillhash.get(this.id).launchCount++;
		bf.waitfor(3000);
		bf.sendingcard.security=true;
		for(Object t:bf.usedCardStack){
			if(t instanceof TargetVO){
				if(((TargetVO)t).sid==0 && (((TargetVO)t).cid==6 || ((TargetVO)t).cid==10))((TargetVO)t).disabled=true;
			}
		}
		bf.usedCardStack.removeLast();
	}
	
}
