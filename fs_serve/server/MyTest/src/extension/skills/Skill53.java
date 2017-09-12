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
 *搜取
 */
public class Skill53 extends Skill {

//	private int secUid=-1;//secondDeadManUid同时死的人里第二个死的人的uid
	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && bf.deadman!=null && getOwner().skillhash.get(this.id).launchCount<1 && bf.thirdStep==StepCons.AfterDead){
			if(bf.deadman.handcards.size()>0){
//				if(deadmanUid==-1){
//					deadmanUid=bf.deadman.getUid();
//				}else{
//					secUid=bf.deadman.getUid();
//				}
				return true;
			}

		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
//		getOwner().skillhash.get(this.id).launchCount++;
//		if(bf.deadman!=null){
//			tvo.target=bf.deadman.getUid();
//		}else if(getOwner().skillhash.get(this.id).launchCount<1){
//			tvo.target=bf.roleMap.get(secUid).getUid();
//		}else{
//			tvo.target=bf.roleMap.get(deadmanUid).getUid();
//		}
		tvo.target=this.deadmanUid;
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr,bf.deadman.handcards);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.put("cards", arr);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	//svo.type 0手牌1情报
	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			return;
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		temp.add(target.removeCardFromHand(svo.cards.get(0),false));
		if(svo.type==0){
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject ca=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getTvo().target);
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			getOwner().addToHand(temp.get(0));
		}else{
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject ca=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getTvo().target);
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			bf.getCard(getOwner(),temp, 1);
		}
	}
	
}
