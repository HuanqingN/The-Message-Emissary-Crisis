package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *漏洞入侵：你的出牌阶段，若存在已获情报缺少某种颜色的玩家，你可以在其面前放置一张该颜色的情报
 */
public class Skill114 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && bf.nowPlayer==getOwner() && getOwner().handcards.size()>0 && (bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2) && bf.usedCardStack.size()==0 ){
			for(Player p:bf.roleSeq){
				if(p.blueCards.size()==0 || p.redCards.size()==0 ||p.blackCards.size()==0){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(11500);
		userSelected(bf.sResult);
		
	}
	
	private void userSelected(SelectVO svo){
		if(svo.card==0)return;
		
		Card card=bf.cardsMap.get(svo.card);
		getOwner().removeCardFromHand(card,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getTvo().target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		
		Player target=bf.roleMap.get(getTvo().target);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(card);
		bf.getCard(target, cards, 1);
		bf.usedCardStack.removeLast();
	}
	
}
