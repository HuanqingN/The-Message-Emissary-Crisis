package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cons.StepCons;

import extension.vo.BaseVO;
import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//½Ø»ñ
public class CardAction6 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoSend && !self() && noSkill() && !bf.sendingcard.security){
			return true;
		}
		return false;
	}
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		Player p=bf.roleMap.get(tvo.sponsor);
		p.isCapture=true;
		bf.captureTarget=bf.sendTarget;
		bf.sendTarget=p;
		//		LinkedList<BaseVO> usecard=bf.usedCardStack;
		for(Object t:bf.usedCardStack){
			if(t instanceof TargetVO){
				if(((TargetVO)t).sid>0)continue;
				if(((TargetVO)t).cid==tvo.cid)((TargetVO)t).disabled=true;
				if(((TargetVO)t).cid==2 &&((TargetVO)t).target==tvo.sponsor)((TargetVO)t).disabled=true;
			}
		}

		ActionscriptObject resp=new ActionscriptObject();
		tvo.setResponse(resp);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		bf.SendToALL(resp);
//		bf.waitfor(2000,new ReflectVO("CardSettlementAction", bf));
		useEnd();
		//		bf.setTimer("CardSettlementAction", null, null, 2000);
	}
}
