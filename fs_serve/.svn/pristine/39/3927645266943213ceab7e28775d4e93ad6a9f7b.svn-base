package extension.actions;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.skills.Skill;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.TargetVO;
//试探父类
public class ProbeAction extends CardAction  implements IProbeAction{
	@Override
	public Boolean check() {
		ArrayList<Player> ps=bf.roleSeq;
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
		for (Player p : bf.roleSeq) {										//发送卡牌发动消息 
			ActionscriptObject resp=new ActionscriptObject();
			tvo.setResponse(resp);
			if(p.getUid()!=tvo.sponsor && p.getUid()!=tvo.target){
				resp.putNumber("cid", 99);
				resp.putNumber("color", 0);
			}
			resp.putNumber("time", 5000);
			resp.putNumber("oid",bf.operId);
			resp.putNumber("h",2);
			resp.putNumber("f",6);
			bf.trigger.sendResponse(resp, -1, null, p.getChannel());
		}
		bf.sResult.dispose();
		if(bf.roleMap.get(tvo.target).trusttee){
			bf.waitfor(1000);
			ProbeChoosed(bf.sResult);
		}else{
			bf.waitfor(5*1000);
			ProbeChoosed(bf.sResult);
		}
	}
	@Override
	public void ProbeChoosed(SelectVO svo) {
		Player role=bf.roleMap.get(getTvo().target);
		if(role.getRoleId()==1 && role.getIsOpen()==true){ //是老鬼
			role.skillhash.get(14).play(null);
		}
		
		if(svo.type==0){
			int iden=role.getIndentity();
			int cid=bf.cardsMap.get(getTvo().cvid).getId();
			if(cid==13 && iden==0)svo.type=2;
			else if(cid==14 && iden==0)svo.type=1;
			else if(cid==15 && iden==1)svo.type=2;
			else if(cid==16 && iden==1)svo.type=1;
			else if(cid==17 && iden==2)svo.type=2;
			else if(cid==18 && iden==2)svo.type=1;
			else svo.type=3;
			if(role.getRoleId()==1 && role.getIsOpen()==true)svo.type=3;
		}
		if(svo.type==1){  //弃
			if(bf.roleMap.get(getTvo().target).handcards.size()<1){   //如果要弃的人手牌为0
//				bf.CardSettlementAnswer();
				return;
			}
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("h",2);
			resp.putNumber("f",11);
			resp.putNumber("target", getTvo().target);
			resp.putNumber("time", 10000);
			resp.putNumber("oid",bf.operId);
			bf.SendToALL(resp);
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			DiscardResult(bf.sResult);
		}else if(svo.type==2){//抽
			ArrayList<Card> card=new ArrayList<Card>();
			Player target=bf.roleMap.get(getTvo().target);
			card.add(bf.getCardFromCardPack());
			bf.drawCard(target, card, 1, null);
			probeEnd();
		}else{
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("h",2);
			resp.putNumber("f",10);
			resp.putNumber("type",1);
			resp.putNumber("target",getTvo().target);
			bf.SendToALL(resp);
			bf.waitfor(1000);
			bf.thirdStep=StepCons.TestingFaild;
			bf.RedSkillsCheck();
			bf.thirdStep=0;
		}
	}
	@Override
	public void DiscardResult(SelectVO svo){
		if(svo.card==0){//如果是一1，要自己选择弃的牌
			int num=bf.roleMap.get(getTvo().target).handcards.size();
			num=(int)Math.floor(Math.random()*num);
			svo.card=bf.roleMap.get(getTvo().target).handcards.get(num).getVid();
		}
		Card ca=bf.cardsMap.get(svo.card);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(ca);
		bf.disCard(bf.roleMap.get(getTvo().target), temp, 1, null);
		probeEnd();
	}
	private void probeEnd() {
		bf.waitfor(2000);
		bf.thirdStep=StepCons.TestingSuccess;
		bf.RedSkillsCheck();
		bf.thirdStep=0;
	}
}
