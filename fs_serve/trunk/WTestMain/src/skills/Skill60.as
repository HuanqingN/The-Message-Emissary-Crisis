package skills
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import utils.OBJUtil;
	import utils.Rand;
	
	import views.ACard;

	/**
	 * 偷龙转凤
	 */	
	public class Skill60 extends Skill
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
			var ca:ACard=new ACard;
			if(bm.sendingCard.send==2){
				ca.setdata(data.card);
			}else{
				ca.bg.bitmapData=OBJUtil.getInstanceByClassName("Act0_"+(data.card.send==3?0:1)) as BitmapData;			
			}
			ca.x=(Cons.BWID-ca.width)/2;
			ca.y=(Cons.BHEI-ca.height)/2;
			bv.addChild(ca);
			var from:Point=new Point(ca.x,ca.y);
			var to:Point=new Point(bm.sendingCard.x,bm.sendingCard.y);
			var ro:int=bm.sendingCard.rotation;
			TweenMax.to(ca,1,{x:to.x,y:to.y,rotation:ro});
			TweenMax.to(bm.sendingCard,1,{x:from.x,y:from.y,rotation:0});
			TweenMax.delayedCall(1,transEnd,[ca]);
		}
		public function transEnd(ca:ACard):void{
			bm.sendCardsTodispear([bm.sendingCard]);
			bm.sendingCard=ca;
		}
	}
}