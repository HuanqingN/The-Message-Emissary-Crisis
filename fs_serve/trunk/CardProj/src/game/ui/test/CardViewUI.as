/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CardViewUI extends View {
		public var bg:Image = null;
		protected static var uiXML:XML =
			<View width="85" height="120">
			  <Image x="0" y="0" width="85" height="120" var="bg" name="bg"/>
			</View>;
		public function CardViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}