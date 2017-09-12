package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**仇恨**/
public class Skill58 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck() && getOwner().handcards.size()>0 &&  hasInfoColor(6,getOwner())){
			for(Player p:bf.roleSeq){
				if(!p.getIsDead() && !p.isLost && p.sex>0){
					return true;
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
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(3000);
		if(getOwner().handcards.size()>0){
			LinkedList<Card> temp=new LinkedList<Card>();
			temp.addAll(getOwner().handcards);
			bf.disCard(getOwner(),temp, 1, null);
			bf.waitfor(2000);
		}
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0 || svo.target==0){
			return;
		}
		Card card=bf.cardsMap.get(svo.card);
		getOwner().removeCardFromInfo(card, false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",svo.target);
		resp.putNumber("type",4);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		
		Player target=bf.roleMap.get(svo.target);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(card);
		bf.getCard(target, cards, 1);	
	}
	
}
