package extension.skills;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *嫁祸：你的破译可以当做转移使用
 */
public class Skill96 extends Skill {

	@Override
	public Boolean check() {
		if(bf.subStep>0 || !noSkill())return false;
		if(bf.nowStep == StepCons.InfoArrive && bf.sendTarget==getOwner() && !bf.sendingcard.security && getOwner().getIsOpen()){
			if(!getOwner().getIsLock()){
				for(Card card:getOwner().handcards){
					if(card.getId()==5)return true;
				}
			}
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
		bf.waitfor(1000);
		Card c=bf.cardsMap.get(tvo.card);
		c.orgColor=c.getColor();
		c.orgId=c.getId();
		c.setId(9);

		TargetVO tvo1=new TargetVO();
		tvo1.sponsor=getOwner().getUid();
		tvo1.target=tvo.target;
		tvo1.cvid=c.getVid();
		bf.usedCardStack.removeLast();
		bf.useCard=tvo1;
		bf.CardLaunch();
	}
}
