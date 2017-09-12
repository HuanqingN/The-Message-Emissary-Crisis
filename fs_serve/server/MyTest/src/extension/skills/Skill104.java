package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import javax.security.auth.callback.LanguageCallback;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *香气传达 弃掉一张手牌，你本回合的情报都以直达方式传递
 */
public class Skill104 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoWait && bf.nowPlayer==getOwner()){
			return getOwner().handcards.size()>=2;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1000);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",11);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("time", 10000);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		DiscardResult(bf.sResult);
	}
	public void DiscardResult(SelectVO svo){
		if(svo.card==0){//如果是一1，要自己选择弃的牌
			int num=bf.roleMap.get(getOwner().getUid()).handcards.size();
			num=(int)Math.floor(Math.random()*num);
			svo.card=bf.roleMap.get(getOwner().getUid()).handcards.get(num).getVid();
		}	
		Card ca=bf.cardsMap.get(svo.card);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(ca);
		bf.disCard(getOwner(), temp, 1, null);
		bf.waitfor(2000);
		ChooseInfo();
	}
	
	public void ChooseInfo(){
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		ChooseInfoResult(bf.sResult);
	}
	public void ChooseInfoResult(SelectVO svo){
		if(svo.card==0 || svo.target==0){
			return;
		}else{
			Card c=bf.cardsMap.get(svo.card);
			c.orgSend=c.getSend();
			c.setSend(1);
		}
	}
}
