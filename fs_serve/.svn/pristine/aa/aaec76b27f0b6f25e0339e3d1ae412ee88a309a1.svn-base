package handlers
{
	import core.mng.Evt;

	public class BattleHandler extends HandlerBase
	{
		public static const onChooseRole:String="ONCHOOSEROLE";     								//0  选角色
		public static const onRoleChoosed:String="ONROLECHOOSED";							//1  选角色完毕
		public static const onDealingAll:String="ONDEALINGALL";										//2  全体发牌
		public static const onDealingSingle:String="ONDEALINGSINGLE";							//3  单个发牌
		public static const onShowCanUseCard:String="ONSHOWCANUSECARD";			//4  显示能用的卡
		public static const onUseCard:String="ONUSECARD";													//5  使用卡
		public static const onCardLaunch:String="ONCARDLAUNCH";									//6  卡牌发动
		public static const onAddCard:String="ONADDCARD";												//7  抽卡
		public static var onDisCard:String="ONDISCARD";														//8  弃卡
		public static var onProbeChoose:String="ONPROBECHOOSE";								//9  试探选择
		public static var onShowInfo:String="ONSHOWINFO";												//10  显示信息
		public static var onDisCardSelect:String="ONDISCARDSELECT";									//11  选择弃卡		
		public static var onTrueFlaseDeal:String="ONTRUEFLASEDEAL";									//12  真伪发牌		
		public static var onWaitForSend:String="ONWAITFORSEND";									//13 等待选择传情报
		public static var onSendingInfo:String="ONSENDINGINFO";									//14 传情报
		public static var onRecieveInfo:String="ONRECIEVEINFO";									//15 接收情报
		public static var onClearAllStatus:String="ONCLEARALLSTATUS";									//16清除所有操作 
		public static var onWaitForRecieve:String="ONWAITFORRECIEVE";									//17等待玩家选择接收情报 
		public static var onManifestoShared:String="ONMANIFESTOSHARED";									//18等待玩家宣言公开破译 
		public static var onSharedCard:String="ONSHAREDCARD";									//19公开传递中的卡
		public static var onQuickChat:String="ONQUICKCHAT";									//20快捷聊天
		public static var onChangeStep:String="ONCHANGESTEP";									//21切换阶段
		public static var onChaneTurn:String="ONCHANETURN";									//22切换玩家回合
		public static var onDead:String="ONDEAD";									//23玩家死亡或失败
		public static var onVictory:String="ONVICTORY";									//24玩家胜利
		public static var onSkillUse:String="ONSKILLUSE";									//25技能发动
		public static var onUserExit:String="ONUSEREXIT";									//26用户离开 
		public static var onCardMoveTo:String="ONCARDMOVETO";									//27 卡牌移动type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		public static var onCheckNetState:String="ONCHECKNETSTATE";									//28 检查网速 
		public static var onLaunchSingleSkill:String="ONLAUNCHSINGLESKILL";									//29 发动技能
		public static var onShowIden:String="ONSHOWIDEN";									//30 显示身份
		public static var onChatMsg:String="ONCHATMSG";									//31 聊天
		public static var onRemoveUsedCard:String="ONREMOVEUSEDCARD";									//32 移除发动完的卡
		public static var onPoison:String="ONPOISON";									//33 中毒
		public static var onGetFoldCards:String="ONGETFOLDCARDS";									//34 获得弃牌堆
		override protected function initFunArr():void
		{
			funcArr=[
				ChooseRole,
				RoleChoosed,
				DealingAll,
				DealingSingle,
				ShowCanUseCard,
				UseCard,
				CardLaunch,
				AddCard,
				DisCard,
				ProbeChoose,
				ShowInfo,
				DisCardSelect,
				TrueFlaseDeal,
				WaitForSend,
				SendingInfo,
				RecieveInfo,
				ClearAllStatus,
				WaitForRecieve,
				ManifestoShared,
				SharedCard,
				QuickChat,
				ChangeStep,
				ChaneTurn,
				Dead,
				Victory,
				SkillUse,
				UserExit,
				CardMoveTo,
				CheckNetState,
				LaunchSingleSkill,
				ShowIden,
				ChatMsg,
				RemoveUsedCard,
				Poison,
				GetFoldCards
			];
		}
		public function GetFoldCards(obj:Object):void{
			Evt.dipatch(onGetFoldCards,obj);
		}
		public function Poison(obj:Object):void{
			Evt.dipatch(onPoison,obj);
		}
		public function RemoveUsedCard(obj:Object):void{
			Evt.dipatch(onRemoveUsedCard,obj);
		}
		public function ChatMsg(obj:Object):void{
			Evt.dipatch(onChatMsg,obj);
		}
		public function ShowIden(obj:Object):void{
			Evt.dipatch(onShowIden,obj);
		}
		public function LaunchSingleSkill(obj:Object):void{
			Evt.dipatch(onLaunchSingleSkill,obj);
		}
		public function CheckNetState(obj:Object):void{
			Evt.dipatch(onCheckNetState,obj);
		}
		public function CardMoveTo(obj:Object):void{
			Evt.dipatch(onCardMoveTo,obj);
		}
		public function UserExit(obj:Object):void{
			Evt.dipatch(onUserExit,obj);
		}
		public function SkillUse(obj:Object):void{
			Evt.dipatch(onSkillUse,obj);
		}
		public function Victory(obj:Object):void{
			Evt.dipatch(onVictory,obj);
		}
		public function Dead(obj:Object):void{
			Evt.dipatch(onDead,obj);
		}
		public function ChaneTurn(obj:Object):void{
			Evt.dipatch(onChaneTurn,obj);
		}
		public function ChangeStep(obj:Object):void{
			Evt.dipatch(onChangeStep,obj);
		}
		public function QuickChat(obj:Object):void{
			Evt.dipatch(onQuickChat,obj);
		}
		public function SharedCard(obj:Object):void{
			Evt.dipatch(onSharedCard,obj);
		}
		public function ManifestoShared(obj:Object):void{
			Evt.dipatch(onManifestoShared,obj);
		}
		public function WaitForRecieve(obj:Object):void{
			Evt.dipatch(onWaitForRecieve,obj);
		}
		public function ClearAllStatus(obj:Object):void{
			Evt.dipatch(onClearAllStatus,obj);
		}
		public function RecieveInfo(obj:Object):void{
			Evt.dipatch(onRecieveInfo,obj);
		}
		public function SendingInfo(obj:Object):void{
			Evt.dipatch(onSendingInfo,obj);
		}
		public function WaitForSend(obj:Object):void{
			Evt.dipatch(onWaitForSend,obj);
		}
		public function TrueFlaseDeal(obj:Object):void{
			Evt.dipatch(onTrueFlaseDeal,obj);
		}
		public function DisCardSelect(obj:Object):void{
			Evt.dipatch(onDisCardSelect,obj);
		}
		public function ShowInfo(obj:Object):void{
			Evt.dipatch(onShowInfo,obj);
		}
		public function ProbeChoose(obj:Object):void{
			Evt.dipatch(onProbeChoose,obj);
		}
		public function DisCard(obj:Object):void{
			Evt.dipatch(onDisCard,obj);
		}
		public function AddCard(obj:Object):void{
			Evt.dipatch(onAddCard,obj);
		}
		public function CardLaunch(obj:Object):void{
			Evt.dipatch(onCardLaunch,obj);
		}
		public function UseCard(obj:Object):void{
			Evt.dipatch(onUseCard,obj);
		}
		public function ChooseRole(obj:Object):void{
			Evt.dipatch(onChooseRole,obj);
		}
		public function RoleChoosed(obj:Object):void{
			Evt.dipatch(onRoleChoosed,obj);
		}
		public function DealingAll(obj:Object):void{
			Evt.dipatch(onDealingAll,obj);
		}
		public function DealingSingle(obj:Object):void{
			Evt.dipatch(onDealingSingle,obj);
		}
		public function ShowCanUseCard(obj:Object):void{
			Evt.dipatch(onShowCanUseCard,obj);
		}
	}
}