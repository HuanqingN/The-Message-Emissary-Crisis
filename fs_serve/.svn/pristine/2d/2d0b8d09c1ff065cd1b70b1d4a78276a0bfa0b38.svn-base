package views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import datas.GL;
	
	import game.ui.test.CityViewUI;
	
	import morn.core.components.Button;
	
	import util.GUtil;
	
	public class CityView extends CityViewUI
	{
		private var titleStr:Array=["酒馆","驿站","道具店","墓地","教堂","铁匠铺","矿坑","工会","博石场","疗养院"];
		public function CityView()
		{
			super();
			for (var i:int = 0; i < 10; i++) 
			{
				this["t"+(i+1)].btn.label=titleStr[i];
				addMouseEvt(this["t"+(i+1)]);
				if(i>0 && i<9){
					addMouseEvt(this["btn"+i]);
				}
			}
			App.effect
			addMouseEvt(this.goldtxt);
			addMouseEvt(this.gemtxt);
			pname.text=GL.nick;
			lvtxt.text=GUtil.getLevelByExp(GL.exp);
			goldtxt.label=GL.coin.toString();
		}
		private function addMouseEvt(btn:Sprite):void{
			App.effect.add(btn,0.1, {transformAroundCenter:{scaleX:0.8, scaleY:0.8}, ease:Linear.easeNone},{transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
//			btn.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			btn.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
//			btn.addEventListener(MouseEvent.ROLL_OUT,onMouseRollout);
		}
			
		private var gamblingStone:GamblingStoneView;
//		private function onMouseRollout(evt:MouseEvent):void{
//			TweenLite.to(evt.currentTarget,1, {transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
//		}
		private var setOutView:SetOutView;
		private var roomView:RoomView;
		private function onMouseUp(evt:MouseEvent):void{
			TweenLite.to(evt.currentTarget,1, {transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
			switch(evt.currentTarget.name)
			{
				case "t1"://博石场
					if(!gamblingStone)gamblingStone=new GamblingStoneView();
					gamblingStone.x=gamblingStone.y=0;
					gamblingStone.alpha=1;
					App.scene.addChild(gamblingStone);
					TweenLite.from(gamblingStone,0.5,{x:-1000,ease:com.greensock.easing.Elastic.easeOut});
					break;
				case "t2":
					break;
				case "t3":
					break;
				case "t4":
					break;
				case "t5":
					break;
				case "t6":
					break;
				case "t7"://副本
					if(!setOutView)setOutView=new SetOutView();
					setOutView.x=setOutView.y=0;
					setOutView.alpha=1;
					App.scene.addChild(setOutView);
					TweenLite.from(setOutView,0.5,{x:-1000,ease:com.greensock.easing.Elastic.easeOut});
					break;
				case "t8":
					break;
				case "t9":
					if(!roomView)roomView=new RoomView();
					roomView.x=roomView.y=0;
					roomView.alpha=1;
					App.scene.addChild(roomView);
					TweenLite.from(roomView,0.5,{x:-1000,ease:com.greensock.easing.Elastic.easeOut});
					break;
				case "t10":
					break;
				case "btn1":
					break;
				case "btn2":
					break;
				case "btn3":
					break;
				case "btn4":
					break;
				case "btn5":
					break;
				case "btn6":
					break;
				case "btn7":
					break;
				case "btn8":
					break;
				case "btn9":
					
					break;
			}
		}
//		private function onMouseDown(evt:MouseEvent):void{
//			TweenLite.to(evt.currentTarget,0.1, {transformAroundCenter:{scaleX:0.8, scaleY:0.8}, ease:Linear.easeNone});
//		}
	}
}