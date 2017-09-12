package views
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.RoleAreaUI;
	
	import manage.BM;
	
	import morn.core.components.Clip;
	
	import utils.Rand;
	
	public class RoleArea extends RoleAreaUI
	{
		public var uid:int;
		public var infoPos:Object;
		public function RoleArea()
		{
			super();
			g1.addEventListener(MouseEvent.CLICK,onclick);
			g2.addEventListener(MouseEvent.CLICK,onclick);
			g3.addEventListener(MouseEvent.CLICK,onclick);
			g4.addEventListener(MouseEvent.CLICK,onclick);
			g5.addEventListener(MouseEvent.CLICK,onclick);
			g6.addEventListener(MouseEvent.CLICK,onclick);
			g7.addEventListener(MouseEvent.CLICK,onclick);
			g8.addEventListener(MouseEvent.CLICK,onclick);
			rcount.addEventListener(MouseEvent.CLICK,onclick1);
			bcount.addEventListener(MouseEvent.CLICK,onclick1);
			gcount.addEventListener(MouseEvent.CLICK,onclick1);
		}
		private var targetmov:MovieClip;
		public function showTargetMov(boo:Boolean):void{
			if(boo){
				if(!targetmov)targetmov=new TargetMov();
				targetmov.x=this.width/2;
				targetmov.y=this.height/2;
				this.addChild(targetmov);
				targetmov.play();
			}else{
				if(targetmov && this.contains(targetmov)){
					this.removeChild(targetmov);
					targetmov.stop();
				}
			}
		}
		public function setBlack(num:int):void{
			var n:int=num-int(gcount.label);
			gcount.label=num.toString();
			if(n>0){
				for (var i:int = 0; i < n; i++) 
				{
					var clip:Clip=new Clip();
					clip.skin="png.comp.clip_hole";
					clip.clipX=3;
					clip.index=Rand.range(0,2);
					clip.rotation=Math.random()*360;
					clip.x=Rand.range(30,70);
					clip.y=Rand.range(30,70);
					addChild(clip);
					App.audio.play(Cons.audio.Black);
					TweenMax.to(clip,4,{alpha:0,onComplete:onHoldEnd,onCompleteParams:[clip]});
				}
				
			}
			blood=maxblood-num;
			setBlood();
		}
		public function onHoldEnd(clip:Clip):void{
			removeChild(clip);
			clip=null;
		}
		public function showChat(msg:String):void{
			msgpop.txt.text=msg;
			msgpop.txt.height=msgpop.txt.textField.textHeight+10;
			msgpop.bg.height=msgpop.txt.textField.textHeight+28;
			msgpop.visible=true;
			App.timer.doOnce(5000,onPopEnd);
		}
		public function onPopEnd():void{
			App.timer.clearTimer(onPopEnd);
			msgpop.visible=false;
		}
		protected function onclick1(event:MouseEvent):void
		{
			var p:Player=BM.inst.phash.get(this.uid);
			var arr:Array;
			if(event.currentTarget.name=="rcount"){
				arr=p.red;
			}else if(event.currentTarget.name=="bcount"){
				arr=p.blue;
			}else if(event.currentTarget.name=="gcount"){
				arr=p.black;
			}
			if(arr){
				var temp:Array=[];
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				BM.inst.bv.showCardDialog(temp,"情报区",0,9);
			}
		}
		
		protected function onclick(event:MouseEvent):void
		{
			switch(event.currentTarget.name)
			{
				case "g1":
					g2.visible=g3.visible=g4.visible=g5.visible=g6.visible=g7.visible=g8.visible=!g2.visible;
					break;
				default:{
				    g1.skin=event.currentTarget.skin;
					g2.visible=g3.visible=g4.visible=g5.visible=g6.visible=g7.visible=g8.visible=false;
				}
			}
		}
		
		public function showTime(dur:int):void{
			pg.value=0;
//			App.timer.doFrameLoop(1,onProgress,[1/(App.stage.frameRate*(dur/1000))]);
			App.timer.doLoop(100,onProgress,[1/(dur/100)]);
		}
		
		private function onProgress(num:Number):void{
			pg.value+=num;
			if(pg.value>=1){
				App.timer.clearTimer(onProgress);
				if(uid==GL.id)
				BM.inst.clearState(true);
				pg.value=0;
			}
		}
		
		public function clearTime():void{
			App.timer.clearTimer(onProgress);
			pg.value=0;
		}
		public function offLine(b:Boolean):void{
			state.text=b?"离线":"";	
		}
		public function trusttee(b:Boolean):void{
			state.text=b?"托管":"";	
		}
		public var blood:int=3;
		public var maxblood:int=3;
		public function initBloodBar(c:int):void
		{
			blood=c;
			maxblood=c;
			setBlood();
		}
		public function setBlood():void{
			for (var i:int = 1; i <= 4; i++) 
			{
				if(blood>2)this["b"+i].index=1;
				else if(blood==2)this["b"+i].index=2;
				else if(blood==1)this["b"+i].index=3;
				this["b"+i].visible=i<=blood;					
			}
		}
	}
}