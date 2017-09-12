package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	import views.ACard;

		/**
		 * 定税
		 */	
		public class Skill159 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				App.log.info("obj.nashui is "+(obj.nashui==true?"true":"false"));
				if(obj.nashui){
					delayedFun1();
				}else{
					playNormalAni();
					App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
					TweenMax.delayedCall(1.5,delayedFun);
					//				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
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
				bv.showInfo("一张【纳税】被洗入牌库");
				TweenMax.delayedCall(1.5,removeCards,[temp]);
			}
			
			
			public function removeCards(arr:Array):void{
				for  (var j:int in arr) 
				{
					bv.removeChild(arr[j]);
				}
//				TweenMax.delayedCall(1,delayedFun1);
			}
			
			public function delayedFun1():void
			{
//				var p:Player=phash.get(tvo.sponsor);
//				p.view.showTime(10000);
//				if(p.uid==GL.id){
//					bv.passView.setInfo("将这张纳税放置到自己面前还是交给税务局长？",2,1,"放置","给他");
//					bv.passView.x=(1000-bv.passView.width)/2;
//					bv.passView.y=440;
////					oid=evt.param.oid;
//					bv.passView.popupCenter=false;
//					App.dialog.show(bv.passView);
//				}else{
//					bv.showInfo("该玩家抽到了[纳税],请等待他操作");
//				}
				
//				if(data.hasOwnProperty("answer")){ 
//					var p:Player=phash.get(tvo.target);
					var p:Player=phash.get(data.targetuid);
					p.view.showTime(10000);
					var cards:Array = data.cards;
					if(p.uid==GL.id){
						var temp:Array=[];
						var arr:Array=data.cards;
						for(var i:int in arr){
							var ac:ACard=new ACard();
							ac.setdata(arr[i]);
							temp.push(ac);
						}	
						bv.showCardDialog(temp,"将【纳税】放到自己面前还是与另一张手牌一起交与税局？",1,70);
					}else{
						bv.showInfo(p.pname+"抽到了【纳税】，请等待他操作");
					}
//				}
			}
		}
}