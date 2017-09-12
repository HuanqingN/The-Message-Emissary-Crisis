/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class TipViewUI extends View {
		public var bg:Image = null;
		public var txt:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="jpg.custom.b1" x="0" y="0" width="251" height="125" sizeGrid="3,3,3,3" var="bg" name="bg"/>
			  <Label text="label" x="3" y="8" width="244" height="103" multiline="true" wordWrap="true" align="left" backgroundColor="0x999999" color="0xcccccc" size="15" var="txt" name="txt" isHtml="true" autoSize="left" stroke="0x0" mouseEnabled="false"/>
			</View>;
		public function TipViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}