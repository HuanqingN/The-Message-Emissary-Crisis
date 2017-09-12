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
		 * 峰回路转
		 */	
		public class Skill145 extends Skill
		{
			override public function launch():void
			{
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
					if(!i.isDead && !i.isLost && i.uid!=GL.id){
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
				playNormalAni();
//				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
//				TweenMax.delayedCall(1,delayedFun1);
			}
		}
}