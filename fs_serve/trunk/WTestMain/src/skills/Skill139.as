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

		/**
		 * 脱逃
		 */	
		public class Skill139 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
				TweenMax.delayedCall(1,delayedFun);
			}
			override public function delayedFun():void
			{
				var p:Player=phash.get(tvo.sponsor);
				p.isLock=false;
				if(GL.id!=tvo.sponsor){
					data.to=tvo.sponsor;
					data.num=1;
					data.cards=null;
				}
				data.type=1;
				Evt.dipatch(BattleHandler.onAddCard,data);
			}
		}
}