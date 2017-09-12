package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *情报诱捕：当其他玩家使用掉包或截获时，令该掉包或截获无效，然后抽取使用者的一张手牌
 */
public class Skill91 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() || launchCount>=1)return false;
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor!=getOwner().getUid()){
			int cindex=((TargetVO)bf.nowSettlement).cid;
			if(cindex==6 || cindex==10)return true;
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
		((TargetVO)bf.nowSettlement).disabled=true;
		Player target=bf.roleMap.get(((TargetVO)bf.nowSettlement).sponsor);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		if(target.handcards.size()>0){
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, target.handcards);
			resp.put("cards",arr);
		}
		bf.SendToALL(resp);
		if(target.handcards.size()>0){
			bf.sResult.dispose();
			bf.waitfor(13000);
			userSelected(bf.sResult);
		}else{
			bf.waitfor(3000);
		}
	}
	
	private void userSelected(SelectVO svo){
		Player target=bf.roleMap.get(((TargetVO)bf.nowSettlement).sponsor);
		if(svo.cards==null){
			return;
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer c:svo.cards){
			temp.add(target.removeCardFromHand(c, false));
		}
		getOwner().addToHand(temp);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5手卡到牌库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
	}
	
}
