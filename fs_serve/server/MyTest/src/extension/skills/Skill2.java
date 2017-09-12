package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**
 *揭露
 */
public class Skill2 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoSend && bf.sendingcard.getSend()==3 && bf.sendingcard.shared==false){
			if(getOwner().handcards.size()>0)return true;
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
	}

	@Override
	public void excute() {
		if(!getOwner().getIsDead()){
			bf.sendingcard.shared=true;
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			bf.sendingcard.setResponse(obj);
			resp.put("card",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",19);
			bf.SendToALL(resp);					//公开卡通告
			bf.waitfor(1000);
			if(bf.sendingcard.getColor()>2){
				bf.drawCard(getOwner(), bf.getCardFromCardPack(hasWatson()), 1,null);
				bf.waitfor(1500);
			}
		}
	}
	
	public int hasWatson(){
		for(Player p:bf.roleSeq){
			if(!p.getIsDead() && !p.isLost && p.getRoleId()==44){
				SkillVO s=new SkillVO();
				s.sponsor=getOwner().getUid();
				s.sid=133;
				getOwner().skillhash.get(133).play(s);
				return 3;
			}
		}
		return 2;
	}
	
}
