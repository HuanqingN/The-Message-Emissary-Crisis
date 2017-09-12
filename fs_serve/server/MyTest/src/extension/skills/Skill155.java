package extension.skills;

import extension.cards.ACard;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**
 * 解码：你手中的黑色密电可以当作破译使用
 */
public class Skill155 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead() || bf.subStep>0)return false;
		if(bf.nowStep == StepCons.InfoArrive && noSkill()){
			if(!bf.sendingcard.security && bf.sendTarget.getUid()==getOwner().getUid() &&getOwner().getIsOpen() && getOwner().handcards.size()>0){
				for(Card card:getOwner().handcards){
					if(card.getSend()==3 && card.getColor()>=3){//判断黑色密电
						return true;
					}
				}
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
		c.setColor(3);
		c.setId(5);

		TargetVO tvo1=new TargetVO();
		tvo1.sponsor=getOwner().getUid();
		tvo1.cvid=c.getVid();
		bf.usedCardStack.removeLast();
		bf.useCard=tvo1;
		bf.CardLaunch();
	}
	
}
