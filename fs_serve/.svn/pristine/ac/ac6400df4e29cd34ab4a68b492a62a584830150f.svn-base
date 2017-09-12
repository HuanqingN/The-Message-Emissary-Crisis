package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.actions.CardAction12;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**逆转 当一位玩家获得你传出的情报时，你把他面前的一张红或蓝情报放置在自己面前**/
public class Skill47 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCards.size()>0 && bf.nowPlayer.getUid()==getOwner().getUid() && bf.thirdStep!=StepCons.Victory){
			Player p=bf.nowGetCardPlayer;
			if((p.blueCards.size()+p.redCards.size())>1){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public void reset(){
		
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=bf.nowGetCardPlayer.getUid();
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
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
		}
	}
	
}
