package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *化剑为犁
 */
public class Skill98 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen() || getOwner().getIsDead())return false;
//		if(answer() || noInforeceive()){
//			if(selfturn()){
//				return true;
//			}else{
//				return bf.nowStep != StepCons.CardUse1;
//			}
//		}
		if(blueSkillCheck())return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(true);
		getOwner().setIsOpen(true);
	}

	@Override
	public void excute() {
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).handcards.size()==0)return;
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",11);
		resp.putNumber("target",getTvo().target);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("time", 10000);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		DiscardResult(bf.sResult);
	}
	public void DiscardResult(SelectVO svo){
		Player target=bf.roleMap.get(getTvo().target);
		if(target.handcards.size()>0){
			if(svo.card==0){//如果是一1，要自己选择弃的牌
				int num=target.handcards.size();
				num=(int)Math.floor(Math.random()*num);
				svo.card=target.handcards.get(num).getVid();
			}
			Card ca=bf.cardsMap.get(svo.card);
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(ca);
			bf.disCard(target, temp, 1,null);
			bf.waitfor(2000);
		}
	}

}
