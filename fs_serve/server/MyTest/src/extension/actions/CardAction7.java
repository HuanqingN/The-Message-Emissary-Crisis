package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;

import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//²©ÞÄ
public class CardAction7 extends CardAction {
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
		Card card=bf.getCardFromCardPack();
		card.setOwner(getOwner());
		Player target=bf.roleMap.get(tvo.target);
		ArrayList<Card> arr=new ArrayList<Card>();
		arr.add(card);
		ActionscriptObject resp=new ActionscriptObject();
		tvo.setResponse(resp);
		ActionscriptObject getcard=new ActionscriptObject();
		card.setResponse(getcard);
		resp.put("card",getcard);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		bf.SendToALL(resp);
//		ReflectVO fvo=new ReflectVO("EndAction",this);
//		bf.getCard(target, arr,fvo,2000);
		bf.waitfor(1500);
		bf.getCard(target, arr, 1);
//		EndAction();
	}
	
	public void EndAction(){
//		bf.CardSettlementAnswer();
	}
}
