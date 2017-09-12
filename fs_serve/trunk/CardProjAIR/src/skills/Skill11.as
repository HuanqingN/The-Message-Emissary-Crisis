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
	 *黄雀在后 
	 */	
	public class Skill11 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(!i.isDead && !i.isLost){
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
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
				TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			var temp:Array=[];
			if(GL.id==tvo.sponsor){
				var p:Player=phash.get(tvo.sponsor);
				for(var i:int in p.hand){
					if(p.hand[i].color>2){
						var ac:ACard=new ACard();
						ac.setdata(p.hand[i]);
						temp.push(ac);
					}
				}
				bv.showCardDialog(temp,"请选择最多两张黑情报发动",2,2,targetid);
			}else{
				bv.showInfo("请等待黄雀操作");
			}
		}
	}
}