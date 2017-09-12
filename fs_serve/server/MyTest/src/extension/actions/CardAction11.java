package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//权衡
public class CardAction11 extends CardAction {
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
	private int handcardcount=0;
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		Player sponsor=bf.roleMap.get(tvo.sponsor);
		int num=sponsor.handcards.size();
		sendToClient();
		if(num==0){   //已经没有卡可以丢
			return;
		}
		handcardcount=sponsor.handcards.size();
		LinkedList<Card> temp=new LinkedList<Card>();
		temp.addAll(sponsor.handcards);
		bf.disCard(sponsor,temp, 1, null);
		bf.waitfor(2000);
		discardResult();
	}
	
	public void discardResult(){
		Player sponsor=bf.roleMap.get(getTvo().sponsor);
		ArrayList<Card> temp=bf.getCardFromCardPack(handcardcount);
		bf.drawCard(sponsor, temp, 1, null);
		bf.waitfor(2000);
	}
	public void sendToClient(){
		ActionscriptObject resp=new ActionscriptObject();
		getTvo().setResponse(resp);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		bf.SendToALL(resp);
	}
}
