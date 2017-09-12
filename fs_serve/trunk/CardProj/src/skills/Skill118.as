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
	import datas.Trans;
	
	import handlers.BattleHandler;
	
	import utils.Rand;

		/**
		 * 掩饰
		 */	
		public class Skill118 extends Skill
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
				if(GL.id!=tvo.sponsor){
					data.to=tvo.sponsor;
					data.num=1;
					data.cards=null;
				}
				data.type=1;
				Evt.dipatch(BattleHandler.onAddCard,data);
				TweenMax.delayedCall(1,delayedFun1);
			}
			public function delayedFun1():void{
				var p:Player=phash.get(tvo.sponsor);
				if(GL.id==p.uid){
					p.iden=data.newiden;
				}else{
					p.view.g1.skin=Trans.getSkinByIdentity(3);
					p.view.g1.mouseEnabled=true;
				}
			}
		}
}