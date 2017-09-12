package views
{
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	
	import datas.EvtCons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.ShopItemUI;
	import game.ui.test.ShopUI;
	
	import handlers.RoomHandler;
	
	import utils.HashMap;
	
	public class ShopView extends ShopUI
	{
		public function ShopView()
		{
			super();
			closebtn.addEventListener(MouseEvent.CLICK,onCLose);
			for (var j:int = 0; j < 8; j++) 
			{
				this["sitem"+j].btn.data=j;
				this["sitem"+j].btn.addEventListener(MouseEvent.CLICK,onBuy);
			}
			Evt.add(EvtCons.ON_UPDATE_BAG,ON_UPDATE_BAG);
			Evt.add(RoomHandler.onMoneyUpdata,onMoneyUpdata);
		}
		
		private function onMoneyUpdata(evt:WEvent):void
		{
			GL.coin=evt.param.num;
			cointxt.text=GL.coin.toString();			
		}
		
		private function ON_UPDATE_BAG(evt:WEvent):void
		{
			for (var j:int = 0; j < 8; j++) 
			{
				if(this["sitem"+j].data && this["sitem"+j].data.id==evt.param.pid){
					this["sitem"+j].ntxt.text=GL.bag.get(evt.param.pid);
				}
			}		
		}
		private var toggleType:int=1;
		protected function onCLose(event:MouseEvent):void
		{
			this.close();			
		}
		private var buyview:BuyView;
		protected function onBuy(event:MouseEvent):void{
			var d:Object=this["sitem"+event.currentTarget.data].data;
			if(!buyview){
				buyview=new BuyView();
				buyview.popupCenter=true;
			}
			buyview.setData(d);
			buyview.popup();
		}
		
		public function showData():void
		{
			cointxt.text=GL.coin+"";
			var hash:HashMap=GL.propData;
			var arr:Array=hash.values();
			var temp:Array=[];
			for(var i:int in arr){
				if(arr[i].tag==toggleType){
					temp.push(arr[i]);
				}
			}
			if(temp.length>0){
				for (var j:int = 0; j < 8; j++) 
				{
					if(temp[j]){
						this["sitem"+j].visible=true;
						this["sitem"+j].data=temp[j];
						setData(this["sitem"+j],temp[j]);
					}else{
						this["sitem"+j].data=null;
						this["sitem"+j].visible=false;
					}
				}
			}
		}
		
		private function setData(siu:ShopItemUI, dat:Object):void
		{
			siu.img.url="assets/icons/"+dat.id+".jpg";
			siu.price.text=dat.cv;
			siu.txt.text=dat.n;
			siu.ntxt.text= GL.bag.containsKey(dat.id)?GL.bag.get(dat.id):"0";
		}
	}
}