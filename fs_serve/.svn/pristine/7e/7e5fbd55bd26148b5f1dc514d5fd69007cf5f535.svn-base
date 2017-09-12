package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *掩饰
 */
public class Skill118 extends Skill {

	@Override
	public Boolean check() {
		return (getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && (bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2));
	}

	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		int num=bf.cards.size();
		if(num==0)return;
		num=(int)(Math.random()*num);
		Card c=bf.cards.remove(num);
		if(c.getColor()==3)getOwner().setIndentity(2);
		else if(c.getColor()==1 || c.getColor()==5)getOwner().setIndentity(0);
		else getOwner().setIndentity(1);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(c);
		getOwner().addToHand(c);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr,temp);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.put("cards",arr);
		resp.putNumber("newiden",getOwner().getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		
		bf.waitfor(4000);
		bf.usedCardStack.removeLast();
		if(bf.VictoryInfoSettlement(getOwner())){  //判断收集收报胜利
			bf.VictoryExcute(getOwner());
		}
	}
	
}
