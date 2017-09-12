package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	import utils.effect.EffectsManager;
	
	import views.ACard;
	
	/**
	 *潜藏伏击 
	 */	
	public class Skill9 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
					if(i.black.length>0 || i.red.length>0 || i.blue.length>0)
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家发动");
			this.showTarget();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playTurnAni(0,obj.rid);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			App.audio.play(Cons.audio.TurnRole);
			var p:Player=phash.get(tvo.sponsor);
			p.rid=data.rid;
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			clearState();
			var p:Player=phash.get(targetid);
			var temp:Array=[];
			for(var i:int in  p.black){
				var ac:ACard=new ACard();
				ac.setdata(p.black[i]);
				temp.push(ac);
			}
			for(var i:int in  p.red){
				var ac:ACard=new ACard();
				ac.setdata(p.red[i]);
				temp.push(ac);
			}
			for(var i:int in  p.blue){
				var ac:ACard=new ACard();
				ac.setdata(p.blue[i]);
				temp.push(ac);
			}
			bv.showCardDialog(temp,"请选择一张情报发动",1,2,targetid,onselected);
		}
		
		public function onselected(arr:Array):void{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,cards:arr,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
		}
	}
}