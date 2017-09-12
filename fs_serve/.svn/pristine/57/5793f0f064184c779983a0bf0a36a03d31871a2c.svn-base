package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *胸有成竹 你的出牌阶段，你可以翻开你的身份牌，指定一位其它玩家随机抽取你的１张手牌作为他的情报，然后你失去所有技能
 */
public class Skill79 extends Skill {

	@Override
	public Boolean check() {
		//第一行是作为红技能时的判断条件，要求无堆叠。
//		return (!disabled && !getOwner().idenShow && !getOwner().getIsDead() && getOwner().handcards.size()>=1 && bf.nowPlayer== getOwner() && (bf.nowStep== StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2) && bf.usedCardStack.size()==0);
		return (!disabled && !getOwner().idenShow && !getOwner().getIsDead() && getOwner().handcards.size()>=1 && bf.nowPlayer== getOwner() && (bf.nowStep== StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2));
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
//		resp.putNumber("target1",tvo.target);
		resp.putNumber("oid",bf.operId);
//		resp.putNumber("num",getOwner().handcards.size());
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		bf.SendToALL(resp);
		getOwner().idenShow=true;
		bf.waitfor(4500);
	}
	
	@Override
	public void excute(){
		if(getOwner().getIsDead() || getOwner().handcards.size()<1){
			//若结算时密探死了或者没有手牌了
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("target1",getTvo().target);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("num",getOwner().handcards.size());
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putBool("goOn", true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			svo.cards.add(0);
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=getOwner().handcards.get(svo.cards.get(0));
		temp.add(getOwner().removeCardFromHand(c, false));
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getTvo().target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		Player target=bf.roleMap.get(getTvo().target);
		bf.getCard(target, temp, 1);
		getOwner().skillhash.get(77).disabled=true;
		getOwner().skillhash.get(78).disabled=true;
		getOwner().skillhash.get(this.id).disabled=true;
	}
	
}
