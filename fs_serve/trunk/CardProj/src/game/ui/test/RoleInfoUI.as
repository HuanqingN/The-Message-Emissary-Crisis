/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoleInfoUI extends Dialog {
		public var f1:Image = null;
		public var f3:Image = null;
		public var f2:Image = null;
		public var closebtn:Button = null;
		public var head:Image = null;
		public var txt1:Label = null;
		public var txt2:Label = null;
		public var txt3:Label = null;
		public var txt4:Label = null;
		public var txt5:Label = null;
		public var txt6:Label = null;
		public var txt7:Label = null;
		public var txt8:Label = null;
		public var txt9:Label = null;
		public var txt10:Label = null;
		public var txt11:Label = null;
		public var txt12:Label = null;
		public var txt13:Label = null;
		protected static var uiXML:XML =
			<Dialog width="680" height="560">
			  <Image skin="png.custom.008js底图" x="0" y="0"/>
			  <Image skin="png.custom.like" x="31" y="31" var="f1" toolTip="正常状态: 此人会受到正常限制" name="f1"/>
			  <Image skin="png.custom.sb" x="139" y="29" var="f3" width="35" height="35" toolTip="讨厌状态: 你为房主时,此人无法进入" name="f3"/>
			  <Image skin="png.custom.normal" x="85" y="31" var="f2" toolTip="喜爱状态: 你为房主时,此人只受注金限制" name="f2"/>
			  <Button skin="png.custom.btn_009gb" x="638" y="22" var="closebtn" name="closebtn" labelBold="false" selected="false"/>
			  <Image skin="png.custom.024jsblank" x="42" y="78" var="head" name="head" mouseEnabled="false"/>
			  <Image skin="png.custom.024jskk" x="41" y="78" mouseEnabled="false"/>
			  <Label x="46" y="276" color="0xe6e6" stroke="0x0" size="14" width="130" height="22" align="center" var="txt1" name="txt1" text="提符最最最最二"/>
			  <Label x="288" y="84" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt2" name="txt2" mouseChildren="true" toolTip="1111" text="100" font="黑体"/>
			  <Label text="V10" x="287" y="120" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt3" name="txt3" font="黑体"/>
			  <Label x="287" y="156" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt4" name="txt4" text="100.00%" font="黑体"/>
			  <Label x="287" y="192" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt5" name="txt55" text="19999999" font="黑体"/>
			  <Label x="287" y="228" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt6" name="txt6" text="123456" font="黑体"/>
			  <Label x="529" y="84" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt7" name="txt7" text="12" font="黑体"/>
			  <Label x="529" y="120" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt8" name="txt8" text="123" font="黑体"/>
			  <Label x="529" y="156" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt9" name="txt9" text="456" font="黑体"/>
			  <Label x="529" y="192" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt10" name="txt10" text="789" font="黑体"/>
			  <Label x="529" y="228" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt11" name="txt11" text="222" font="黑体"/>
			  <Label x="529" y="264" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt12" name="txt12" text="333" font="黑体"/>
			  <Label x="287" y="264" color="0x82b0b4" stroke="0x0" size="14" width="100" height="20" align="center" var="txt13" name="txt13" text="皇家密探" font="黑体"/>
			</Dialog>;
		public function RoleInfoUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}