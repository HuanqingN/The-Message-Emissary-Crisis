package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *追猎
 */
public class Skill140 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead() || !getOwner().getIsOpen())return false;
		if(bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCards.size()>0 && hasCardColor(6, getOwner())){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2 && c.shared)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1500);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(bf.cardsMap.get(tvo.card));
		getOwner().removeCardFromHand(tvo.card, false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",bf.nowGetCardPlayer.getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5手卡到牌库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.nowGetCardPlayer, temp, 1);
	}
	
}
