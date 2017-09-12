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
	 * 换日
	 */	
	public class Skill12 extends Skill
	{
		override public function launch():void
		{
			bv.showInfo("请选择一张黑色手牌");
			var arr:Array=phash.get(GL.id).hand;
			cards=[];
			for each(var c:ACard in arr){
				if(c.color>2)cards.push(c);
			}
			this.showCards();
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
			bv.showInfo("请选择你要锁定的玩家");
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false && !i.isLost){
					targets.push(i.view);
				}
			}
			this.showTarget();
		}
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:evt.currentTarget.uid,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			clearState();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
		}
	}
}