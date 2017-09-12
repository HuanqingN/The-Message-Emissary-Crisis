package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;

import extension.vo.BaseVO;
import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//µ÷°ü
public class CardAction10 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoSend && noSkill() && !bf.sendingcard.security && !bf.sendingcard.heishui){
			return true;
		}
		return false;
	}
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		tvo.moveto=-1;
		for(Object t:bf.usedCardStack){
			if(t instanceof TargetVO){
				if(((TargetVO)t).cid==tvo.cid)((TargetVO)t).disabled=true;
			}
		}

		ActionscriptObject resp=new ActionscriptObject();
		tvo.setResponse(resp);
		ActionscriptObject obj=new ActionscriptObject();
		bf.sendingcard.setResponse(obj);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		resp.put("card", obj);
		bf.SendToALL(resp);
		
		Card card=bf.cardsMap.get(tvo.cvid);
		card.orgSend=card.getSend();
		card.setSend(bf.sendingcard.getSend());
		bf.sendCardToGraveyard(bf.sendingcard);
		bf.sendingcard=card;
		bf.sendingcard.setOwner(bf.nowPlayer);
		bf.sendingcard.shared=true;
		useEnd();
		//		bf.setTimer("CardSettlementAction", null, null, 2000);
//		bf.waitfor(2000,new ReflectVO("CardSettlementAction", bf));
	}
}
