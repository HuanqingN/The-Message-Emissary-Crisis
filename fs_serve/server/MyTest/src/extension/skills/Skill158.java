package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**
 * ����:��������ɱ��һλ�������ʱ������ԸǷ��˽�ɫ�ƣ�Ȼ�������һλ�����ǰ����һ�ź��鱨
 * **/
public class Skill158 extends Skill {
	
	@Override
	public Boolean check() {
		if(getOwner().getIsOpen() && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer!=getOwner() && bf.nowGetCardPlayer.getIsDead() && bf.nowGetCards.get(0).getOwner()==getOwner() && bf.thirdStep!=StepCons.Victory){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.sponsor=getOwner().getUid();
		getOwner().setIsOpen(false);
		playAni(false);
		bf.waitfor(1000);
		drawCard();
	}
	
	private void drawCard(){
//		bf.drawCard(getOwner(), bf.getCardFromCardPack(1), 1, null);
//		bf.waitfor(1500);
		
//		if(!hasCardColor(6, getOwner()))return;
		ActionscriptObject resp1=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().setResponse(obj);
		resp1.put("tvo",obj);
		resp1.putNumber("h",2);
		resp1.putNumber("f",25);
		resp1.putNumber("oid",bf.operId);
		resp1.putBool("goOn",true);
		bf.SendToALL(resp1);
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	
	public void userSelected(SelectVO svo){
		if(svo.type==0){
			return;
		}
		if(svo.target==0 || svo.card==0){
			return;
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Player target=bf.roleMap.get(svo.target);
			Card c=getOwner().removeCardFromHand(svo.card, false);
			temp.add(c);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",svo.target);
			resp.putNumber("type",3);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨5�ֿ����ƿⶥ
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.getCard(target, temp,1);
		}
	}
}
