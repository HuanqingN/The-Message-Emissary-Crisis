package extension.skills;

import extension.cards.ACard;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**ªª»’**/
public class Skill12 extends Skill {

	@Override
	public Boolean check() {
		if(selfturn() && noSkill() && isAnswer()){
			if(bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2 ||  bf.nowStep==StepCons.InfoSend){
				if(hasCardColor(6,getOwner()))return true;
			}
		}
//		if(selfturn() && noInforeceive()){
//			if(hasCardColor(6,getOwner()))return true;
//		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		
		bf.waitfor(1000);
		Card c=bf.cardsMap.get(tvo.card);
		c.orgColor=c.getColor();
		c.orgId=c.getId();
		c.setColor(3);
		c.setId(1);
		
		TargetVO tvo1=new TargetVO();
		tvo1.sponsor=getOwner().getUid();
		tvo1.target=tvo.target;
		tvo1.cvid=c.getVid();
		bf.usedCardStack.removeLast();
		bf.useCard=tvo1;
		bf.CardLaunch();
	}
	
}
