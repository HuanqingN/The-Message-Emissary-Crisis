package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *临危受命
 */
public class Skill39 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && bf.deadman!=null && bf.deadman!=getOwner() && bf.thirdStep==StepCons.AfterDead && bf.thirdStep!=StepCons.Victory){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=this.deadmanUid;
		playAni(false);
		
		bf.waitfor(1500);
		getOwner().setIndentity(bf.deadman.getIndentity());
		bf.deadman.setIndentity(3);
		bf.deadman.isLost=true;
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=3000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("iden",getOwner().getIndentity());
		resp.putBool("goOn", true);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
		if(bf.VictoryInfoSettlement(getOwner())){  //判断收集收报胜利
			bf.VictoryExcute(getOwner());
			return;
		}
		exchangeInfo();
	}
	private void exchangeInfo(){//调换情报
//		ArrayList<Integer> alive = new ArrayList<Integer>();
//		for(Player p : bf.roleSeq){
//			if(!p.getIsDead() && !p.isLost) alive.add(p.getUid());
//		}
//		SmartFoxServer.log.info("alive size is " + alive.size());
		ActionscriptObject resp=new ActionscriptObject();
//		ActionscriptObject arr = new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
//		for(int i = 0; i < alive.size(); i++){
//			arr.put(i, alive.get(i));
//		}
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("exchange", true);
//		resp.put("choosableTargets",arr);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	
	private void userSelected(SelectVO svo){
		if(svo.cards==null){
			return;
		}
		Card card=bf.cardsMap.get(svo.cards.get(0));		
		Player target=bf.roleMap.get(svo.target);
		if(!target.hasInfoCard(card)){
			return;
		}
		ArrayList<Card> temp = new ArrayList<Card>();
		temp.add(card);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("type",6);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		arr = new ActionscriptObject();
		temp.clear();
		temp.addAll(bf.getCardFromCardPack(1));
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("type",9);//type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		
		target.removeCardFromInfo(card,false);
		bf.cards.add(0, card);
		bf.getCard(target, temp, 1);
	}
	
}
