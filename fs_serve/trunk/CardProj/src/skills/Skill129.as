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
		 * 追查
		 */	
		public class Skill129 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
				if(data.cards){
					var c:ACard=ACard(bm.usecardstack[bm.usecardstack.length-1]);
					c.setdata(data.cards);
					c.target=null;
				}
//				TweenMax.delayedCall(1,delayfun);
			}
//			public function delayfun():void{
//				App.log.info("ssss   "+  data.cards);
//				App.log.info("ssss   "+  bm.usecardstack.length);
//				App.log.info("ssss   "+  bm.usecardstack[bm.usecardstack.length-1]);
//				if(data.cards)
//					
//			}
		}
}