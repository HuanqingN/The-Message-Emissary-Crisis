package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**细节**/

public class Skill42 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner() && !getOwner().getIsDead() && getOwner().handcards.size()>0){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2)return true;
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
		if(launchCount>=2)return;
		playAni(false);
		
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0){
			svo.card=getOwner().handcards.get(0).getVid();
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=getOwner().removeCardFromHand(svo.card, false);
		temp.add(c);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);

		bf.getCard(getOwner(), temp, 1);
	}
	
}
