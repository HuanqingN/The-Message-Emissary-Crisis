package extension.skills;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 *·´»÷
 */
public class Skill66 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() || launchCount>=1)return false;
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor!=getOwner().getUid()){
			int cindex=((TargetVO)bf.nowSettlement).cid;
			if(cindex==4)return true;
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
		((TargetVO)bf.nowSettlement).disabled=true;
		((TargetVO)bf.nowSettlement).moveto=getOwner().getUid();		
		getOwner().addToHand(bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid));
	}
	
}
