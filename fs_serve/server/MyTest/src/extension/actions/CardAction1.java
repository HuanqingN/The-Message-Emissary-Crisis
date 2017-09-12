package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cons.StepCons;

import extension.vo.BaseVO;
import extension.vo.ReflectVO;
import extension.vo.TargetVO;

//Ëø¶¨
public class CardAction1 extends CardAction {

	@Override
	public Boolean check() {
		if(self() && noSkill() && isAnswer()){
			if(bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2 ||  bf.nowStep==StepCons.InfoSend){
				return true;
			}
		}
		return false;
	}

	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		if(isAlive(tvo.target)){
			LinkedList<Object> usecard=bf.usedCardStack;
			for(Object t:usecard){
				if(t instanceof TargetVO){
					if(((TargetVO)t).cid==2 && ((TargetVO)t).target==tvo.target)((TargetVO)t).disabled=true;
				}
			}
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.roleMap.get(tvo.target).setIsLock(true);
		}else{
			tvo.disabled=true;
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.SendToALL(resp);
			useEnd();
		}
	}
}
