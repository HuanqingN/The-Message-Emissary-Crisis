/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.CardViewUI;
	public class ProbeViewUI extends Dialog {
		public var img:CardViewUI = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		protected static var uiXML:XML =
			<Dialog width="220" height="400">
			  <Image skin="jpg.custom.b1" x="0" y="0" width="220" height="400" sizeGrid="3,3,3,3"/>
			  <CardView x="10" y="9" width="200" height="279" var="img" name="img" runtime="game.ui.test.CardViewUI"/>
			  <Button label="军情+1" skin="png.comp.button" x="10" y="302" width="202" height="32" labelSize="20" var="bt1" name="bt1"/>
			  <Button label="我是一个好人" skin="png.comp.button" x="10" y="352" width="202" height="32" labelSize="20" var="bt2" name="bt2"/>
			</Dialog>;
		public function ProbeViewUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.CardViewUI"] = CardViewUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}