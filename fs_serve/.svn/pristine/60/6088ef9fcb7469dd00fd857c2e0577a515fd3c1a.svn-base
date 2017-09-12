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
		 * 灭口
		 */	
		public class Skill141 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playYellowAni();
				App.audio.play(Cons.audio.YELLOW);
				TweenMax.delayedCall(3,delayedFun);
			}
			override public function delayedFun():void
			{
				var p:Player=phash.get(tvo.sponsor);
				if(p.uid==GL.id){
					var temp:Array=[];
					for(var i:int in p.hand){
						if(p.hand[i].color>2){
							var c:ACard=new ACard();
							c.setdata(p.hand[i]);
							temp.push(c);
						}
					}
					bv.showCardDialog(temp,"请选择最多三张黑牌",3,2);
				}else{
					bv.showInfo("请等待无面操作");
				}
			}
		}
}