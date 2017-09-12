package skills
{
	import datas.SkillVO;
	import core.mng.Player;

	/**
	 * 斗转星移
	 */	
	public class Skill99 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			var p:Player=phash.get(tvo.sponsor);
			playTurnAni(p.rid,0);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
			p.rid=0;
		}
	}
}