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
	
	import core.mng.Assign;
	import core.mng.Evt;
	
	import datas.Cons;
	import datas.EvtCons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.CityViewUI;
	
	import handlers.RoomHandler;
	
	import morn.core.components.Button;
	
	import util.GUtil;
	
	public class CityView extends CityViewUI
	{
		private var titleStr:Array=["酒馆","驿站","道具店","墓地","教堂","铁匠铺","矿坑","工会","博石场","疗养院"];
		public function CityView()
		{
			super();
			Assign.inst.register(Cons.handler.RoomHandler,new RoomHandler);
			for (var i:int = 0; i < 10; i++) 
			{
				this["t"+(i+1)].btn.label=titleStr[i];
				addMouseEvt(this["t"+(i+1)]);
				if(i>0 && i<9){
					addMouseEvt(this["btn"+i]);
				}
			}
			msgArea=new MessgeArea();
			msgArea.x=940;
			App.log.addChild(msgArea);
			App.effect
			addMouseEvt(this.goldtxt);
			addMouseEvt(this.gemtxt);
			pname.text=GL.nick;
			lvtxt.text=GUtil.getLevelByExp(GL.exp);
			goldtxt.label=GL.coin.toString();
			addMouseEvt(shopbtn);
			Evt.add(Evt.onMessageShow,onMessageShow);
			Evt.add(Evt.onCollectionViewShow,onCollectionViewShow);
			Evt.add(Evt.onSettingViewShow,onSettingViewShow);
			Evt.add(Evt.onMsgViewShow,onMsgViewShow);
			Evt.add(RoomHandler.onBagUpdata,onBagUpdata);
			Evt.add(RoomHandler.onMoneyUpdata,onMoneyUpdata);
		}
		private function onMoneyUpdata(evt:WEvent):void
		{
			GL.coin=evt.param.num;
			goldtxt.label=GL.coin.toString();
		}
		
		private function onBagUpdata(evt:WEvent):void
		{
			GL.bag.put(evt.param.pid,evt.param.num);
			Evt.dipatch(EvtCons.ON_UPDATE_BAG,{pid:evt.param.pid});
		}
		private function onMsgViewShow(evt:WEvent):void{
			msgArea.visible=evt.param.isShow;
			msgArea.mouseChildren=msgArea.mouseEnabled=evt.param.isShow;
		}
		private function onSettingViewShow(evt:WEvent):void
		{
			if(!settingview){
				settingview=new SettingView();
				settingview.popupCenter=true;
			}
			settingview.alpha=1;
			App.dialog.show(settingview,true);
			TweenLite.from(settingview,1,{alpha:0.5,transformAroundCenter:{scaleX:0.5, scaleY:0.5}, ease:Elastic.easeOut});
		}
		
		private function onCollectionViewShow(evt:WEvent):void
		{
			if(!collectionview){
				collectionview=new CollectionView();
				collectionview.popupCenter=true;
			}
			collectionview.alpha=1;
			collectionview.showData(1);
			App.dialog.show(collectionview,true);
			TweenLite.from(collectionview,0.5,{x:-1000,ease:com.greensock.easing.Elastic.easeOut});
		}
		private var msgArea:MessgeArea;
		private function onMessageShow():void
		{
			
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
		private var rankview:RankView;
		private var roleInfo:RoleInfo;
		private var shopview:ShopView;
		private var collectionview:CollectionView;
		private var settingview:SettingView;
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
				case "shopbtn":
					if(!shopview){
						shopview=new ShopView();
						shopview.popupCenter=true;
					}
					shopview.showData();
					App.dialog.show(shopview,true);
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
					if(!roleInfo){
						roleInfo=new RoleInfo();
						roleInfo.popupCenter=true;
					}
					if(roleInfo.isPopup){
						if(roleInfo.uid==GL.id){
							roleInfo.close();
						}else{
							roleInfo.getRoleInfo(GL.id);						
						}
					}else{
						roleInfo.getRoleInfo(GL.id);						
						App.dialog.show(roleInfo,true);
					}
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
					if(!rankview){
						rankview=new RankView();
						rankview.popupCenter=true;
					}
					rankview.showData();
					App.dialog.show(rankview,true);
					break;
				case "btn7":
					if(!collectionview){
						collectionview=new CollectionView();
						collectionview.popupCenter=true;
					}
					collectionview.alpha=1;
					collectionview.showData();
					App.dialog.show(collectionview,true);
					TweenLite.from(collectionview,0.5,{x:-1000,ease:com.greensock.easing.Elastic.easeOut});
//					TweenLite.from(collectionview,1,{alpha:0.5,transformAroundCenter:{scaleX:0.5, scaleY:0.5}, ease:Elastic.easeOut});
					break;
				case "btn8":
					if(!settingview){
						settingview=new SettingView();
						settingview.popupCenter=true;
					}
					settingview.alpha=1;
					App.dialog.show(settingview,true);
					TweenLite.from(settingview,1,{alpha:0.5,transformAroundCenter:{scaleX:0.5, scaleY:0.5}, ease:Elastic.easeOut});
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