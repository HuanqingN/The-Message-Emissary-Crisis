package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import views.ACard;

	/**
	 *点射 
	 */	
	public class Skill73 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if( !i.isDead && !i.isLost){
					if(i.black.length>0 || i.red.length>0 || i.blue.length>0)
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
			clearState();
			var target:Player=phash.get(targetid);
			var arr:Array=target.infocards;
			var temp:Array=[];
			for(var i:int in arr){
				var ac:ACard=new ACard();
				ac.setdata(arr[i]);
				temp.push(ac);
			}
			bv.showCardDialog(temp,"请选择一张情报发动",1,2,targetid,cardselected);
		}
		public function cardselected(arr:Array):void{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,card:arr[0],oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			//			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
			App.audio.play(Cons.audio.YELLOW);
		}
	}
}