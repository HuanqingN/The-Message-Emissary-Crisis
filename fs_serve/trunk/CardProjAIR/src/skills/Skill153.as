package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import morn.core.components.Clip;
	
	import utils.ArrayUtil;
	import utils.HashMap;
	import utils.Rand;
	
	import views.ACard;

		/**
		 * 猎杀
		 */	
		public class Skill153 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
				TweenMax.delayedCall(1.5,delayedFun);
			}
			
			
			override public function delayedFun():void//展示牌库顶的第一张牌
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
			
			
			public function selectCards(arr:Array):void{//移除展示牌
				for  (var j:int in arr) 
				{
					bv.removeChild(arr[j]);
				}
				if(data.goOn) delayedFun2();
			}
				
			public function delayedFun2():void{//选择要放置的黑情报
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(tvo.dur);
				if(tvo.sponsor==GL.id){
					var temp:Array=[];
//					var arr:Array=phash.get(GL.id).hand;
//					for each(var c:ACard in arr){
//						if(c.color>2){
//							var acard:ACard=new ACard();
//							acard.setdata(c);
//							temp.push(acard);
//						}
//					}
					var arr:Array=data.cards;
					for (var i:int in arr){
						var acard:ACard=new ACard();
						acard.setdata(arr[i]);
						temp.push(acard);
					}
					bv.showCardDialog(temp,"是否将这张展示牌放置到目标面前？",0,71);
				}else{
					bv.showInfo("请等猎鹰操作");
				}
			}
			
			/**
			 * 以下为旧版猎杀代码
			 */
//			override public function play(tvo1:SkillVO,obj:Object):void
//			{
//				super.play(tvo1,obj);
//				if(obj.goOn){
//					delayedFun2();
//				}else{
//					playNormalAni();
//					TweenMax.delayedCall(1,delayedFun);
//				}
//			}
//			
//			override public function delayedFun():void
//			{
//				var cards:Array=data.cards;
//				var temp:Array=[];
//				for(var i:int in cards){
//					var c:ACard=new ACard();
//					c.setdata(cards[i]);
//					temp.push(c);
//				}
//				var p:Player=phash.get(tvo.sponsor);
//				p.view.showTime(tvo.dur);
//				bm.addCardsToCenter(temp,true);
//				TweenMax.delayedCall(1,selectCards,[temp]);
//			}
//			
//			
//			public function selectCards(arr:Array):void{
//				for  (var j:int in arr) 
//				{
//					bv.removeChild(arr[j]);
//				}
//				TweenMax.delayedCall(1,delayedFun1);
//			}
//			
//			public function delayedFun1():void
//			{
//				var p:Player=phash.get(tvo.sponsor);
//				p.view.showTime(9000);
//				if(tvo.sponsor==GL.id){
//					var temp:Array=[];
//					var arr:Array=data.cards2;
//					for(var i:int in arr){
//						var ac:ACard=new ACard();
//						ac.setdata(arr[i]);
//						temp.push(ac);
//					}
//					bv.showCardDialog(temp,"请检视玩家手牌",0,0);
//				}else{
//					bv.showInfo("请等待猎鹰检视目标手牌");
//				}
//			}
//			
//			public function delayedFun2():void{
//				if(!data.cards1)return;
//				//				var p:Player=phash.get(tvo.sponsor);
//				//				p.view.showTime(10000);
//				//				if(p.uid==GL.id){
//				//					var temp:Array=[];
//				//					var arr:Array=data.cards1;
//				//					for(var i:int in arr){
//				//						var ac:ACard=new ACard();
//				//						ac.setdata(arr[i]);
//				//						temp.push(ac);
//				//					}
//				//					bv.showCardDialog(temp,"请选择任意张牌弃掉",temp.length,2);
//				//				}else{
//				//					bv.showInfo("请等待猎鹰操作");
//				//				}
//				
//				
//				var p:Player=phash.get(tvo.sponsor);
//				p.view.showTime(tvo.dur-1000);
//				if(tvo.sponsor==GL.id){
//					var temp:Array=[];
//					var arr:Array=phash.get(GL.id).hand;
//					for each(var c:ACard in arr){
//						if(c.color>2){
//							var acard:ACard=new ACard();
//							acard.setdata(c);
//							temp.push(acard);
//						}
//					}
//					bv.showCardDialog(temp,"请选择一张黑色手牌，不想放置请直接按确定",1,2);
//				}else{
//					bv.showInfo("有该名字的牌！请等猎鹰操作");
//				}
//			}

		}
}