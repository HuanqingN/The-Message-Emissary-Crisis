package skills
{
	import datas.SkillVO;
	import core.mng.Player;
	import utils.Rand;

	/**
	 * 去无踪
	 */	
	public class Skill164 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			var p:Player=phash.get(tvo.sponsor);
			playTurnAni(p.rid,0);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,6)+".mp3");
			p.rid=0;
		}
	}
}