package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import morn.core.components.Clip;
	
	import utils.ArrayUtil;
	import utils.HashMap;
	import utils.Rand;
	
	import views.ACard;

		/**
		 * 鹰眼
		 */	
		public class Skill152 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				if(obj.goOn){
					delayedFun1();
				}else{
					if(obj.doNotPlayAni)return;
					playNormalAni();
					TweenMax.delayedCall(1,delayedFun);
				}
			}
			
			override public function delayedFun():void
			{
				var cards:Array=data.cards;
				var temp:Array=[];
				for(var i:int in cards){
					var c:ACard=new ACard();
					c.setdata(cards[i]);
					temp.push(c);
				}
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(tvo.dur);
				bm.addCardsToCenter(temp,true);
				TweenMax.delayedCall(1,selectCards,[temp]);
			}
			public function selectCards(arr:Array):void{
				for  (var j:int in arr) 
				{
					bv.removeChild(arr[j]);
				}
//				data.to=tvo.sponsor;
//				if(GL.id!=tvo.sponsor)data.cards=null;
//				data.type=1;
//				Evt.dipatch(BattleHandler.onAddCard,data);
//				TweenMax.delayedCall(1,delayedFun1);
			}
			public function delayedFun1():void{
//				data.uid=tvo.sponsor;
//				Evt.dipatch(BattleHandler.onAddCard,data);
				if(data.goOn){
					if(tvo.sponsor==GL.id){
						bv.showInfo("请选择你要放回牌库顶的一张手牌");
						var arr2:Array=phash.get(GL.id).hand;
						cards=[];
						for each(var c:ACard in arr2){
							cards.push(c);
						}
						this.showCards();
						phash.get(GL.id).view.showTime(tvo.dur-1000);
					}else{
						bv.showInfo("请等待猎鹰操作");
						var p:Player=phash.get(tvo.sponsor);
						p.view.showTime(tvo.dur-1000);
					}
				}
			}
			override protected function onCardsSelect(evt:MouseEvent):void
			{
				App.log.info("当前oid4是"+bm.oid);
				var param:Object={tid:GL.tableId,ctype:1,type:1,card:evt.currentTarget.vid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
				clearState();
			}
		}
}