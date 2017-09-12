/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RankUI extends Dialog {
		public var rlist:List = null;
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.012ph" x="0" y="0"/>
			  <List x="42" y="147" width="452" height="398" repeatY="11" spaceY="8" var="rlist" name="rlist">
			    <Box name="render">
			      <Label text="1" y="1" width="57" height="27" size="15" color="0x82b0b4" stroke="0x000000" align="center" name="rank" x="0"/>
			      <Label text="我是一个非常好的人" x="64" width="226" height="27" size="14" color="0x82b0b4" stroke="0x000000" align="center" name="nick" y="0"/>
			      <Label text="100000000" x="293" y="1" width="157" height="27" size="14" color="0x82b0b4" stroke="0x000000" align="center" name="coin"/>
			    </Box>
			  </List>
			  <Button skin="png.custom.btn_009gb" x="498" y="17" var="closebtn" name="closebtn"/>
			  <Button label="杀手" skin="png.custom.btn_middle" x="158" y="67" stateNum="2" width="86" height="30" labelColors="0x6fd0d9,0x000808" labelBold="true"/>
			  <Button label="等级" skin="png.custom.btn_middle" x="90" y="67" stateNum="2" labelColors="0x6fd0d9,0x000808" labelBold="true"/>
			  <Button label="死亡" skin="png.custom.btn_right" x="226" y="67" stateNum="2" labelColors="0x6fd0d9,0x000808" labelBold="true"/>
			  <Button label="积分" skin="png.custom.btn_left" x="29" y="67" stateNum="2" labelBold="true" labelColors="0x6fd0d9,0x000808"/>
			  <Label text="积分" x="338" y="115" width="152" height="18" color="0x82b0b4" stroke="0x0" align="center" size="12" font="黑体"/>
			  <Button label="上一页" skin="png.custom.btn_3a" x="136" y="554" labelColors="0x9c9b9b,0xffffff,0x9c9b9b" labelBold="true" labelSize="12" labelStroke="0x0" letterSpacing="1" labelFont="黑体"/>
			  <Button label="下一页" skin="png.custom.btn_3a" x="287" y="554" labelColors="0x9c9b9b,0xffffff,0x9c9b9b" labelBold="true" labelSize="12" labelStroke="0*0" letterSpacing="1" labelFont="黑体"/>
			</Dialog>;
		public function RankUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}