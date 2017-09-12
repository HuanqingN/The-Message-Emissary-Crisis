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
	import core.mng.Evt;
	import handlers.BattleHandler;

		/**
		 * 罚税
		 */	
	public class Skill161 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					for(var j:int in i.infocards){
						if(i.infocards[j].vid >=200 && i.infocards[j].vid<300){
							targets.push(i.view);
							break;
						}
					}
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
			if(obj.goOn){
				excuteBlue();
			}else{
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
				playNormalAni();
				//				App.audio.play(Cons.audio.TurnRole);
				TweenMax.delayedCall(1,delayedFun);
			}
		}
		
		override public function delayedFun():void
		{
			Evt.dipatch(BattleHandler.onShowIden,data);
		}
		
		override public function excuteBlue():void
		{
			var p:Player=phash.get(tvo.sponsor);
			if(p.uid==GL.id){
				var temp:Array=[];
				for(var i:int in p.hand){
					if(p.hand[i].color>2){
						var c:ACard=new ACard();
						c.setdata(p.hand[i]);
						temp.push(c);
					}
				}
				bv.showCardDialog(temp,"请选择最多3张卡",3,2);
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