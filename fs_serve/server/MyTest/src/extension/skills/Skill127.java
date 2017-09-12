package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.vo.SkillVO;
/**
 *殉道 当你死亡时，你可以选择一张黑色手牌给一位玩家作为情报
 */
public class Skill127 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==true && getOwner().getIsDead()==true && getOwner().skillhash.get(this.id).launchCount<1 && hasCardColor(6,getOwner())){
			if(bf.getAlivePlayers().size()>1)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=bf.cardsMap.get(tvo.card);
		temp.add(c);
		getOwner().removeCardFromHand(c,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",tvo.target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp, 3);
	}
	
}
