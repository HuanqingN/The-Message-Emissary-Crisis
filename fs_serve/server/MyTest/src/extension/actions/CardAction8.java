package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;

import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//ÕæÎ±Äª±æ
public class CardAction8 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.subStep>0 || !noSkill())return false;
		if(bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2){
			if(self()){
				return true;
			}
		}
		return false;
	}
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		tfcards=new ArrayList<Card>();
		ActionscriptObject arr=new ActionscriptObject();
		pseq=bf.getSeqPalyers();
		for(Player p:pseq){
			Card card=bf.getCardFromCardPack();
			card.setOwner(getOwner());
			bf.cards.add(0,card);
			tfcards.add(bf.getCardFromCardPack());
		}
		Collections.shuffle(tfcards);
		bf.setCardsResp(arr,tfcards);

		ActionscriptObject resp=new ActionscriptObject();
		tvo.setResponse(resp);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		resp.put("cards", arr);
		bf.SendToALL(resp);
		bf.waitfor(300*tfcards.size()+3000);
		nowIndex=0;
		deal();
	}
	public List<Player> pseq=null;
	public int nowIndex=0;
	public ArrayList<Card> tfcards=null;

	public void deal(){
		ActionscriptObject resp=new ActionscriptObject();
		Boolean dead=pseq.get(nowIndex).getIsDead();
		resp.putNumber("target", pseq.get(nowIndex).getUid());
		resp.putNumber("vid", tfcards.get(nowIndex).getVid());
		resp.putNumber("h",2);
		resp.putNumber("f",12);
		if(dead)resp.putBool("tograve",true);
		bf.SendToALL(resp);
		nowIndex++;
		if(!dead){
			ArrayList<Card> ca=new ArrayList<Card>();
			ca.add(tfcards.get(nowIndex-1));
//			ReflectVO rvo=new ReflectVO("goNextDeal",this);
			bf.waitfor(1000);
//			bf.getCard(pseq.get(nowIndex-1), ca, rvo, 1000);
			bf.getCard(pseq.get(nowIndex-1), ca, 1);
			goNextDeal();
		}else{
			bf.sendCardToGraveyard(tfcards.get(nowIndex-1));
			bf.waitfor(1000);
			if(nowIndex<tfcards.size()){
				deal();
			}else{
//				bf.CardSettlementAnswer();
			}
		}
	}

	public void goNextDeal(){
//		bf.clearLastInfovo();
		if(nowIndex<tfcards.size()){
			deal();
		}else{
//			bf.CardSettlementAnswer();
		}
	}
}
