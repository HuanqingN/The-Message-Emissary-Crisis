/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoomListItemUI extends View {
		public var lock:Image = null;
		protected static var uiXML:XML =
			<View width="776" height="118">
			  <Image skin="png.rpg.item1" x="0" y="0"/>
			  <Image skin="png.custom.s_1" x="84" y="46" name="lock" var="lock"/>
			  <Label text="9999&#xD;" x="17" y="37" width="64" height="45" align="center" bold="true" size="30" font="Microsoft YaHei Bold" name="rid"/>
			  <Label text="暗杀者的黑名单" x="98" y="37" width="251" height="45" align="center" bold="true" size="30" name="rname"/>
			  <Label text="准备中" x="351" y="37" width="94" height="45" align="center" color="0x38b338" bold="true" size="30" stroke="0x0" font="Microsoft YaHei Bold" name="status"/>
			  <Label text="200G/Lv.1/50%" x="440" y="38" width="237" height="45" align="center" bold="true" size="30" font="Microsoft YaHei Bold" name="limit"/>
			  <Label text="8/3" x="672" y="38" width="84" height="45" align="center" bold="true" size="30" font="Microsoft YaHei Bold" name="rcount"/>
			</View>;
		public function RoomListItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}