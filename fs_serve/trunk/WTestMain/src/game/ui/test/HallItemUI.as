/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class HallItemUI extends View {
		public var bg:Image = null;
		public var front:Image = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.1" x="0" y="0" var="bg" name="bg"/>
			  <Image skin="png.custom.r6" x="0" y="0" var="front"/>
			</View>;
		public function HallItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}