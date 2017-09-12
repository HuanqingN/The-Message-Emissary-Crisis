package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	import utils.effect.EffectsManager;

	/**
	 *声东击西 
	 */	
	public class Skill27 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && !i.myTurn &&  !i.isDead && !i.isLost &&  !i.isLock && !i.isCaptal){
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
			if(obj.goOn){
				excuteBlue();
			}else{
				var p:Player=phash.get(tvo.sponsor);
				playTurnAni(p.rid,0);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				p.rid=0;
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