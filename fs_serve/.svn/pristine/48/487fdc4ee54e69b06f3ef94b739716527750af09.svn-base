package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;

import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.TargetVO;
//破译
public class CardAction5 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.subStep>0)return false;
		if(bf.nowStep == StepCons.InfoArrive && noSkill()){
			if(!bf.sendingcard.security && !bf.sendingcard.heishui && bf.sendTarget.getUid()==getOwner().getUid()){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		if(getOwner().getIsDead()){
			tvo.disabled=true;
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.SendToALL(resp);
		}else{
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			resp.putNumber("oid",bf.operId);
			bf.SendToALL(resp);
			bf.sResult.dispose();
			bf.waitfor(5*1000);
			manifestoColor(bf.sResult);
		}
	}
	
	public void manifestoColor(SelectVO svo){//宣言颜色返回 
//		bf.isExcute=true;
		
		if(svo.type==0)svo.type= (int)(Math.floor(Math.random()*3))+1;
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("uid",getTvo().sponsor);
		resp.putNumber("h",2);
		resp.putNumber("f",18);
		resp.putNumber("color",svo.type);
		resp.putNumber("oid",bf.operId);
		for(Player p:bf.roleSeq){
			if(p.isExit)continue;
			if(p.getUid()==getTvo().sponsor){
				ActionscriptObject obj=new ActionscriptObject();
				bf.sendingcard.setResponse(obj);
				resp.putBool("success", svo.type==0?false:matchColor(svo.type,bf.sendingcard.getColor()));
				resp.put("card",obj);
			}else{
				resp.removeElement("card");
				resp.removeElement("success");
			}
			bf.trigger.sendResponse(resp, -1, null, p.getChannel());
		}
		bf.sResult.dispose();
		bf.waitfor(5*1000);
		manifestoShared(bf.sResult);
	}
	public void manifestoShared(SelectVO svo){//宣言公开
		if(svo.type==0){//不公开
//			bf.CardSettlementAnswer();
		}else{
			bf.sendingcard.shared=true;
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			bf.sendingcard.setResponse(obj);
			resp.put("card",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",19);
			bf.SendToALL(resp);					//公开卡通告
			bf.waitfor(1000);
			SharedCarded();
		}
	}
	public void SharedCarded(){    //公开后抽卡
		ArrayList<Card> card=new ArrayList<Card>();
		card.add(bf.getCardFromCardPack());
		bf.drawCard(getOwner(), card, 1, null);
		bf.waitfor(2000);
	}
	public Boolean matchColor(int rcolor,int tcolor){
		if(rcolor==1){
			return (tcolor==1 || tcolor==5);
		}else if(rcolor==2){
			return (tcolor==2 || tcolor==4);
		}else if(rcolor==3){
			return (tcolor==3 || tcolor==4 || tcolor==5);
		}
		return false;
	}
}
