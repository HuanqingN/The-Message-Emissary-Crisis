package skills
{
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	import datas.Trans;
	
	import morn.core.components.Image;
	
	import utils.Rand;

	/**
	 *临危受命 
	 */	
	public class Skill39 extends Skill
	{
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
		override public function excuteBlue():void
		{
			var target:Player=phash.get(tvo.target);
			var from:Player=phash.get(tvo.sponsor);
			if(from.uid!=GL.id){
				bv.showInfo("等待致命香水操作");
				return;
			}
			var iden:int=data.iden;
			var img:Image=new Image();
			img.width=85;
			img.height=120;
			if(iden==0)img.bitmapData=new Iden0;
			else if(iden==1)img.bitmapData=new Iden1;
			else if(iden==2)img.bitmapData=new Iden2;
			
			var p1:Point=new Point(target.view.x+target.view.g1.x,target.view.y+target.view.g1.y);
			var p3:Point=new Point(from.view.x+from.view.g1.x,from.view.y+from.view.g1.y);
			var p2:Point=new Point((Cons.BWID-85)/2,(Cons.BHEI-120)/2);
			img.scaleX=img.scaleY=0;
			img.x=p1.x;
			img.y=p1.y;
			bv.addChild(img);
			TweenMax.to(img,1,{x:p2.x,y:p2.y,scaleX:1,scaleY:1});
			TweenMax.delayedCall(2,idenShowed,[img,p3,iden,target]);
		}
		private function idenShowed1(img:Image,iden:int,target:Player):void{
			bv.removeChild(img);
			img=null;
			target.view.g1.skin=Trans.getSkinByIdentity(3);
			target.view.g1.mouseEnabled=false;
			var from:Player=phash.get(tvo.sponsor);
			from.view.g1.skin=Trans.getSkinByIdentity(iden);
			from.iden=iden;
		}
		private function idenShowed(img:Image,p:Point,iden:int,target:Player):void{
			TweenMax.to(img,1,{x:p.x,y:p.y,scaleX:0,scaleY:0});
			TweenMax.delayedCall(1,idenShowed1,[img,iden,target]);
		}
	}
}