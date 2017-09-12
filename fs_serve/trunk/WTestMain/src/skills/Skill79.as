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
	 *胸有成竹 你的回合出牌阶段,指定一名其它玩家随机抽取你的一张手牌作为他的情报
	 */
	public class Skill79 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					targets.push(i.view);
				}
				if(i.uid==GL.id){
					bv.showInfo("请选择一个玩家并点击确定发动");
					bv.showSelectTarget("请选择完目标点击确定发动",onSelected);
				}
			}
			this.showTarget();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
//			App.audio.play(Cons.audio.YELLOW);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(3,delayedFun);
		}
		override public function delayedFun():void{
			Evt.dipatch(BattleHandler.onShowIden,data);
			TweenMax.delayedCall(3,delayedFun1);
		}
		public function delayedFun1():void{
			targetid=data.target1;
			var p:Player=phash.get(targetid);
			p.view.showTime(10000);
			if(GL.id==p.uid){
				var temp:Array=[];
				var len:int=data.num;
				for (var i:int = 0; i < len; i++) 
				{
					var c:ACard=new ACard();
					c.bg.bitmapData=new Act0;
					temp.push(c);
				}
				bv.showCardDialog(temp,"请选择要抽取的卡牌",1,1);
			}else{
				bv.showInfo("请等待"+p.rname+"操作");
			}
		}
		public function onSelected(str:String):void{
			if(targetid<0){
				bv.showInfo("请选择目标后再确定发动");
				return;
			}
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,sid:id,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			targetid=-1;
			bm.clearState(true);
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			clearState();
		}
	}
}