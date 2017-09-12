package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *顺藤摸瓜:当你获得一位其他玩家传出的情报时,你可以然后查看该玩家的身份
 */
public class Skill77 extends Skill {
	@Override
	public Boolean check() {
		if(launchCount>0 || getOwner().getIsDead())return false;
		if(!disabled && getOwner().handcards.size()>0 && bf.nowGetCards.size()>0 && bf.nowPlayer!=getOwner() && bf.nowGetCardPlayer.getUid()==getOwner().getUid() && bf.nowStep==StepCons.InfoReceive && bf.thirdStep!=StepCons.Victory){
			if(bf.nowGetCards.get(0).getOwner()==bf.nowPlayer){
				return true;
			}
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
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("target",bf.nowPlayer.getUid());
		resp.putNumber("iden",bf.nowPlayer.getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
	}
	
}
