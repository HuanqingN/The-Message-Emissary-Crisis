/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.ChatPopUI;
	public class RoleAreaUI extends View {
		public var back:Image = null;
		public var state:Label = null;
		public var rname:Label = null;
		public var pg:ProgressBar = null;
		public var htxt:Label = null;
		public var pname:Label = null;
		public var g2:Button = null;
		public var g3:Button = null;
		public var g4:Button = null;
		public var g5:Button = null;
		public var msgpop:ChatPopUI = null;
		public var g8:Button = null;
		public var g6:Button = null;
		public var g7:Button = null;
		public var rcount:Button = null;
		public var bcount:Button = null;
		public var gcount:Button = null;
		public var hcount:Button = null;
		public var g1:Button = null;
		public var b1:Clip = null;
		public var b2:Clip = null;
		public var b3:Clip = null;
		public var b4:Clip = null;
		protected static var uiXML:XML =
			<View width="140" height="196">
			  <Image x="0" y="0" width="140" height="196" var="back" name="back"/>
			  <Image skin="png.custom.021jusekuang" x="0" y="0"/>
			  <Label x="80" y="91" var="state" name="state" align="center" width="53" height="29" size="20" color="0xffff00" stroke="0" font="Microsoft YaHei Bold" embedFonts="true" text=""/>
			  <Label text="label" x="19" y="175" width="100" height="18" color="0xcc9933" stroke="0x0" var="rname" name="rname" align="center"/>
			  <ProgressBar skin="png.comp.progress" x="4" y="126" width="132" height="5" var="pg" name="pg" value="0"/>
			  <Label text="隐藏2" x="84" y="3" width="51" height="23" var="htxt" name="htxt" font="20" align="center" color="0xffffff" stroke="0x0"/>
			  <Label x="4" y="6" width="27" height="131" align="center" multiline="true" wordWrap="true" size="17" color="0xff33" stroke="0" selectable="false" mouseEnabled="false" var="pname" font="Microsoft YaHei Bold" embedFonts="true"/>
			  <Button skin="png.custom.btn_identity_junqing" x="94" y="112" var="g2" name="g2" visible="false" width="20" height="20"/>
			  <Button skin="png.custom.btn_identity_qianfu" x="94" y="92" name="g3" var="g3" visible="false"/>
			  <Button skin="png.custom.btn_identity_jiangyou" x="94" y="72" name="g4" var="g4" visible="false"/>
			  <Button skin="png.custom.btn_identity_unknown" x="104" y="51" name="g5" var="g5" visible="false"/>
			  <ChatPop x="-2" y="1" visible="false" var="msgpop" name="msgpop" runtime="game.ui.test.ChatPopUI"/>
			  <Button label="label" skin="png.custom.btn_identity_feijiangyou" x="114" y="72" var="g8" name="g8" visible="false"/>
			  <Button label="label" skin="png.custom.btn_identity_feijunqing" x="114" y="112" var="g6" name="g6" visible="false"/>
			  <Button label="label" skin="png.custom.btn_identity_feiqianfu" x="114" y="92" var="g7" name="g7" visible="false"/>
			  <Button label="0" skin="png.custom.btn_027dg2" x="33" y="134" labelColors="0xdddddd,0xffffff,0xdddddd" labelSize="18" var="rcount" name="rcount"/>
			  <Button label="0" skin="png.custom.btn_028hj2" x="60" y="134" labelColors="0xdddddd,0xffffff,0xdddddd" labelSize="18" var="bcount" name="bcount"/>
			  <Button label="0" skin="png.custom.btn_029fkj3" x="88" y="134" labelColors="0xdddddd,0xffffff,0xdddddd" labelSize="18" var="gcount" name="gcount"/>
			  <Button label="0" skin="png.custom.btn_026pp" x="4" y="134" var="hcount" labelSize="20" labelColors="0xdddddd,0xffffff,0xdddddd"/>
			  <Button skin="png.custom.btn_030wh4" x="117" y="135" var="g1" name="g1"/>
			  <Clip skin="png.custom.clip_blood" x="34" y="161" clipX="3" var="b1" name="b1"/>
			  <Clip skin="png.custom.clip_blood" x="59" y="161" clipX="3" var="b2" name="b2"/>
			  <Clip skin="png.custom.clip_blood" x="84" y="161" clipX="3" var="b3" name="b3"/>
			  <Clip skin="png.custom.clip_blood" x="109" y="161" clipX="3" var="b4" name="b4"/>
			</View>;
		public function RoleAreaUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.ChatPopUI"] = ChatPopUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}