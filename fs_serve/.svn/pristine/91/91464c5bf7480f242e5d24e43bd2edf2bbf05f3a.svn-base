package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**
 * 内功修炼：当你获得情报时，你可以选择一项执行：①展示一张手牌，然后探寻（3）：两张不含所展示牌颜色的卡牌；②翻转此角色牌
**/
public class Skill165 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(getOwner().handcards.size()>0 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer==getOwner() && bf.thirdStep!=StepCons.Victory){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		tvo.target=this.deadmanUid;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(11500);
		userSelected(bf.sResult);
		
	}
	
	private void userSelected(SelectVO svo){//type:1探寻 2翻转
		if(svo.type==0)svo.type=2;
		if(svo.type==1 && svo.card==0) return;
		switch(svo.type){
		case 1:
			int showedColor = bf.cardsMap.get(svo.card).getColor();
			ArrayList<Integer> drawColor=new ArrayList<Integer>();
			switch(showedColor){
			case 1://红
				drawColor.add(2);
				drawColor.add(3);
				drawColor.add(4);
				break;
			case 2://蓝
				drawColor.add(1);
				drawColor.add(3);
				drawColor.add(5);
				break;
			case 3://黑
				drawColor.add(1);
				drawColor.add(2);
				break;
			case 4://蓝黑
				drawColor.add(1);
				break;
			case 5://红黑
				drawColor.add(2);
				break;
			}
			ArrayList<Card> cards=new ArrayList<Card>();//放要展示的那张手牌
			cards.add(bf.cardsMap.get(svo.card));
			ArrayList<Card> cards2=bf.getCardFromCardPack(3);//要展示的牌库顶的三张牌
			ArrayList<Card> cards2Left = new ArrayList<Card>();//不能被探寻入手牌的，稍后要置入弃牌堆的牌
			cards2Left.addAll(cards2);
			ArrayList<Card> cards3=new ArrayList<Card>();//能选择加入手牌的牌
			for(int i = 0; i < cards2Left.size(); i++){//构筑cards3
				for(int color : drawColor){
					if(cards2Left.get(i).getColor() == color){
						cards3.add(cards2Left.remove(i));
						i--;
						break;
					}
				}
			}
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			ActionscriptObject arr2=new ActionscriptObject();
			ActionscriptObject arr3=new ActionscriptObject();
			bf.setCardsResp(arr, cards);
			bf.setCardsResp(arr2, cards2);
			bf.setCardsResp(arr3, cards3);
			
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("oid",bf.operId);
			resp.put("cards",arr);
			resp.put("cards2",arr2);
			resp.put("cards3",arr3);
			resp.putBool("goOn", true);
			bf.SendToALL(resp);
			bf.sResult.dispose();
			bf.waitfor(14000);
//			bf.sendCardToGraveyard(cards2Left);//将cards2Left置入弃牌堆 //怀疑有bug，因为在draw方法里会送去弃牌堆，这里应该不用送
//			bf.sendCardToGraveyard(cards2);//将cards2置入弃牌堆
			drawCard(bf.sResult, cards2, cards3);
			break;
		case 2:
			getOwner().setRoleId(55);
			getOwner().setIndentity(getOwner().getIndentity());
			
			ActionscriptObject resp2=new ActionscriptObject();
			ActionscriptObject obj2=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj2);
			resp2.put("tvo",obj2);
			resp2.putNumber("h",2);
			resp2.putNumber("f",25);
			resp2.putNumber("oid",bf.operId);
			resp2.putBool("turn", true);
			bf.SendToALL(resp2);
			
			bf.waitfor(1000);
			
//			if(getOwner().task!=null){  //判断酱油任务
//				if(getOwner().checkTask()){
//					bf.VictoryExcute(getOwner());
//					return;
//				}
//			}
//			break;
		}
	}
	
	public void drawCard(SelectVO svo, ArrayList<Card> cards2, ArrayList<Card> cards3){//抽探寻到的牌
		ArrayList<Card> choosed=new ArrayList<Card>();//玩家选择的加到手牌的牌
		ArrayList<Card> dropped = new ArrayList<Card>();//没选的牌
//		if(svo.cards==null){
//			for(Card c : cards3){
//				svo.cards.add(c.getVid());
//			}
//		}
		if(svo.cards==null)return;
		for(int i : svo.cards){
			choosed.add(bf.cardsMap.get(i));
		}
		ArrayList<Card> temp = new ArrayList<Card>();
		temp.addAll(cards2);
		for(Card ca : cards2){
			for(int i : svo.cards){
				if(ca.getVid() == i){
					temp.remove(temp.indexOf(bf.cardsMap.get(i)));
				}
			}
		}
		dropped.addAll(temp);
//		SmartFoxServer.log.info("dropped.size()="+dropped.size());
		bf.sendCardToGraveyard(dropped);
		ActionscriptObject resp1=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr2 = new ActionscriptObject();
		ActionscriptObject arr4=new ActionscriptObject();
		ActionscriptObject arr5=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		bf.setCardsResp(arr2, cards2);
		bf.setCardsResp(arr4, choosed);
		bf.setCardsResp(arr5, dropped);
		resp1.put("tvo",obj);
		resp1.putNumber("h",2);
		resp1.putNumber("f",25);
		resp1.putBool("draw", true); 
		resp1.putNumber("oid",bf.operId);
		resp1.put("cards2", arr2);
		resp1.put("cards4", arr4);
		resp1.put("cards5", arr5);
		bf.SendToALL(resp1);
		bf.waitfor(6000);
		getOwner().addToHand(choosed);		
	}
}
