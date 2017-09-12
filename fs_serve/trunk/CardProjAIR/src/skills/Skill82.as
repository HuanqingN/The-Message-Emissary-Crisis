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
	 * "迷杀"
	 */	
	public class Skill82 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			App.audio.play(Cons.audio.YELLOW);
			TweenMax.delayedCall(3,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			playTurnAni(p.rid,0);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			p.rid=0;
			TweenMax.delayedCall(2,delayedFun2);
		}
		public function delayedFun2():void{
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