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
	 *风度 
	 */	
	public class Skill70 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1.mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost && (i.sex!=1 || i.rid==22)){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一位女性发动");
			this.showTarget();
			}else{
				bv.showInfo("请等待柒佰操作");
			}
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}