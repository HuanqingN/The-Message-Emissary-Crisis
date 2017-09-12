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
	
	import utils.Rand;
	
	import views.ACard;

		/**
		 * 纳税
		 */	
		public class Skill162 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				App.log.info("playing clent skill162");
				super.play(tvo1,obj);
//				playNormalAni();
				TweenMax.delayedCall(1,delayedFun);
			}
			
			override public function delayedFun():void{
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
//					bv.showCardDialog(temp,"将【纳税】放到自己面前还是与另一张手牌一起交与税局？",1,70);
					bv.showCardDialog(temp,"将这张【纳税】放到自己面前还是交与税务局长？",1,70);
				}else{
					bv.showInfo(p.pname+"抽到了【纳税】，请等待他操作");
				}
			}
		}
}