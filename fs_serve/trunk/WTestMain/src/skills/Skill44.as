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
	import utils.effect.EffectsManager;
	
	import views.ACard;

	/**
	 * 收买
	 */
	public class Skill44 extends Skill
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
			clearState();
			var target:Player=phash.get(targetid);
			var arr:Array=target.infocards;
			var temp:Array=[];
			for(var i:int in arr){
				var ac:ACard=new ACard();
				ac.setdata(arr[i]);
				temp.push(ac);
			}
			bv.showCardDialog(temp,"请选择一张情报发动",1,2,targetid,userselected);
		}
		public function userselected(arr:Array):void{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,card:arr[0],oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void{
			var self:Player=phash.get(tvo.sponsor);
			self.view.showTime(9000);
			if(GL.id==tvo.sponsor){
				var temp:Array=[];
				for(var i:int in self.hand){
					var ac:ACard=new ACard();
					ac.setdata(self.hand[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择四张手牌发动",4,2);
			}else{
				bv.showInfo("请等待小白操作");
			}
		}
	}
}