package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *Ê±¹ý¾³Ç¨
 */
public class Skill100 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && !getOwner().getIsDead()){
			if(bf.nowStep==StepCons.InfoReceive && bf.nowGetCards.size()>0 && bf.nowPlayer==getOwner() && bf.skillstep==0){
				return true;
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
		
		Player target=bf.nowGetCardPlayer;
		int num=target.handcards.size()-getOwner().handcards.size();
		if(num>0){
				ArrayList<Card> temp=new ArrayList<Card>();
				for(int i=0;i<num;i++){
					temp.add(target.handcards.get(i));
				}
				bf.disCard(target, temp, 1,null);
				bf.waitfor(2000);
		}else if(num<0){
			bf.drawCard(target, bf.getCardFromCardPack(Math.abs(num)), 1, null);
			bf.waitfor(1500);
		}
	}
	
}
