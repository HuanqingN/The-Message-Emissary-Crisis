/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.ShopItemUI;
	public class ShopUI extends Dialog {
		public var closebtn:Button = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		public var bt3:Button = null;
		public var bt4:Button = null;
		public var sitem0:ShopItemUI = null;
		public var sitem1:ShopItemUI = null;
		public var sitem2:ShopItemUI = null;
		public var sitem3:ShopItemUI = null;
		public var sitem4:ShopItemUI = null;
		public var sitem5:ShopItemUI = null;
		public var sitem6:ShopItemUI = null;
		public var sitem7:ShopItemUI = null;
		public var cointxt:Label = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.摧毁底色" x="0" y="0" width="621" height="523" sizeGrid="130,100,130,100"/>
			  <Label text="商城" x="249" y="22" width="146" height="39" color="0xffff33" size="30" align="center" letterSpacing="10" stroke="0xcccccc"/>
			  <Button skin="png.custom.btn_009gb" x="590" y="14" var="closebtn" name="closebtn"/>
			  <Button label="道具" skin="png.custom.btn_left" x="30" y="60" selected="true" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt1" name="bt1" stateNum="2" width="80" height="25"/>
			  <Button label="卡片" skin="png.custom.btn_middle" x="91" y="60" selected="false" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt2" name="bt2" stateNum="2" height="25"/>
			  <Button label="金币" skin="png.custom.btn_middle" x="160" y="60" selected="false" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt3" name="bt3" stateNum="2" height="25"/>
			  <Button label="黑晶" skin="png.custom.btn_right" x="228" y="60" selected="false" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt4" name="bt4" stateNum="2" height="25"/>
			  <ShopItem x="77" y="121" var="sitem0" name="sitem0" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="207" y="121" var="sitem1" name="sitem1" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="337" y="121" var="sitem2" name="sitem2" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="467" y="121" var="sitem3" name="sitem3" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="77" y="278" var="sitem4" name="sitem4" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="207" y="278" var="sitem5" name="sitem5" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="337" y="278" var="sitem6" name="sitem6" runtime="game.ui.test.ShopItemUI"/>
			  <ShopItem x="467" y="278" var="sitem7" name="sitem7" runtime="game.ui.test.ShopItemUI"/>
			  <Image skin="png.comp.coin" x="484" y="69" width="10" height="10"/>
			  <Label x="498" y="65" width="74" height="18" color="0xcccc33" var="cointxt" name="cointxt"/>
			</Dialog>;
		public function ShopUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.ShopItemUI"] = ShopItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}