package extension.skills;

import java.util.ArrayList;
import java.util.LinkedList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**拷问**/
public class Skill52 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor==getOwner().getUid()){
			int cindex=bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid).getId();
			if(cindex>=13 && cindex<=18)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		
		ActionscriptObject arr=new ActionscriptObject();
		LinkedList<Card> temp=bf.roleMap.get(((TargetVO)bf.nowSettlement).target).handcards;
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("num", temp.size());
		bf.SendToALL(resp);
		
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	
	public void userSelected(SelectVO svo){
		bf.isExcute=true;
		Player t=bf.roleMap.get(((TargetVO)bf.nowSettlement).target);
		int num=t.handcards.size();
		if(num==0){
			return;
		}
		if(svo.type==0){
			num=(int)Math.floor(Math.random()*num);
			ArrayList<Integer> temp=new ArrayList<Integer>();
			temp.add(num);
			svo.cards=temp;
		}
		Card card=t.handcards.get(svo.cards.get(0));
		t.removeCardFromHand(card.getVid(),false);
		getOwner().addToHand(card);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",bf.roleMap.get(((TargetVO)bf.nowSettlement).target).getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		goNext();
	}
}
