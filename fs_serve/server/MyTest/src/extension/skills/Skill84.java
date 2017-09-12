package extension.skills;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *ǿԮ
 */
public class Skill84 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer==getOwner() && bf.thirdStep!=StepCons.Victory){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1500);
		Player target=bf.roleMap.get(tvo.target);
		bf.drawCard(target,bf.getCardFromCardPack(getOwner().blackCards.size()), 1, null);
	}
	
}
