package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *离间 你的出牌阶段,展示两位其它玩家的各一张随机手牌,然后你可以选择将这两张牌互相放置到对方面前或者弃置这两张牌
 */
public class Skill97 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen() && getOwner().skillhash.get(this.id).launchCount<1){
			if(bf.nowPlayer==getOwner() && (bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2))return true;
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
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.targets==null)return;
		Player from=bf.roleMap.get(svo.targets.get(0));
		Player to=bf.roleMap.get(svo.targets.get(1));
		if(from.handcards.size()==0 || to.handcards.size()==0)return;
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(from.handcards.get(0));
		temp.add(to.handcards.get(0));
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr,temp);
		getTvo().target=from.getUid();
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("from",from.getUid());
		resp.putNumber("to",to.getUid());
		resp.putBool("goOn",true);
		resp.put("cards",arr);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected1(bf.sResult,temp,from,to);
	}

	private void userSelected1(SelectVO svo,ArrayList<Card> temp,Player from,Player to) {
		if(svo.type==0){
			ArrayList<Card> ca=new ArrayList<Card>();
			ca.add(temp.get(0));
			bf.disCard(from, ca, 1, null);
			ca.clear();
			ca.add(temp.get(1));
			bf.disCard(to, ca, 1, null);
			bf.waitfor(1500);
		}else{
			ArrayList<Card> ca=new ArrayList<Card>();
			ArrayList<Card> ca1=new ArrayList<Card>();
			ca.add(temp.get(0));
			ca1.add(temp.get(1));
			ActionscriptObject resp1=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, ca);
			resp1.putNumber("from",from.getUid());
			resp1.putNumber("to",to.getUid());
			resp1.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp1.put("cards",arr);
			resp1.putNumber("h",2);
			resp1.putNumber("f",27);
			bf.SendToALL(resp1);
			resp1=new ActionscriptObject();
			arr=new ActionscriptObject();
			bf.setCardsResp(arr, ca1);
			resp1.putNumber("from",to.getUid());
			resp1.putNumber("to",from.getUid());
			resp1.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp1.put("cards",arr);
			resp1.putNumber("h",2);
			resp1.putNumber("f",27);
			bf.SendToALL(resp1);
			bf.waitfor(2000);
			from.removeCardFromHand(temp.get(0).getVid(), false);
			to.removeCardFromHand(temp.get(1).getVid(), false);
			bf.getCard(from, ca1, 1);
			bf.getCard(to, ca, 1);
		}
	}
	
}
