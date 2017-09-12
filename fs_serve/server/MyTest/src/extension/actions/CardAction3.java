package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.TargetVO;

//烧毁
public class CardAction3 extends CardAction {
	@Override
	public Boolean check() {
		if(!noSkill())return false;
		if(bf.subStep==StepCons.CardSettlement)return false;
		for(Player p:bf.roleSeq){
			if(!p.getIsDead() && !p.isLost && p.blackCards.size()>0){
					return true;
			}
		}
		return false;
	}
	
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		if(isAlive(tvo.target)){
			
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			resp.putNumber("oid",bf.operId);
			resp.putBool("isChoose",true);
			if(bf.roleMap.get(tvo.sponsor).getRoleId()==42){//是出云龙使用的烧毁
				resp.putBool("ddmc", true);
			}
			bf.SendToALL(resp);
			
			bf.sResult.dispose();
			bf.waitfor(10000);
			userSelected(bf.sResult);
//			if(isAlive(tvo.target) && hasInfoCard(tvo.card,tvo.target)){
//			Card result=bf.roleMap.get(tvo.target).removeCardFromInfo(tvo.card,false);
//			bf.setDisabledTargetVO(tvo.card,2);
//			ArrayList<Card> temp=new ArrayList<Card>();
//			temp.add(bf.cardsMap.get(tvo.card));
//			bf.Burn(tvo.target, temp);
//			ActionscriptObject resp=new ActionscriptObject();
//			tvo.setResponse(resp);
//			resp.putNumber("h",2);
//			resp.putNumber("f",6);
//			bf.SendToALL(resp);
			useEnd();
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
	
	private void userSelected(SelectVO svo) {
		if(svo.cards==null){ //如果玩家没有选择要烧毁的情报，则随机选择一张
			Player target = bf.roleMap.get(getTvo().target);
			if (target.infocards.size()>0){
				svo.cards=new ArrayList<Integer>();
				if(bf.roleMap.get(getTvo().sponsor).getRoleId()==42){//是出云龙使用的烧毁
					int random = (int)(Math.random()*(target.infocards.size()));
					svo.cards.add(target.infocards.get(random).getVid());
				} else if(target.blackCards.size()>0){
					int random = (int)(Math.random()*(target.blackCards.size()));
					svo.cards.add(target.blackCards.get(random).getVid());
				}else return;//如果目标不是出云龙，且面前没有黑情报了，则return。
			}else return;//如果目标面前没有情报了，则return。
		}
//			else{
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(bf.cardsMap.get(svo.cards.get(0)));
			bf.Burn(getTvo().target, temp);
			ActionscriptObject resp=new ActionscriptObject();
			getTvo().setResponse(resp);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.SendToALL(resp);
//		}
	}
}
