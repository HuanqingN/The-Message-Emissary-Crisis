package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;

/**µãÉä**/
public class Skill73 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() || launchCount>=1)return false;
		if(blueSkillCheck()){
			for(Player p:bf.roleSeq){
					if(p.blackCards.size()>0 || p.redCards.size()>0 || p.blueCards.size()>0)return true;
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
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		
		bf.waitfor(3000);
		
		Player target=bf.roleMap.get(tvo.target);
		Card card=bf.cardsMap.get(tvo.card);
		
		
		bf.usedCardStack.removeLast();
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(card);
		bf.Burn(target.getUid(), temp);
	}
	
}
