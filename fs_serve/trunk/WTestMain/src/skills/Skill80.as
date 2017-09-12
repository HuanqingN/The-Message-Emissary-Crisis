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
	 * "蛊惑"
	 */	
	public class Skill80 extends Skill
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
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				TweenMax.delayedCall(1,delayedFun);
			}
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.rid=data.rid;
			var target:Player=phash.get(tvo.target);
			target.view.showTime(9000);
			if(target.uid==GL.id){
				var num:int=data.num;
				var temp:Array=[]
				for(var i:int=0;i<num;i++){
					var ac:ACard=new ACard();
					ac.bg.bitmapData=new Act0;
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择一张手牌",1,1);
			}else{
				bv.showInfo("请等待玩家操作");
			}
		}
		override public function excuteBlue():void
		{
			var target:Player=phash.get(tvo.sponsor);
			target.view.showTime(10000);
			if(target.uid==GL.id){
				var arr:Array=target.hand;
				var temp:Array=[]
				for(var i:int in arr){
					if(arr[i].color>2){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
					}
				}
				bv.showCardDialog(temp,"请选择一张黑色手牌",1,2);
			}else{
				bv.showInfo("请等待鬼魅操作");
			}
		}
	}
}