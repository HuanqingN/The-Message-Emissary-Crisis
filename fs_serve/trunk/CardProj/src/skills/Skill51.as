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

	public class Skill51 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(7000);
				if(tvo.sponsor==GL.id){
					var temp:Array=[];
					var arr:Array=data.cards;
					for(var i:int in arr){
						var ac:ACard=new ACard();
						ac.setdata(arr[i]);
						temp.push(ac);
					}
					bv.showCardDialog(temp,"请检视玩家手牌",0,0);
				}else{
					bv.showInfo("请等待浮萍操作");
				}
			}else{
				playYellowAni();
				App.audio.play(Cons.audio.YELLOW);
				TweenMax.delayedCall(3,delayedFun1);
			}
		}
		
		public function  delayedFun1():void{
			if(tvo.sponsor==GL.id){
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家发动");
			this.showTarget();
			}else{
				bv.showInfo("请等待浮萍操作");
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