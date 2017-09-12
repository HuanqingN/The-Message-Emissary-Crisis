/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class ChatPopUI extends View {
		public var bg:Image = null;
		public var txt:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.comp.chatback" x="0" y="0" sizeGrid="5,5,5,25" width="143" height="46" mouseEnabled="false" var="bg" name="bg"/>
			  <Label x="0" y="1" width="143" height="21" color="0x0" stroke="0x996600" size="15" wordWrap="true" backgroundColor="0xffffff" background="false" var="txt" name="txt" align="center" multiline="true" mouseEnabled="false" autoSize="left"/>
			</View>;
		public function ChatPopUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}