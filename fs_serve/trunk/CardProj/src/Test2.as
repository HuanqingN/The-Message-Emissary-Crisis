package
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.ServerInfo;
	
	import morn.core.components.Button;
	import morn.core.components.LayoutBox;
	import morn.core.handlers.Handler;
	
	import utils.OBJUtil;
	
	import views.ACard;
	import views.BattleView;
	import views.TipView;

	public class Test2 extends Sprite
	{
		public function Test2()
		{
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf","assets/custom.swf","assets/rpg.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		private function loadProgress(value:Number):void {
		}
		private var  acts:Array=[
			new Act0_0,new Act0_1,new Act1_1,new Act2_1,new Act3_1,new Act4_1
		];		
		private function loadComplete():void {
			drawHandArea();
		}
		
		private var handArea:Sprite;
		private function drawHandArea():void//创建手牌区
		{
			var b:BattleView=new BattleView();
			addChild(b);
			handArea=new Sprite();
			handArea.graphics.beginFill(0x0,1);
			handArea.graphics.drawRect(0,0,710,140);
			handArea.graphics.endFill();
			handArea.x=149;
			handArea.y=530;
			handArea.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			addChild(handArea);
			b.bt3.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			
		}
		
		protected function onClick(event:MouseEvent):void
		{
			addCard();
		}
		private var cards:Array=[];
		private var awid:int=710;//手牌区宽
		private var ahei:int=140;//手牌区高
		private var cwid:int=85;//卡牌的宽
		private var chei:int=120;//卡牌高
		private function addCard():void
		{
			var c:ACard=new ACard();
			c.bg.bitmapData=acts[2];
			c.x=350;
			c.y=-300;
			handArea.addChild(c);
			layoutHandArea();
		}
		
		public function layoutHandArea():void
		{
			var len:int=handArea.numChildren;
			var arr:Array=[];
			for (var i:int = 0; i <len; i++) 
			{
				arr.push(handArea.getChildAt(i));
			}
			if(arr.length<1)return;
			var pos:Array=OBJUtil.getCenterPos(awid,ahei,len,cwid,chei);
			
			for(var j:int in arr){
				TweenMax.to(arr[j],0.5,{x:pos[j].x,y:pos[j].y});
			}
		}
	}
}