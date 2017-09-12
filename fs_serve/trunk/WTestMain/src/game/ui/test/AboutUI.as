/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class AboutUI extends Dialog {
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.notic" x="0" y="0" width="500" height="350" smoothing="true" sizeGrid="213,100,215,120"/>
			  <TextArea text="测试一群:87378663\n测试二群:314904480\n\n制作人员:\n        五毛,提符\n特别鸣谢:\n        M兄,昆虫,五阿哥,多啦,卯灯,流年,一些没留名的声优和图片提供者\n\n         再次感谢广大风声爱好者参与测试,你们的支持就是我们的动力,谢谢大家!" x="35" y="35" width="436" height="503" size="20" color="0xcccccc" selectable="true" editable="false"/>
			  <Button label="X" skin="jpg.custom.btn_black" x="467" y="11" labelColors="0xff0000" labelBold="true" var="closebtn" name="closebtn" width="20" height="20"/>
			  <Label text="关于" x="207" y="-2" width="78" height="26" color="0xffff00" size="19" align="center" bold="true" stroke="0x333333"/>
			</Dialog>;
		public function AboutUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}