/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class BattleEndUI extends View {
		public var btn:Button = null;
		protected static var uiXML:XML =
			<View width="1000" height="700">
			  <Image skin="png.custom.017zbds" x="0" y="0"/>
			  <Button label="关闭[15]" skin="png.custom.btn_3a" x="430" y="608" labelColors="0xffffff,0xffffff,0x9c9b9b" labelSize="15" var="btn" name="btn"/>
			</View>;
		public function BattleEndUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}