package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**ÍµÌì**/
public class Skill13 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==StepCons.AfterDead && bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCards.size()>0 && bf.nowPlayer.getUid()==getOwner().getUid()){
			Player p=bf.nowGetCardPlayer;
			if((p.blackCards.size()+p.blueCards.size()+p.redCards.size())>1){
					for(Card c:bf.nowGetCards){
						if(c.getColor()>2)return true;
					}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.target=bf.nowGetCardPlayer.getUid();
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		Card car=target.removeCardFromInfo(svo.cards.get(0), false);
		temp.add(car);
		getOwner().addToHand(car);
		bf.setCardsResp(arr, temp);
		resp.put("cards",arr);
		resp.putNumber("type",2);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
	}
	
}
