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
	 *合谋 
	 */	
	public class Skill4 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					targets.push(i.view);
				}
				if(i.uid==GL.id){
					bv.showInfo("请选择一个玩家并点击确定发动");
					bv.showSelectTarget("请选择完目标点击确定发动",onSelected);
				}
			}
			this.showTarget();
		}
		
		override public function excuteBlue():void
		{
			var p:Player=phash.get(tvo.sponsor);
			if(p.rid!=0){
				playTurnAni(p.rid,0);
				p.rid=0;
			}
			if(data.hasOwnProperty("answer")){  //询问要不要贴黑情报
				p.view.showTime(8000);
				if(p.uid==GL.id){
					var temp:Array=[];
					for(var i:int in p.hand){
						if(p.hand[i].color>2){
							var c:ACard=new ACard();
							c.setdata(p.hand[i]);
							temp.push(c);
						}
					}
					bv.showCardDialog(temp,"请选择是否盖伏目标角色",1,67);
				}else{
					bv.showInfo("请等待老枪操作");
				}
			}else{
//				playTurnAni(p.rid,0);
//				p.rid=0;
				if(data.target>0){
					var ta:Player=phash.get(data.target);
					ta.rid=0;
				}
			}
		}
		
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
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