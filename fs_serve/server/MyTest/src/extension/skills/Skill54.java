package extension.skills;

import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 *ÑÏÐÌ
 */
public class Skill54 extends Skill {

	@Override
	public Boolean check() {
		return (bf.thirdStep==StepCons.TestingSuccess && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowPlayer==getOwner());
	}
	@Override
	public void reset() {
	}
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(3000);
		LinkedList<Card> temp=new LinkedList<Card>();
		Player target=bf.roleMap.get(((TargetVO)bf.nowSettlement).target);
		temp.addAll(target.handcards);
		bf.disCard(target,temp, 1, null);
		bf.waitfor(2000);
	}
	
}
