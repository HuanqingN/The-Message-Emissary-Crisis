package extension.skills;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SkillVO;

/**µ¯Ò©ÎÞÏÞ**/
public class Skill28 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && getOwner().handcards.size()==0){
			if(noInforeceive())return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
		bf.waitfor(1000);
		excute();
	}
	@Override
	public void excute() {
		ArrayList<Card> cards=bf.getCardFromCardPack(2);
		bf.drawCard(getOwner(), cards, 1, null);
		bf.waitfor(1500);
		bf.usedCardStack.removeLast();
	}
}
