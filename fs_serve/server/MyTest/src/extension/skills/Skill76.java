package extension.skills;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 *«π¡÷µØ”Í
 */
public class Skill76 extends Skill {

	@Override
	public Boolean check() {
		if(selfturn() && noInforeceive()){
			for(Card card:getOwner().handcards){
				if(card.getSend()==2)return true;
			}
		}
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
		c.setColor(2);
		c.setId(8);

		TargetVO tvo1=new TargetVO();
		tvo1.sponsor=getOwner().getUid();
		tvo1.cvid=c.getVid();
		bf.usedCardStack.removeLast();
		bf.useCard=tvo1;
		bf.CardLaunch();
	}
	
}
