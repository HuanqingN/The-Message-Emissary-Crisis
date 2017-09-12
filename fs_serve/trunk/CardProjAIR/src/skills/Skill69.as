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
	import utils.effect.EffectsManager;
	
	import views.ACard;

	/**
	 * 联动
	 */	
	public class Skill69 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			
			data.uid=tvo.sponsor;
			Evt.dipatch(BattleHandler.onAddCard,data);
			TweenMax.delayedCall(1,delayedFun1);
		}
		public function delayedFun1():void{
			if(tvo.sponsor==GL.id){
				bv.showInfo("请选择你要给予的一张手牌");
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					cards.push(c);
				}
				this.showCards();
				phash.get(GL.id).view.showTime(tvo.dur-1000);
			}else{
				bv.showInfo("请等待柒佰操作");
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(tvo.dur-1000);
			}
		}
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			var param:Object={target:evt.currentTarget.uid,tid:GL.tableId,ctype:1,type:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
			bv.showInfo("请选择你要给予的玩家");
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false && !i.isLost){
					targets.push(i.view);
				}
			}
			this.showTarget();
		}
	}
}