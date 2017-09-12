/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class ShopItemUI extends View {
		public var btn:Button = null;
		public var price:Label = null;
		public var img:Image = null;
		public var txt:Label = null;
		public var ntxt:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.009gz1a" x="0" y="19" url="assets/icons/frame1.png"/>
			  <Image skin="png.custom.009gz1b" x="1" y="91" width="68" height="18" sizeGrid="5,5,5,5" url="assets/icons/tine.png"/>
			  <Button label="购买" skin="png.custom.btn_012hs" x="1" y="112" width="68" labelColors="0xffffff,0xffffff,0xffffff" labelSize="15" var="btn" name="btn"/>
			  <Label x="9" y="91" width="62" height="18" color="0xffff00" align="center" var="price" name="price"/>
			  <Image skin="png.comp.coin" x="4" y="95" width="10" height="10"/>
			  <Image x="6" y="25" width="58" height="58" var="img" name="img"/>
			  <Image skin="png.custom.009gz1b" x="1" y="0" width="68" height="18" sizeGrid="5,5,5,5" url="assets/icons/tine.png"/>
			  <Label x="5" y="0" width="62" height="18" color="0xccff" align="center" var="txt" name="txt" text="选人卡" size="12" stroke="0x333333"/>
			  <Image skin="png.custom.009gz1b" x="5" y="67" width="29" height="18" sizeGrid="5,5,5,5" url="assets/icons/tine.png"/>
			  <Label text="0" x="8" y="68" color="0xffffff" width="25" height="15" size="9" align="center" var="ntxt" name="ntxt"/>
			</View>;
		public function ShopItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}