package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Map;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**
 * 疾风骤雨：当你成功使用一张不含本回合上一张成功使用的功能牌的颜色的功能牌时，你可以选择一项执行：①指定一位手牌不少于一张的其他玩家弃掉一张手牌；②翻转此角色牌牌
**/
public class Skill167 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor==getOwner().getUid()){
			Card card = bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid);
			int color = 0;
			if(getOwner().lastUsedCard!=null){
				color = getOwner().lastUsedCard.getColor();//上一张使用的卡牌的颜色
			}
			SmartFoxServer.log.info("Last Color is " + color);
			ArrayList<Integer> difColor = new ArrayList<Integer>();//装 不含上一张使用的卡牌的颜色的颜色
			switch(color){
			case 0:
				return false;
			case 1://红
				difColor.add(2);
				difColor.add(3);
				difColor.add(4);
				break;
			case 2://蓝
				difColor.add(1);
				difColor.add(3);
				difColor.add(5);
				break;
			case 3://黑
				difColor.add(1);
				difColor.add(2);
				break;
			case 4://蓝黑
				difColor.add(1);
				break;
			case 5://红黑
				difColor.add(2);
				break;
			}
			for(int i = 0; i < difColor.size(); i++){
				SmartFoxServer.log.info("canColor " + difColor.get(i));
			}
			SmartFoxServer.log.info("settlement color is " + card.getColor());
			for(int j : difColor){//遍历不同颜色
				if(card.getColor() == j) return true;
			}
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
	
	private void userSelected(SelectVO svo){//type:1弃牌 2翻转
		if(svo.type==0)svo.type=2;
		if(svo.type==1 && svo.target==0) return;
		switch(svo.type){
		case 1:
			/*
			Player target=bf.roleMap.get(svo.target);
			int num=target.handcards.size();
			num=(int) Math.floor(Math.random()*num);
			svo.card=target.handcards.get(num).getVid();
			Card ca=bf.cardsMap.get(svo.card);
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(ca);
			bf.disCard(target, temp, 1,null);
			getOwner().jifengzhouyu.put(svo.target, getOwner().jifengzhouyu.containsKey(svo.target)?getOwner().jifengzhouyu.get(svo.target)+1 : 1) ;
			for(int key : getOwner().jifengzhouyu.keySet()){
				SmartFoxServer.log.info("key " + key);
				SmartFoxServer.log.info("Value " +  getOwner().jifengzhouyu.get(key) + "\n");
			} 
			bf.waitfor(2000);
			break;
			*/
			
			Player target=bf.roleMap.get(svo.target);
			getTvo().target = svo.target;
			LinkedList<Card> temp = target.handcards;
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("oid",bf.operId);
			resp.putBool("chooseDiscard", true);
			bf.SendToALL(resp);
			bf.sResult.dispose();
			bf.waitfor(10000);
			disCardSelected(bf.sResult);
			break;
		case 2:
			getOwner().setRoleId(54);
			getOwner().setIndentity(getOwner().getIndentity());
			ActionscriptObject resp2=new ActionscriptObject();
			ActionscriptObject obj2=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj2);
			resp2.put("tvo",obj2);
			resp2.putNumber("h",2);
			resp2.putNumber("f",25);
			resp2.putBool("turn", true);
			bf.SendToALL(resp2);
			
			bf.waitfor(1000);
			
			if(getOwner().task!=null){  //判断酱油任务
				if(getOwner().checkTask()){
					bf.VictoryExcute(getOwner());
					return;
				}
			}
			break;
		}
	}
	
	private void disCardSelected(SelectVO svo){
		Player target= bf.roleMap.get(getTvo().target);
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			int num=target.handcards.size();
			num=(int) Math.floor(Math.random()*num);
			svo.cards.add(target.handcards.get(num).getVid());
		}
		Card ca=bf.cardsMap.get(svo.cards.get(0));
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(ca);
		bf.disCard(target, temp, 1,null);
		getOwner().jifengzhouyu.put(getTvo().target, getOwner().jifengzhouyu.containsKey(getTvo().target)?getOwner().jifengzhouyu.get(getTvo().target)+1 : 1) ;
		bf.waitfor(2000);
		if(getOwner().task!=null){  //判断酱油任务
			if(getOwner().checkTask()){
				bf.VictoryExcute(getOwner());
				return;
			}
		}
	}
}