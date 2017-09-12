package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import views.ACard;

	/**
	 *出卖  
	 */	
	public class Skill45 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost && int(i.view.hcount.label)>0){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家发动");
			this.showTarget();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					var tp:Player=phash.get(tvo.target);
					var arr:Array=tp.infocards;
					var temp:Array=[];
					for(var i:int in arr){
							var ac:ACard=new ACard();
							ac.setdata(arr[i]);
							temp.push(ac);
					}
					bv.showCardDialog(temp,"请选择一张情报发动",1,2);
				}else{
					bv.showInfo("请等待小白操作");
				}
			}else{
				playYellowAni();
				App.audio.play(Cons.audio.YELLOW);
				TweenMax.delayedCall(3,delayfun);
			}
		}
		public function delayfun():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				var arr:Array=p.infocards;
				var temp:Array=[];
				for(var i:int in arr){
					if(arr[i].color!=3){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
					}
				}
				bv.showCardDialog(temp,"请选择两张红或蓝情报发动",2,2);
			}else{
				bv.showInfo("请等待小白操作");
			}
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			clearState();
		}
	}
}