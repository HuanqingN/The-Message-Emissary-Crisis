package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *香风毒雾：一位其它玩家收到传出的情报时,你可以丢弃一张手牌使其四回合内进入中毒状态
 */
public class Skill134 extends Skill {

	@Override
	public Boolean check() {
		if(bf.nowGetCardPlayer!=null && !bf.nowGetCardPlayer.getIsDead()){
			if(bf.nowStep==StepCons.InfoReceive && bf.nowGetCards.size()>0  && bf.skillstep==0){
				return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		tvo.target=this.nowGetCardPlayerUid;
		
		super.play(tvo);
		playAni(false);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(bf.cardsMap.get(tvo.card));
		bf.disCard(getOwner(),temp, 1, null);
		bf.waitfor(1500);
		bf.roleMap.get(tvo.target).isPoison=4;
		bf.setPoison(getTvo().target,4);
		bf.waitfor(1000);
	}
}
