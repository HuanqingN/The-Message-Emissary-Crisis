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
	 * 阴谋
	 */
	public class Skill21 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur-1000);
			if(tvo.sponsor==GL.id){
				bv.showInfo("请选择你要抽取手牌的玩家");
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
					if(i.uid!=GL.id && i.isDead==false && !i.isLost){
						targets.push(i.view);
					}
				}
				this.showTarget();
			}else{
				bv.showInfo("请等待怪盗九九操作");
			}
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			bv.hideInfo();
			targetid=evt.currentTarget.uid;
			clearState();
			var p:Player=phash.get(targetid);
			var temp:Array=[];
			var len:int=int(p.view.hcount.label);
			for (var i:int = 0; i < len; i++) 
			{
				var c:ACard=new ACard();
				c.bg.bitmapData=new Act0;
				temp.push(c);
			}
			bv.showCardDialog(temp,"请选择要抽取的卡牌",1,1,targetid);
			clearState();
		}
	}
}