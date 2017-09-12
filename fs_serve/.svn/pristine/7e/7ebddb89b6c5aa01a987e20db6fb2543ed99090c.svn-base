package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cons.StepCons;

import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//×ªÒÆ
public class CardAction9 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.subStep>0 || !noSkill())return false;
		if(bf.nowStep == StepCons.InfoArrive && bf.sendTarget==getOwner() && !bf.sendingcard.security){
			if(!getOwner().getIsLock()){
				return true;
			}
		}
		return false;
	}
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		ActionscriptObject resp=new ActionscriptObject();
		tvo.setResponse(resp);
		bf.roleMap.get(tvo.target).isTransfer=true;
		bf.sendTarget=bf.roleMap.get(tvo.target);
		bf.captureTarget=getOwner();
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		bf.SendToALL(resp);
		getTvo().dispose();
		bf.waitfor(2000);
	}
}
