/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoomUI extends View {
		public var entertxt:Label = null;
		public var enternum:Label = null;
		public var ante:Label = null;
		public var iden:Box = null;
		public var b5:Button = null;
		public var b0:Button = null;
		public var b6:Button = null;
		public var b1:Button = null;
		public var b2:Button = null;
		public var b4:Button = null;
		public var b3:Button = null;
		public var b7:Button = null;
		public var exitbtn:Button = null;
		public var readybtn:Button = null;
		public var chooseRoleBtn:Button = null;
		protected static var uiXML:XML =
			<View width="877" height="603">
			  <Label text="游戏即将开始.." x="68" y="505" width="187" height="29" color="0x82b0b4" size="18" stroke="0x0" var="entertxt" name="entertxt" visible="false" mouseEnabled="false" font="黑体"/>
			  <Image skin="png.custom.001zytbNew" x="757" y="90"/>
			  <Image skin="png.rpg.background2" x="0" y="0" width="877" height="603"/>
			  <Label text="5" x="190" y="504" width="43" height="34" color="0x82b0b4" size="20" align="center" stroke="0*0" var="enternum" name="enternum" visible="false" mouseEnabled="false" font="黑体"/>
			  <Label text="10000" x="742" y="534" width="92" height="24" color="0xffcb00" size="14" stroke="0x0" var="ante" name="ante" align="center" font="黑体" bold="false"/>
			  <Box x="770" y="130" var="iden" name="iden">
			    <Button label="潜" skin="jpg.custom.btn_red" y="225" var="b5" name="b5" labelColors="0xffffff" labelBold="true" labelSize="13" mouseEnabled="false" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="军" skin="jpg.custom.btn_blue" var="b0" name="b0" labelColors="0xffffff" labelBold="true" labelSize="13" mouseEnabled="false" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="酱" skin="jpg.custom.btn_black" y="270" var="b6" name="b6" labelColors="0xffffff" labelBold="true" mouseEnabled="false" labelSize="13" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="军" skin="jpg.custom.btn_blue" y="45" var="b1" name="b1" labelColors="0xffffff" labelBold="true" labelSize="13" mouseEnabled="false" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="军" skin="jpg.custom.btn_blue" y="90" var="b2" name="b2" labelColors="0xffffff" labelBold="true" labelSize="13" mouseEnabled="false" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="潜" skin="jpg.custom.btn_red" y="180" var="b4" name="b4" labelColors="0xffffff" labelBold="true" labelSize="13" mouseEnabled="false" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="潜" skin="jpg.custom.btn_red" y="135" var="b3" name="b3" labelColors="0xffffff" labelBold="true" labelSize="13" mouseEnabled="false" labelMargin="2,2,2" scale="1.3"/>
			    <Button label="酱" skin="jpg.custom.btn_black" y="315" var="b7" name="b7" labelColors="0xffffff" labelBold="true" mouseEnabled="false" labelSize="13" labelMargin="2,2,2" scale="1.3"/>
			  </Box>
			  <Button label="退出房间" skin="png.rpg.btn_greenbutton" x="495" y="577" stateNum="1" labelColors="0，0，0" labelSize="20" labelBold="true" labelStroke="0xcccccc" labelFont="Microsoft YaHei Bold" width="162" height="60" var="exitbtn" name="exitbtn"/>
			  <Button label="开始对战" skin="png.rpg.btn_redbutton" x="676" y="577" stateNum="1" width="162" height="60" labelColors="0，0，0" labelFont="Microsoft YaHei Bold" labelBold="true" labelStroke="0xcccccc" labelSize="20" var="readybtn" name="readybtn"/>
			  <Button label="选人卡" skin="png.rpg.btn_greenbutton" x="38" y="577" stateNum="1" labelColors="0，0，0" labelSize="20" labelBold="true" labelStroke="0xcccccc" labelFont="Microsoft YaHei Bold" width="162" height="60" var="chooseRoleBtn" name="chooseRoleBtn" letterSpacing="3"/>
			</View>;
		public function RoomUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}