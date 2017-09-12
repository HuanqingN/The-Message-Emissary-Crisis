/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CollectionItemUI extends View {
		public var img:Image = null;
		public var ntxt:Label = null;
		public var hidetxt:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.006wr" x="0" y="0" width="140" height="196" var="img" name="img"/>
			  <Label text="礼服蒙面人" x="8" y="166" width="127" height="26" color="0xffff" size="20" align="center" stroke="0x999999" var="ntxt" name="ntxt"/>
			  <Label text="公开" x="92" y="3" width="45" height="25" color="0xff0000" align="center" size="18" bold="true" stroke="0xcccccc" var="hidetxt" name="hidetxt"/>
			</View>;
		public function CollectionItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}