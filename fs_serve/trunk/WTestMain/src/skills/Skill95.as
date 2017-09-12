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
	 * 挑拨
	 */	
	public class Skill95 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				if(obj.arrow){
					bm.showArrow(phash.get(tvo.target),phash.get(obj.to));
					return;
				}
				if(!obj.hasblack)return;
				var p:Player=phash.get(tvo.target);
				p.view.showTime(10000);
				if(GL.id==p.uid){
					var temp:Array=[];
					var arr:Array=p.hand;
					for (var i:int in arr) 
					{
						if(arr[i].color>2){
						var c:ACard=new ACard();
						c.setdata(arr[i]);
						temp.push(c);
						}
					}
					bv.showCardDialog(temp,"请选择一张黑情报",1,2);
				}else{
					bv.showInfo("请等待"+p.rname+"操作");
				}
			}else{
				playTurnAni(0,obj.rid);
//				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
				selectPlayers=[];
				TweenMax.delayedCall(1,delayedFun1);
			}
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			if(selectPlayers.length==0)
			p.view.showTime(10000);
			if(p.uid==GL.id){
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
					if(selectPlayers.length==0 || selectPlayers[0]!=i.uid)
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择第"+(selectPlayers.length+1)+"位玩家");
			this.showTarget();
			}else{
				bv.showInfo("请等待艾达王操作");
			}
		}
		private var targetid:int=-1;
		private var selectPlayers:Array;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			selectPlayers.push(evt.currentTarget.uid);
			clearState();
			if(selectPlayers.length<2){
				delayedFun1();
				return;
			}
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,targets:selectPlayers,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
		}
	}
}