package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *ÝÓÈÆ
 */
public class Skill110 extends Skill {

	@Override
	public Boolean check() {
//		if(!getOwner().getIsOpen() || launchCount>=1)return false;
//		if(blueSkillCheck()){
//			return true;
//		}
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
		
		ArrayList<Card> cards=bf.getCardFromCardPack(3);
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Card c:cards){
			if(c.getColor()<3){
				temp.add(c);

			}
		}
		
		
		if(temp.size()>0){
			getOwner().addToHand(temp);
			
		}
		if(temp.size()==3){
			return;
		}else{
			
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			userSelected(bf.sResult);
		}
	}
	
	private void userSelected(SelectVO svo){

	}
	
}
