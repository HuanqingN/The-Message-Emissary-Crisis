package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.actions.CardAction12;
import extension.actions.CardAction6;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *集结:获得一位其他玩家面前的一张黑情报，然后执行增援效果
 */
public class Skill85 extends Skill {
	public CardAction12 c12=null;
	
	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && !getOwner().getIsDead() && blueSkillCheck()){
			for(Player p:bf.roleSeq){
				if(p.getUid()!=getOwner().getUid() && !p.getIsDead() && !p.isLost && p.blackCards.size()>0){
							return true;
				}
			}
		}
		return false;
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		for(Card c:target.blackCards){
			if(c.getColor()>2)temp.add(c);
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);		
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			return;
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Player target=bf.roleMap.get(getTvo().target);
			Card result=target.removeCardFromInfo(svo.cards.get(0), false);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			temp.add(result);
			bf.setCardsResp(arr, temp);
			resp.put("cards",arr);
			resp.putNumber("type",4);
			resp.putNumber("from",target.getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.getCard(getOwner(), temp, 1);
//			if(!getOwner().getIsDead()){
//				if(c12==null){
//					c12=new CardAction12();
//					c12.setOwner(getOwner());
//				}
//				TargetVO t=new TargetVO();
//				t.useBySkill=true;
//				t.sponsor=getOwner().getUid();
//				t.cid=12;
//				c12.play(t);
//			}
		}
		
	}
	
}
