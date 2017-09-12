/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class ReportUI extends View {
		public var ta:TextArea = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.011xxk" x="0" y="0" width="681" height="496"/>
			  <TextArea x="37" y="38" width="629" height="452" vScrollBarSkin="png.comp.vscroll1" size="17" isHtml="true" margin="30,10,30,10" color="0xffffff" var="ta" name="ta"/>
			</View>;
		public function ReportUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}