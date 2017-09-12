/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CollectionItemUI extends View {
		public var img:Image = null;
		public var kuang:Image = null;
		public var ntxt:Label = null;
		public var hidetxt:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.006wr" x="12" y="15" width="118" height="155" var="img" name="img"/>
			  <Image skin="png.rpg.heroframe" x="0" y="0" var="kuang" name="kuang"/>
			  <Label text="礼服蒙面人" x="21" y="161" width="98" height="25" color="0x33ffff" size="15" align="center" stroke="0x333333" var="ntxt" name="ntxt"/>
			  <Label text="公开" x="83" y="26" width="40" height="21" color="0xff0000" align="center" size="13" bold="true" stroke="0xcccccc" var="hidetxt" name="hidetxt"/>
			</View>;
		public function CollectionItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}