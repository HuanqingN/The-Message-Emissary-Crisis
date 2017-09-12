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
	import utils.effect.EffectsManager;
	
	import views.ACard;

	/**
	 * 解码
	 */	
	public class Skill155 extends Skill
	{
		override public function launch():void
		{
			bv.showInfo("请选择一张黑色密电");
			var arr:Array=phash.get(GL.id).hand;
			cards=[];
			for each(var c:ACard in arr){
				if(c.send==3 && c.color>=3)cards.push(c);
			}
			this.showCards();
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			clearState();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
//			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
		}
	}
}