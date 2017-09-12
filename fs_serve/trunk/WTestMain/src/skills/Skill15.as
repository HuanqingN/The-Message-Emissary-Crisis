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
	
	import views.ACard;

	/**
	 *遗志 
	 */	
	public class Skill15 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
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
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(9000);
			if(tvo.sponsor==GL.id){
				var temp:Array=[];
				var arr:Array=p.hand;
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择两张情报发动",2,2);
			}else{
				bv.showInfo("请等待老鬼操作");
			}
		}
	}
}