/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class InfoViewUI extends Dialog {
		public var txt:Label = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Label text="等待玩家弃牌" x="0" y="0" color="0xffffff" align="center" size="30" stroke="0x6699" width="598" height="54" var="txt" name="txt"/>
			</Dialog>;
		public function InfoViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}