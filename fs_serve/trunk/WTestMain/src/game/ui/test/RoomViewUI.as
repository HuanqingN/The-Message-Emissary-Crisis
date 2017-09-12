/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.RoomListItemUI;
	public class RoomViewUI extends View {
		public var msgarea:TextArea = null;
		public var msginput:TextInput = null;
		public var send:Button = null;
		public var box1:Box = null;
		public var rlist:List = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		public var bt3:Button = null;
		public var bt4:Button = null;
		public var devbtn:Image = null;
		public var closebtn:Image = null;
		public var title1:Image = null;
		public var dev:Box = null;
		protected static var uiXML:XML =
			<View width="1000" height="700">
			  <TextArea x="1136" y="20" width="240" height="571" size="14" var="msgarea" name="msgarea" vScrollBarSkin="png.comp.vscroll1" color="0xa4dfda" stroke="0x0" margin="3,3,20,3" isHtml="true" editable="false" selectable="false" font="黑体" align="left"/>
			  <TextInput x="1078" y="729" width="188" height="58" size="14" align="left" var="msginput" name="msginput" color="0xa4dfda" maxChars="50" stroke="0x0" multiline="true" wordWrap="true" font="黑体"/>
			  <Button label="发送" skin="png.custom.btn_4" x="1230" y="625" labelStroke="0x0" labelColors="0x82b0b4,0xffffff,0x82b0b4" var="send" name="send" letterSpacing="1" labelSize="12" labelBold="true" labelFont="黑体"/>
			  <Image skin="jpg.rpg.background1" x="0" y="0"/>
			  <Box x="100" y="106" var="box1" name="box1" width="895" height="577">
			    <List x="0" var="rlist" name="rlist" repeatY="3" repeatX="1" y="29" width="872" height="469" spaceY="-2">
			      <RoomListItem name="render" y="1" runtime="game.ui.test.RoomListItemUI"/>
			      <VScrollBar skin="png.comp.vscroll1" x="782" width="16" height="484" y="-9" name="scrollBar"/>
			    </List>
			    <Button label="创建房间" skin="png.rpg.btn_greenbutton" x="0" y="518" stateNum="1" labelColors="0，0，0" labelSize="20" labelBold="true" labelStroke="0xcccccc" labelFont="Microsoft YaHei Bold" var="bt1" name="bt1" width="162" height="60"/>
			    <Button label="显示等待" skin="png.rpg.btn_greenbutton" x="186" y="518" stateNum="1" labelColors="0，0，0" labelSize="20" labelBold="true" labelStroke="0xcccccc" labelFont="Microsoft YaHei Bold" var="bt2" name="bt2" width="162" height="60"/>
			    <Button label="加入房间" skin="png.rpg.btn_greenbutton" x="375" y="518" stateNum="1" labelColors="0，0，0" labelSize="20" labelBold="true" labelStroke="0xcccccc" labelFont="Microsoft YaHei Bold" width="162" height="60" var="bt3" name="bt3"/>
			    <Button label="快速加入" skin="png.rpg.btn_redbutton" x="638" y="518" stateNum="1" width="162" height="60" labelColors="0，0，0" labelFont="Microsoft YaHei Bold" labelBold="true" labelStroke="0xcccccc" labelSize="20" var="bt4" name="bt4"/>
			  </Box>
			  <Image skin="png.rpg.addicon" x="18" y="23" var="devbtn" name="devbtn"/>
			  <Image skin="png.rpg.closebtn" x="940" y="13" var="closebtn" name="closebtn"/>
			  <Image skin="jpg.rpg.title1" x="99" y="100" var="title1" name="title1"/>
			  <Box x="74" y="57" var="dev" name="dev" width="877" height="576" alpha="0">
			    <Image skin="png.rpg.background2" x="0" y="0" width="877" height="603"/>
			    <Image skin="png.rpg.frame0" x="78" y="128"/>
			    <Image skin="png.rpg.frame0" x="78" y="333"/>
			    <Image skin="png.rpg.frame2" x="205" y="128"/>
			    <Image skin="png.rpg.frame2" x="205" y="332"/>
			    <Image skin="png.rpg.frame1" x="329" y="128"/>
			    <Image skin="png.rpg.frame1" x="453" y="128"/>
			    <Image skin="png.rpg.frame1" x="577" y="128"/>
			    <Image skin="png.rpg.frame1" x="701" y="128"/>
			    <Image skin="png.rpg.frame1" x="329" y="332"/>
			    <Image skin="png.rpg.frame1" x="453" y="332"/>
			    <Image skin="png.rpg.frame1" x="577" y="332"/>
			    <Image skin="png.rpg.frame1" x="701" y="332"/>
			  </Box>
			</View>;
		public function RoomViewUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.RoomListItemUI"] = RoomListItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}