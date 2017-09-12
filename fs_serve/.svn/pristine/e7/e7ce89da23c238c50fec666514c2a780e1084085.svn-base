package views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.BuyViewUI;
	
	import morn.core.components.HSlider;
	import morn.core.handlers.Handler;
	
	public class BuyView extends BuyViewUI
	{
		public function BuyView()
		{
			super();
			closebtn.addEventListener(MouseEvent.CLICK,onCLose);
			hs1.changeHandler=new Handler(onChange,[hs1]);
			confirmbtn.addEventListener(MouseEvent.CLICK,onBuy);
		}
		
		protected function onBuy(event:MouseEvent):void
		{
			var param:Object={};
			param.num=hs1.value;
			param.pid=data.id;
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.BuyProp,param);
			onCLose(null);
		}
		public function onChange(hs:HSlider,value:int):void{
			numtxt.text="X "+hs.value;
			counttxt.text="花费总金额 ＝ "+hs1.value*data.cv;
		}
		protected function onCLose(event:MouseEvent):void
		{
				this.close();			
		}
		
		public function setData(d:Object):void
		{
			this.data=d;
			img.skin="png.custom."+d.id;
			price.text=d.cv;
			txt.text=d.n;
			numtxt.text="X 1";
			hs1.value=1;
			hs1.max=int(GL.coin/d.cv);
			counttxt.text="花费总金额 ＝ "+hs1.value*d.cv;
		}
	}
}