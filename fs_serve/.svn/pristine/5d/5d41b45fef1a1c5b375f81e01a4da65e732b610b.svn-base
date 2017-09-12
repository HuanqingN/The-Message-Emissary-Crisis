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
	 *仇恨 
	 */	
	public class Skill58 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			App.audio.play(Cons.audio.YELLOW);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(5,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(GL.id==p.uid){
				var temp:Array=[];
				var arr:Array=p.black;
				for (var i:int in arr) 
				{
					var c:ACard=new ACard();
					c.setdata(arr[i]);
					temp.push(c);
				}
				bv.showCardDialog(temp,"请选择一张情报发动",1,2,-1,userselected);
			}else{
				bv.showInfo("请等待大美女操作");
			}
		}
		private var cardvid:int;
		public function userselected(arr:Array):void{
			cardvid=arr[0];
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false && i.isLost==false && i.sex>0 && i.rid>0){
					targets.push(i.view);
				}
				if(i.uid==GL.id){
					bv.showInfo("请选择一个玩家并点击确定发动");
				}
			}
			this.showTarget();
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,card:cardvid,oid:bm.oid+2};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			cardvid=targetid=-1;
			clearState();
		}
		
	}
}