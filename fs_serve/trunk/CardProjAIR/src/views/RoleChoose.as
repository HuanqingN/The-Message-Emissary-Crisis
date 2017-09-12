package views
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.Trans;
	
	import game.ui.test.RoleChooseViewUI;
	
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	import utils.OBJUtil;
	import utils.StringUtils;
	import utils.effect.EffectsManager;
	
	public class RoleChoose extends RoleChooseViewUI
	{
		private var items:Array=[];
		public function RoleChoose()
		{
			super();
			for (var i:int = 0; i < 3; i++) 
			{
				var item:RoleChooseItem = new RoleChooseItem();
				item.x=37+150*i;
				item.y=144;
				items.push(item);
				addChild(item);
			}
			
		}
		private var oid:int=0;
		private var sec:int=15;
		public function init(obj:Object):void{
			oid=obj.oid;
//			pg.value=0;
//			App.timer.doFrameLoop(1,onProgress,[1/(App.stage.frameRate*10)]);	
			daojishi.text="00:"+sec;
			decrease();
//			App.timer.doFrameLoop(1,goOn,[1/(App.stage.frameRate*10)]);
			items[0].setData(obj.num1);
			items[1].setData(obj.num2);
			items[2].setData(obj.num3);
			items[0].addEventListener(MouseEvent.CLICK,onClick);
			items[1].addEventListener(MouseEvent.CLICK,onClick);
			items[2].addEventListener(MouseEvent.CLICK,onClick);
		}
		
		
		private var selectedCard:Object;
		protected function onClick(event:MouseEvent):void
		{
			if(selectedCard)
			EffectsManager.clearGlow(selectedCard as Sprite);
			      selectedCard=event.currentTarget;
				EffectsManager.Glow(selectedCard as Sprite,0xff0000,0.6,6,6,5);
				
				if(selectedCard && btn.disabled){
					btn.disabled=false;
					btn.label="确认选择";
					btn.addEventListener(MouseEvent.CLICK,onBtnClick);
				}
		}
		
		protected function onBtnClick(event:MouseEvent):void
		{
			var obj:Object={tid:GL.tableId,cid:selectedCard.data,ctype:1,oid:oid};
			
			SFS.send(Cons.extension.roomserv,Cons.cmd.ChooseRole,obj);
			btn.disabled=true;
//			btn.label="你已选择"+GL.roleData.get(obj.cid).n;
			btn.label="您已确认";
			items[0].removeEventListener(MouseEvent.CLICK,onClick);
			items[1].removeEventListener(MouseEvent.CLICK,onClick);
			items[2].removeEventListener(MouseEvent.CLICK,onClick);
		}
//		private function onProgress(num:Number):void{
//			pg.value+=num;
//			if(pg.value>=1){
//				App.timer.clearTimer(onProgress);
//			}
//		}
		private function decrease():void{
			sec-=1;
			if(sec>=10){
				daojishi.text="00:"+sec;
			}else{
				daojishi.text="00:0"+sec;
			}
			if(sec>0){
			TweenMax.delayedCall(1,decrease);;
			}
		}
		override public function dispose():void
		{
			super.dispose();
//			App.timer.clearTimer(onProgress);
			selectedCard=null;
		}
	}
}