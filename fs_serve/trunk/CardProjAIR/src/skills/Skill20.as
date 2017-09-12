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
	 *英雄本色 
	 */
	public class Skill20 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			delayedFun();
		}
		override public function playAni():void
		{
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,4)+".mp3");
		}
		override public function delayedFun():void
		{
			data.uid=tvo.sponsor;
			Evt.dipatch(BattleHandler.onAddCard,data);
			TweenMax.delayedCall(1,delayedFun1);
		}
		public function delayedFun1():void{
			if(data.pass==true)return;
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur-1000);
			if(tvo.sponsor==GL.id){
				bv.showInfo("请选择你要放置的一张黑色手牌");
				bv.showSelectTarget("请选择黑牌和目标后点击确定发动",onSelected,true);
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					if(c.color>2)
						cards.push(c);
				}
				this.showCards();
			}else{
				bv.showInfo("请等待小马哥操作");
			}
		}
		public function onSelected(str:String):void{
			var param:Object={target:targetuid,tid:GL.tableId,ctype:1,type:1,card:cardvid,oid:bm.oid};
			if(cardvid<0 || targetuid<0 || str=="nobtn")param.type=0;
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			targetuid=cardvid=-1;
			clearState();
		}
		private var targetuid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetuid=evt.currentTarget.uid;
			clearState();
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
//			clearState();
			bv.showInfo("请选择你要放置黑情报的玩家");
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.isDead==false && !i.isLost){
					targets.push(i.view);
				}
			}
			this.showTarget();
		}
	}
}