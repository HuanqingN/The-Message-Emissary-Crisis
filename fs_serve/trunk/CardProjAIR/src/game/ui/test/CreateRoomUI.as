/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CreateRoomUI extends Dialog {
		public var lb1:Label = null;
		public var lb2:Label = null;
		public var lb3:Label = null;
		public var closebtn:Button = null;
		public var hs2:HSlider = null;
		public var ti1:TextInput = null;
		public var hs1:HSlider = null;
		public var hs3:HSlider = null;
		public var cb1:CheckBox = null;
		public var cb2:CheckBox = null;
		public var bt1:Button = null;
		protected static var uiXML:XML =
			<Dialog width="495">
			  <Image skin="png.custom.001创建房间底图" x="0" y="0"/>
			  <Label text="10000" x="404" y="88" width="59" height="23" size="12" align="left" bold="true" color="0x82b0b4" var="lb1" name="lb1" font="黑体"/>
			  <Label text="≥100级" x="388" y="124" width="60" height="18" size="12" align="left" bold="true" color="0x82b0b4" var="lb2" name="lb2"/>
			  <Label text="≥0%" x="388" y="162" width="78" height="18" size="12" align="left" bold="true" color="0x82b0b4" var="lb3" name="lb3" stroke="0*0"/>
			  <Button skin="png.custom.btn_009gb" x="455" y="20" var="closebtn" name="closebtn"/>
			  <HSlider skin="png.custom.hslider_cc" x="131" y="132" showLabel="false" tick="1" var="hs2" name="hs2" min="1" max="100"/>
			  <TextInput x="136" y="214" width="100" height="20" color="0xa4dfda" stroke="0x0" size="14" align="left" var="ti1" name="ti1" text="123456789" letterSpacing="1" indent="2" font="黑体"/>
			  <HSlider skin="png.custom.hslider_cc" x="131" y="94" min="100" max="10000" showLabel="false" tick="100" var="hs1" name="hs1"/>
			  <HSlider skin="png.custom.hslider_cc" x="131" y="170" var="hs3" name="hs3" tick="1" showLabel="false" min="0" max="100"/>
			  <CheckBox skin="png.custom.checkbox" x="285" y="206" var="cb1" name="cb1" toolTip="如果勾此选项，经验和金币奖励将被取消" selected="false" disabled="true"/>
			  <CheckBox skin="png.custom.checkbox" x="285" y="229" var="cb2" name="cb2" selected="true"/>
			  <Button label="创建房间" skin="png.custom.btn_3a" x="190" y="326" var="bt1" name="bt1" labelColors="0x9b9b9b,0xffffff,0x9b9b9b" labelBold="true" labelStroke="0*0" labelSize="14" letterSpacing="1" labelFont="黑体"/>
			</Dialog>;
		public function CreateRoomUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}