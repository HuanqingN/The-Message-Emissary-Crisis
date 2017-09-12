package views
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.MMNG;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.HallItemUI;
	import game.ui.test.HallUI;
	
	import handlers.LoginHandler;
	
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.data.Room;
	
	public class HallView extends HallUI
	{
		private var nowItem:HallItemUI;
		private var toPram:Array=[];
		private var items:Array=[];
		public function HallView()
		{
			super();
			App.audio.backPlay(Cons.audio.BACK);
			leftbtn.addEventListener(MouseEvent.CLICK,onBtnClick);
			rightbtn.addEventListener(MouseEvent.CLICK,onBtnClick);
			enter.addEventListener(MouseEvent.CLICK,onBtnClick);
			for(var i:int=1;i<=5;i++){
				this["bt"+i].bg.skin="png.custom."+i;
				items.push(this["bt"+i]);
				toPram.push({x:this["bt"+i].x,y:this["bt"+i].y,scaleX:this["bt"+i].scaleX,scaleY:this["bt"+i].scaleY,onUpdate:onUpdate});
			}
			nowItem=bt2;
			nowItem.front.visible=false;
			GL.currentRoomName=Cons.room.Hall;
		}
		
		override public function dispose():void
		{
			leftbtn.removeEventListener(MouseEvent.CLICK,onBtnClick);
			rightbtn.removeEventListener(MouseEvent.CLICK,onBtnClick);
			enter.removeEventListener(MouseEvent.CLICK,onBtnClick);
		}
		
		private function onUpdate():void{
			var temp:Array=items.concat();
			temp.sortOn("y",Array.NUMERIC|Array.DESCENDING);
//			for (var i:int = temp.length-1,j=0; i >=0; i--,j++) 
//			{
//				this.setChildIndex(items[i],j);
//			}
			for (var i:int = 0; i < temp.length; i++) 
			{
				this.setChildIndex(temp[i],i);
			}
			
		}
		protected function onBtnClick(event:MouseEvent):void
		{
			switch(event.currentTarget.name){			
				case "leftbtn":
					App.audio.play(Cons.audio.pageturn);
					for (var i:int = 0,j=4; i <5; i++,j++) 
					{
						if(j==5)j=0;
						TweenMax.to(items[i],0.8,toPram[j]);
					}
					App.audio.play(Cons.audio.hallmovie);
					items.push(items.shift());
					nowItem.front.visible=true;
					nowItem=items[1];
					nowItem.front.visible=false;
					break;
				case "rightbtn":
					App.audio.play(Cons.audio.pageturn);
					for (var i:int = 0,j=1; i <5; i++,j++) 
					{
						if(j==5)j=0;
						TweenMax.to(items[i],0.8,toPram[j]);
					}
					App.audio.play(Cons.audio.hallmovie);
					items.unshift(items.pop());
					nowItem.front.visible=true;
					nowItem=items[1];
					nowItem.front.visible=false;
					break;
				case "enter":
					switch(nowItem.name)
					{
						case "bt1":
					SFS.inst.joinRoom(Cons.room.Normal,onJoinSuccess);
							break;
						case "bt2":
					SFS.inst.joinRoom(Cons.room.Advance,onJoinSuccess);
							break;
						case "bt3":
					SFS.inst.joinRoom(Cons.room.Compete,onJoinSuccess);
							break;
						case "bt4":
					SFS.inst.joinRoom(Cons.room.Match,onJoinSuccess);
							break;
					}
					break;
			}
		}
		private function onJoinSuccess(evt:SFSEvent):void
		{
			var n:String=evt.params.room.getName();
			GL.currentRoomName=n;
			if(n==Cons.room.Hall){
				MMNG.inst.removeCurrentModule();
				MMNG.inst.loadModule(new HallView);
			}else{
				MMNG.inst.removeCurrentModule();
				MMNG.inst.loadModule(new RoomView);
			}
		}
	}
}