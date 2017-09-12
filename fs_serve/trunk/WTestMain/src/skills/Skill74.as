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
	
	import views.ACard;

	/**
	 *一箭双雕 
	 */
	public class Skill74 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			delayedFun();
		}
		override public function playAni():void
		{
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
		}
		public function delayedFun1():void{
			if(tvo.sponsor==GL.id){
				bv.showInfo("请选择你要放置的一张黑色手牌");
				bv.showSelectTarget("请选择黑牌和目标后点击确定发动或取消",onSelected,true);
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					if(c.color>2)
						cards.push(c);
				}
				this.showCards();
			}else{
				bv.showInfo("请等待厄运小姐操作");
			}
		}
		override public function delayedFun():void
		{
			if(GL.id!=tvo.sponsor){
				data.to=tvo.sponsor;
				data.num=1;
				data.cards=null;
			}
			data.type=1;
			Evt.dipatch(BattleHandler.onAddCard,data);
			if(data.hasBlack==true)
			TweenMax.delayedCall(1,delayedFun1);
		}
		public function onSelected(str:String):void{
			if(str=="nobtn"){
				var param:Object={tid:GL.tableId,ctype:1,type:0,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
				return;
			}
			if(cardvid<0 || targetuid<0 ){
				bv.showInfo("请选择完成后再发动！");return;
			}
			var param:Object={tid:GL.tableId,ctype:1,target:targetuid,card:cardvid,type:1,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			targetuid=cardvid=-1;
			clearState();
		}
		private var targetuid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetuid=evt.currentTarget.uid;
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
				if(i.uid!=tvo.target && i.isDead==false && !i.isLost){
					targets.push(i.view);
				}
			}
			this.showTarget();
		}
	}
}