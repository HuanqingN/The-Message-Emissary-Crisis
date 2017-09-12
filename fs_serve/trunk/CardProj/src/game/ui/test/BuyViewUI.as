/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class BuyViewUI extends Dialog {
		public var price:Label = null;
		public var img:Image = null;
		public var txt:Label = null;
		public var hs1:HSlider = null;
		public var confirmbtn:Button = null;
		public var counttxt:Label = null;
		public var numtxt:Label = null;
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.摧毁底色" x="0" y="0" width="388" height="349" sizeGrid="130,100,130,100"/>
			  <Image skin="png.custom.009gz1a" x="158" y="118"/>
			  <Image skin="png.custom.009gz1b" x="159" y="190" width="68" height="18" sizeGrid="5,5,5,5"/>
			  <Label x="167" y="190" width="62" height="18" color="0xffff00" align="center" var="price" name="price"/>
			  <Image skin="png.comp.coin" x="162" y="194" width="10" height="10"/>
			  <Image x="164" y="124" width="58" height="58" var="img" name="img"/>
			  <Image skin="png.custom.009gz1b" x="159" y="99" width="68" height="18" sizeGrid="5,5,5,5"/>
			  <Label x="161" y="99" width="62" height="18" color="0xccff" align="center" var="txt" name="txt" text="选人卡" size="12" stroke="0x333333"/>
			  <HSlider skin="png.custom.hslider_cc" x="108" y="230" min="1" max="100" showLabel="false" tick="1" var="hs1" name="hs1" width="179" height="8"/>
			  <Button label="确认购买" skin="png.custom.btn_3a" x="136" y="276" labelColors="0xffff9b,0xffffff,0x9b9b9b" labelFont="黑体" labelSize="17." letterSpacing="5" labelBold="true" labelStroke="0x0" var="confirmbtn" name="confirmbtn"/>
			  <Label text="购买" x="123" y="29" width="146" height="39" color="0xffff33" size="30" align="center" letterSpacing="10" stroke="0xcccccc"/>
			  <Label text="花费总金额 ＝ 10000" x="134" y="244" width="160" height="18" color="0xccff33" var="counttxt" name="counttxt"/>
			  <Label text="X 1" x="245" y="137" color="0xccff33" size="25" width="99" height="31" bold="true" var="numtxt" name="numtxt"/>
			  <Button skin="png.custom.btn_009gb" x="357" y="14" var="closebtn" name="closebtn"/>
			</Dialog>;
		public function BuyViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}