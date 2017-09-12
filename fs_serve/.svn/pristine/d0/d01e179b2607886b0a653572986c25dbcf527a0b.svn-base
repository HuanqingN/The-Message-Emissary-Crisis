package extension.skills;
import java.util.ArrayList;

import extension.actions.CardAction5;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *嗅觉敏锐 别人的情报传递时,你可以弃一张手牌,然后视为使用了破译(每回合一次)
 */
public class Skill111 extends Skill {
	public CardAction5 c5=null;
	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoSend  && bf.nowPlayer!=getOwner()){
			if(getOwner().handcards.size()>0)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		Card ca=bf.cardsMap.get(tvo.card);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(ca);
		bf.disCard(getOwner(), temp, 1, null);
		bf.waitfor(2000);
	}
	@Override
	public void excute() {
		if(getOwner().getIsDead())return;
		if(c5==null){
			c5=new CardAction5();
			c5.setOwner(getOwner());
		}
		TargetVO t=new TargetVO();
		t.useBySkill=true;
		t.sponsor=getOwner().getUid();
		t.cid=5;
		c5.play(t);
	}
}
