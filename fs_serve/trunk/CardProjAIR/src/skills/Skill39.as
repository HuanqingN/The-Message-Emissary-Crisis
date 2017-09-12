package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	import datas.Trans;
	
	import morn.core.components.Image;
	
	import utils.Rand;
	
	import views.ACard;

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
			}else if(obj.exchange){
				exchange();
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
		
		public function exchange():void
		{
//			var arr:Array=data.choosableTargets;
//			var temp:Array = [];
//			for each(var j:int in arr){
//				temp.push(phash.get(arr[j]));
//			}
//			var p:Player=phash.get(tvo.target);
//			targets=[];
//			for each(var i:Player in  temp){
//				if(i.black.length>0 || i.red.length>0 || i.blue.length>0)
//					targets.push(i.view);
//			}
			if(GL.id==tvo.sponsor){
				var arr:Array=phash.values();
				var p:Player=phash.get(tvo.target);
				targets=[];
				for each(var i:Player in  arr){
					if(i!=p 	&& (i.black.length>0 || i.red.length>0 || i.blue.length>0))
						targets.push(i.view);
				}
				bv.showInfo("请选择一个玩家");
				this.showTarget();
				phash.get(tvo.sponsor).view.showTime(tvo.dur);
			}else{
				bv.showInfo("请等待致命香水操作");
				phash.get(tvo.sponsor).view.showTime(tvo.dur);
			}
		}

		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			clearState();
			var p:Player=phash.get(targetid);
			var temp:Array=[];
			for(var i:int in  p.infocards){
				var ac:ACard=new ACard();
				ac.setdata(p.infocards[i]);
				temp.push(ac);
			}
			bv.showCardDialog(temp,"请选择一张情报",1,2,targetid,onselected);
		}
		
		public function onselected(arr:Array):void{
			App.log.info("arr.length is"+arr.length);
			App.log.info("bm.oid  is"+bm.oid);
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,cards:arr,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
		}
	}
}