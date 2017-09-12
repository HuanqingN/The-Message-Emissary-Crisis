/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoleChooseItemUI extends View {
		public var card1:Image = null;
		public var pname1:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.024jsblank" x="0" y="0" var="card1" name="card1"/>
			  <Image skin="png.custom.024jskk" x="0" y="0" mouseChildren="false" disabled="false" mouseEnabled="false"/>
			  <Label x="4" y="10" width="26" height="140" align="center" multiline="true" wordWrap="true" size="18" color="0x4efe00" stroke="0" selectable="false" mouseEnabled="false" var="pname1" name="pname1" text="皇家密探" bold="true" font="方正粗倩简体"/>
			</View>;
		public function RoleChooseItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}