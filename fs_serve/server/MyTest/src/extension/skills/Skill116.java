package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *病毒移植:当一位玩家面前的情报被烧毁时，你可以将自己面前的一张情报转置到其面前
 */
public class Skill116 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && !getOwner().getIsDead() && bf.thirdStep==StepCons.AfterBurn && bf.burnTarget!=getOwner().getUid()){
			return getOwner().infocards.size()>0;
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
		Card card=bf.cardsMap.get(tvo.card);
		getOwner().removeCardFromInfo(card, false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",bf.burnTarget);
		resp.putNumber("type",4);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5手卡到牌库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		
		Player target=bf.roleMap.get(bf.burnTarget);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(card);
		bf.getCard(target, cards, 1);	
		bf.waitfor(2000);
	}
}
