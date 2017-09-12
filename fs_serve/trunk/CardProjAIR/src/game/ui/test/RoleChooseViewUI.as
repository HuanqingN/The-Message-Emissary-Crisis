/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoleChooseViewUI extends View {
		public var btn:Button = null;
		public var daojishi:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.custom.023jsxq" x="0" y="48"/>
			  <Button label="确认选择" skin="png.custom.btn_3a" x="200" y="358" var="btn" name="btn" labelBold="true" labelColors="0x9b9b9b,0xffffff,0x9b9b9b" labelSize="14" letterSpacing="1" labelStroke="0x0" disabled="true" buttonMode="true" labelFont="黑体"/>
			  <Label text="00:29" x="215" y="16" align="center" font="Impact" size="30" color="0x4dfe00" bold="false" var="daojishi" name="daojishi" stroke="0*0" letterSpacing="3"/>
			</View>;
		public function RoleChooseViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}