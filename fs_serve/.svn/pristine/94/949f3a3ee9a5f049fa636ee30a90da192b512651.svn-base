package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Player;
	
	import datas.SkillVO;
	
	import utils.Rand;

	/**
	 * 隐踪
	 */	
	public class Skill90 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			var p:Player=phash.get(tvo.sponsor);
			playTurnAni(p.rid,0);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
			p.rid=0;
		}
	}
}