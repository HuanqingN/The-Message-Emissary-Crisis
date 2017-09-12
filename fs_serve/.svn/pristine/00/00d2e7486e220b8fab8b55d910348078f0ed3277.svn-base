package skills
{
	import flash.events.MouseEvent;
	import core.mng.Player;
	import core.mng.SFS;
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	import utils.Rand;
	
	import views.ACard;
	
	/**
	 *强心：翻开此角色牌，然后烧毁一张黑情报
	 */	
	public class Skill142 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(!i.isDead && !i.isLost && i.black.length>0){
					targets.push(i.view);
				}
				if(i.uid==GL.id){
					bv.showInfo("请选择一位玩家发动");
				}
			}
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
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
		}
		
		override public function excuteBlue():void
		{
//			var cards:Array=data.cards;
//			var temp:Array=[];
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur);
			if(p.uid==GL.id){
				var target:Player=phash.get(tvo.target);
				var arr:Array=target.black;
				var temp:Array=[];
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择一张黑情报发动",1,2);
			}else{
				bv.showInfo("请等待双面药师操作");
			}
		}
	}
}