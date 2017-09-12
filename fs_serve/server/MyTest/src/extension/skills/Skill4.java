package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**合谋**/
public class Skill4 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen() && blueSkillCheck()){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(false);
		playAni(false);
	}

	@Override
	public void excute() {
		if(getOwner().getIsDead()  || bf.roleMap.get(getTvo().target).getIsDead()){
			return;
		}
		getOwner().setIsOpen(false);
		Player target=bf.roleMap.get(getTvo().target);
		ActionscriptObject resp=new ActionscriptObject();
		resp=new ActionscriptObject();
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("target",target.getUid());
		resp.putNumber("iden",target.getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		bf.SendToALL(resp);
		bf.waitfor(2500);
		
//		Player target=bf.roleMap.get(getTvo().target);
		if(target.isHiden && target.getIsOpen()){
			if(hasCardColor(6,getOwner())){
//				ActionscriptObject resp=new ActionscriptObject();
				resp=new ActionscriptObject();
				ActionscriptObject obj=new ActionscriptObject();
				getTvo().dur=10000;
				getTvo().setResponse(obj);
				resp.put("tvo",obj);
				resp.putNumber("h",2);
				resp.putNumber("f",25);
				resp.putBool("goOn", true);
				resp.putBool("answer", true);
				resp.putNumber("oid",bf.operId);
				bf.SendToALL(resp);
				
				bf.sResult.dispose();
				bf.waitfor(10000);
				userSelected(bf.sResult);
			}else{
				closeRole();
			}
		}else{
			closeRole();
		}
	}
	
	private int stype=0; //select type: 0：不盖伏；1：盖伏。
	private void userSelected(SelectVO svo) {
		stype=svo.type;
		if(svo.type==0 || svo.cards==null){
			stype=0; //如果按了盖伏，但是没有选牌，将选择改为不盖伏。
			closeRole();
		}else{
			stype=getTvo().target;
			Card ca=getOwner().removeCardFromHand(svo.cards.get(0), false);
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(ca);
			
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.getCard(getOwner(),temp, 1);
			getCardend();
		}
	}
	public void getCardend(){
		if(getOwner().getIsDead()){
			return;
		}
		closeRole();
	}
	public void closeRole(){
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("goOn", true);
		resp.putNumber("target",stype);
		bf.SendToALL(resp);
		bf.waitfor(1000);
		
		Player target=bf.roleMap.get(getTvo().target);
//		resp=new ActionscriptObject();
//		resp.putNumber("from",getOwner().getUid());
//		resp.putNumber("target",target.getUid());
//		resp.putNumber("iden",target.getIndentity());
//		resp.putNumber("h",2);
//		resp.putNumber("f",30);
//		bf.SendToALL(resp);
//		resp.putNumber("from",target.getUid());
//		resp.putNumber("target",getOwner().getUid());
//		resp.putNumber("iden",getOwner().getIndentity());
//		bf.SendToALL(resp);
		
//		getOwner().setIsOpen(false);
		if(stype>0)target.setIsOpen(false);
		bf.waitfor(3000);
	}
	
}
