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

		/**
		 * 献唱
		 */	
		public class Skill108 extends Skill
		{
			override public function launch():void
			{
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
					if(!i.myTurn &&  !i.isDead && !i.isLost && i.uid!=GL.id && !i.isLock && !i.isCaptal){
						targets.push(i.view);
					}
				}
				bv.showInfo("请选择一个玩家发动");
				this.showTarget();
			}
			private var targetid:int=-1;
			override protected function onTargetSelect(evt:MouseEvent):void
			{
				targetid=evt.currentTarget.uid;
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				clearState();
			}
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playTurnAni(0,obj.rid);
				App.audio.play(Cons.audio.TurnRole);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
				TweenMax.delayedCall(1,delayedFun1);
			}
			public function delayedFun1():void{
				var p:Player=phash.get(tvo.target);
				p.isSkip=true;
			}
		}
}