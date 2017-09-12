/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class NoticUI extends Dialog {
		public var text1:TextArea = null;
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.公告底色" x="0" y="0" width="500" height="570" smoothing="true" sizeGrid="213,100,215,120"/>
			  <TextArea text="版本更新公告（Version=0.147）\n***更新内容：\n一、角色调整\n1.猎鹰\n- 【猎杀】由选择一张黑色手牌放置调整将展示的牌库顶的牌放置。\n- 酱油任务调整为“一位其他玩家因你的情报死亡时，其情报数为全场最多或之一”。\n2.武僧\n- 两面的酱油任务进行了交换。同时，与【疾风骤雨】相关的任务要求的次数增加了一次。\n二、bug修复\n1.角色说明\n- 修复了鬼魅【易容】、武僧翻转角色牌获得新技能后角色说明弹窗还是显示原技能的bug。\n - 优化了对局中的角色说明弹窗，现在技能顺序总是按原本的易读顺序显示了。\n 2.老枪\n- 修复了【合谋】不放置黑牌也能成功（于后台）盖伏目标角色的bug。\n - 修复了【合谋】对处于公开状态的隐藏角色使用时，老枪的盖伏动画总是播放两次的bug。\n 3.老兵、出云龙\n- 修复了机密任务结算与说明不一致的bug。\n 4.暗流\n- 修复了发动【涌动】不弃牌就拿不到牌的bug（这两张牌是你应得的）。\n 5.鬼魅\n- 没有手牌将不再能发动【蛊惑】。\n - 【蛊惑】的目标如果没有抽牌，将随机交给他一张。\n - 【蛊惑】不再强制放置黑情报。\n 6.黑玫瑰\n- 【血染玫瑰】的发动不再要求有黑色手牌。\n - 【血染玫瑰】不再强制放置黑情报。\n 7.黄雀\n- 修复了【黄雀在后】不能指定自己为目标的bug。\n - 现在，【诱螳捕蝉】会使后续结算的【转移】失效了（处于锁定状态的玩家不能使用转移）。\n 8.闪灵\n- 修正了判断酱油任务是否完成的时机滞后的bug（现在在触发）。\n 9.厄运小姐\n- 修复了厄运小姐传出的情报致胜时还会触发【一箭双雕】并可能改变游戏结果的bug。" x="34" y="74" width="437" height="452" size="18" color="0xffffff" selectable="true" editable="false" vScrollBarSkin="png.comp.vscroll1" margin="3,0,10,3" var="text1" name="text1" leading="10" underline="false"/>
			  <Button skin="png.custom.btn_009gb" x="467" y="16" var="closebtn" name="closebtn"/>
			</Dialog>;
		public function NoticUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}