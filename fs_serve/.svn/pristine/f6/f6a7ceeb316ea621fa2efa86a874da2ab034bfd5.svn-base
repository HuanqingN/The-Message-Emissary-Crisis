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
	 * 攻守兼备
	 */	
	public class Skill38 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1"+".mp3");
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
				bv.showInfo("请选择你要放回牌库顶的一张手牌");
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					cards.push(c);
				}
				this.showCards();
				phash.get(GL.id).view.showTime(tvo.dur-1000);
			}else{
				bv.showInfo("请等待致命香水操作");
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(tvo.dur-1000);
			}
		}
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			var param:Object={tid:GL.tableId,ctype:1,type:1,card:evt.currentTarget.vid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}