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
	 * "集结"
	 */	
	public class Skill85 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					if(i.black.length>0)
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
			playYellowAni();
			App.audio.play(Cons.audio.YELLOW);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(3,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(GL.id==p.uid){
				var temp:Array=[];
				var arr:Array=data.cards;
				for (var i:int in arr) 
				{
					var c:ACard=new ACard();
					c.setdata(arr[i]);
					temp.push(c);
				}
				bv.showCardDialog(temp,"请选择一张情报",1,2);
			}else{
				bv.showInfo("请等待老兵操作");
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