package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cons.StepCons;

import extension.vo.BaseVO;
import extension.vo.ReflectVO;
import extension.vo.TargetVO;
//Ê¶ÆÆ
public class CardAction4 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.subStep==StepCons.CardLaunch && noSkill()){
			for(Object t:bf.usedCardStack){
				if(t instanceof TargetVO){
					if(((TargetVO)t).sid==0 && ((TargetVO)t).canDiscover)return true;			
				}
			}
		}
		return false;
	}
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		ActionscriptObject resp=new ActionscriptObject();
		tvo.setResponse(resp);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		bf.SendToALL(resp);
		for(Object tv:bf.usedCardStack){
			if(tv instanceof TargetVO){
				if(((TargetVO)tv).cvid==tvo.card){
					((TargetVO)tv).disabled=true;
					break;
				}
			}
		}
		useEnd();
	}
}
