package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *窃听：抽取最多两位其他玩家的各一张随机手牌
 */
public class Skill120 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck() && !getOwner().getIsDead()){
			if(bf.getAlivePlayers().size()>=3){
				return true;
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
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.targets==null)return;
		Player from=bf.roleMap.get(svo.targets.get(0));
		Player to=null;
		if(svo.targets.size()>1)to=bf.roleMap.get(svo.targets.get(1));
		if(from.handcards.size()==0 && to.handcards.size()==0)return;
		ArrayList<Card> temp=new ArrayList<Card>();//从from抽的卡
		ArrayList<Card> temp1=new ArrayList<Card>();//从to抽的卡
		if(from.handcards.size()>0)temp.add(from.removeCardFromHand(from.handcards.get((int)(Math.floor(Math.random()*from.handcards.size()))),false));
		if(to!=null && to.handcards.size()>0)temp1.add(to.removeCardFromHand(to.handcards.get((int)(Math.floor(Math.random()*to.handcards.size()))),false));
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		if(temp.size()>0){
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",from.getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			getOwner().addToHand(temp);
		}
		
		if(temp1.size()>0){
			bf.waitfor(2000);
			arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp1);
			resp.putNumber("from",to.getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			getOwner().addToHand(temp1);
		}
		
	}

	private void userSelected1(SelectVO svo,ArrayList<Card> temp,Player from,Player to) {
		if(svo.type==0){
			ArrayList<Card> ca=new ArrayList<Card>();
			ca.add(temp.get(0));
			bf.disCard(from, ca, 1, null);
			ca.clear();
			ca.add(temp.get(1));
			bf.disCard(to, ca, 1, null);
			bf.waitfor(1500);
		}else{
			ArrayList<Card> ca=new ArrayList<Card>();
			ArrayList<Card> ca1=new ArrayList<Card>();
			ca.add(temp.get(0));
			ca1.add(temp.get(1));
			ActionscriptObject resp1=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, ca);
			resp1.putNumber("from",from.getUid());
			resp1.putNumber("to",to.getUid());
			resp1.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp1.put("cards",arr);
			resp1.putNumber("h",2);
			resp1.putNumber("f",27);
			bf.SendToALL(resp1);
			resp1=new ActionscriptObject();
			arr=new ActionscriptObject();
			bf.setCardsResp(arr, ca1);
			resp1.putNumber("from",to.getUid());
			resp1.putNumber("to",from.getUid());
			resp1.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp1.put("cards",arr);
			resp1.putNumber("h",2);
			resp1.putNumber("f",27);
			bf.SendToALL(resp1);
			bf.waitfor(2000);
			from.removeCardFromHand(temp.get(0).getVid(), false);
			to.removeCardFromHand(temp.get(1).getVid(), false);
			bf.getCard(from, ca1, 1);
			bf.getCard(to, ca, 1);
		}
	}
	
}
