/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class NoticUI extends Dialog {
		public var text1:TextArea = null;
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.公告底色" x="0" y="0" width="500" height="570" smoothing="true" sizeGrid="213,100,215,120"/>
			  <TextArea text="版本更新公告（version=0.129）&#xD;请大家清除缓存后重新打开网页（不要直接刷新）&#xD;***更新内容：&#xD;1.修复了公开角色显示“隐藏2”的bug。&#xD;2.修复了【亮剑】、【迷雾重重】技能数字指示不消失的bug。&#xD;3.再次修复了【倍受宠爱】、【激素】无法抽牌的bug。&#xD;4.修复了一个全部退出战斗时，服务端报错（并可能引发服务器主机CPU占用率不断提高）的问题。版本更新公告（version=0.129）请大家清除缓存后重新打开网页（不要直接刷新）***更新内容：1.修复了公开角色显示“隐藏2”的bug。2.修复了【亮剑】、【迷雾重重】技能数字指示不消失的bug。3.再次修复了【倍受宠爱】、【激素】无法抽牌的bug。4.修复了一个全部退出战斗时，服务端报错（并可能引发服务器主机CPU占用率不断提高）的问题。" x="34" y="74" width="437" height="452" size="18" color="0xffffff" selectable="true" editable="false" vScrollBarSkin="png.comp.vscroll1" margin="3,0,10,3" var="text1" name="text1" leading="10" underline="false"/>
			  <Button skin="png.custom.btn_009gb" x="467" y="16" var="closebtn" name="closebtn"/>
			</Dialog>;
		public function NoticUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}