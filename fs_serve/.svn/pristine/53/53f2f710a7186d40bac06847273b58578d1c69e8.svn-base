package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *柳暗花明：你的抽牌阶段，你可以放弃抽牌，然后将一位玩家面前的一张黑情报收入你的手牌。
 */
public class Skill146 extends Skill {

	@Override
	public Boolean check() {
		if(bf.nowPlayer.getIsDead()==false && bf.nowPlayer.isLost==false && bf.nowPlayer==getOwner() && bf.nowStep==StepCons.DealingSingle){
			for(Player p: bf.roleSeq){
				if(p.blackCards.size()>0){
					return true;
				}
			}
		}
		return super.check();
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().isSkipDealing=true;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(115000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(getTvo()==null)return;
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			for(Card c:bf.roleMap.get(getTvo().target).infocards){
				if(c.getColor()>2){
					svo.cards.add(c.getVid());
					break;
				}
			}
		}
	
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		Card car=target.removeCardFromInfo(svo.cards.get(0), false);
		temp.add(car);
		getOwner().addToHand(car);
		bf.setCardsResp(arr, temp);
		resp.put("cards",arr);
		resp.putNumber("type",2);//type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2500);
		
		if(bf.roleMap.get(getTvo().target)!=getOwner()){
			bf.drawCard(getOwner(),bf.getCardFromCardPack(1) , 1, null);
			bf.waitfor(1500);
		}
		
	}

}
