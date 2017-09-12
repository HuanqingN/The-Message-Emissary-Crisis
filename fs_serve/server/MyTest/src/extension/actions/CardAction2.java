package extension.actions;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.TargetVO;

//µ÷»¢ÀëÉ½
public class CardAction2 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoSend && noSkill() && isAnswer()){
			for(Player p:bf.roleSeq){
				if(p!=getOwner() && p!=bf.nowPlayer && !p.getIsLock() && !p.isCapture && !p.getIsDead() && !p.isLost && !p.isTransfer){
					return true;
				}
			}
		}
		return false;
	}
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		if(isAlive(tvo.target)){
			bf.roleMap.get(tvo.target).isSkip=true;
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.SendToALL(resp);
		}else{
			tvo.disabled=true;
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.SendToALL(resp);
		}
		useEnd();
	}
}
