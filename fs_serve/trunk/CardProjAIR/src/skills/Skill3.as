package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import utils.Rand;
	/**
	 * 就计
	 */
	public class Skill3 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playTurnAni(0,obj.rid);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
			App.audio.play(Cons.audio.TurnRole);
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.rid=data.rid;
			data.uid=tvo.sponsor;
			Evt.dipatch(BattleHandler.onAddCard,data);
		}
	}
}