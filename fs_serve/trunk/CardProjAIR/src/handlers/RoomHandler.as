package handlers
{
	import core.mng.Evt;

	public class RoomHandler extends HandlerBase
	{
		public static const onRoomUpdate:String="ONROOMUPDATE";   //0 创建房间返回
		public static const onHallUpdate:String="ONHALLUPDATE";												//1 大厅数据更新 1加2减3更新
		public static const onJoinRoomRetrive:String="ONJOINROOMRETRIVE";						//2 加入房间
		public static const onDoReadyRetrive:String="ONDOREADYRETRIVE";							//3准备
		public static const onChangeBan:String="onChangeBan";				//4改变禁止状态
		public static const onStartGame:String="ONSTARTGAME";											//5开始游戏
		public static const onGetRoomList:String="ONGETROOMLIST";									//6获得房间列表
		public static const onEndBattle:String="ONENDBATTLE";								//7 结束游戏
		public static const onRank:String="ONRANK";								//8 排行
		public static const onGetUserInfo:String="ONGETUSERINFO";								//9 用户信息
		public static const onSystemInfo:String="ONSYSTEMINFO";								//10 系统消息
		public static const onErrorInfo:String="	";								//11 错误消息
		public static var onChangeFavor:String="ONCHANGEFAVOR";								//12 改变喜欢状态
		public static var onBagUpdata:String="ONBAGUPDATA";								//13 更新背包
		public static var onMoneyUpdata:String="ONMONEYUPDATA";								//14 更新金钱
		public static var onContinueGame:String="ONCONTINUEGAME";								//15 断线重连数据
		public function RoomHandler()
		{
		}
		override protected function initFunArr():void
		{
			funcArr=[
				RoomUpdate,
				HallUpdate,
				onJoinRoom,
				onRoomReady,
				ChangeBan,
				startGame,
				GetRoomList,
				EndBattle,
				Rank,
				GetUserInfo,
				SystemInfo,
				ErrorInfo,
				ChangeFavor,
				BagUpdata,
				MoneyUpdata,
				ContinueGame
			];
		}
		public function ContinueGame(obj:Object):void{
			Evt.dipatch(onContinueGame,obj);
		}
		public function MoneyUpdata(obj:Object):void{
			Evt.dipatch(onMoneyUpdata,obj);
		}
		public function BagUpdata(obj:Object):void{
			Evt.dipatch(onBagUpdata,obj);
		}
		public function ChangeFavor(obj:Object):void{
			Evt.dipatch(onChangeFavor,obj);
		}
		public function ErrorInfo(obj:Object):void{
			Evt.dipatch(onErrorInfo,obj);
		}
		public function SystemInfo(obj:Object):void{
			Evt.dipatch(onSystemInfo,obj);
		}
		public function GetUserInfo(obj:Object):void{
			Evt.dipatch(onGetUserInfo,obj);
		}
		public function Rank(obj:Object):void{
			Evt.dipatch(onRank,obj);
		}
		public function EndBattle(obj:Object):void{
			Evt.dipatch(onEndBattle,obj);
		}
		public function RoomUpdate(obj:Object):void{
			Evt.dipatch(onRoomUpdate,obj);
		}
		public function HallUpdate(obj:Object):void{
			Evt.dipatch(onHallUpdate,obj);
		}
		public function onJoinRoom(obj:Object):void{
			Evt.dipatch(onJoinRoomRetrive,obj);
		}
		public function onRoomReady(obj:Object):void{
			Evt.dipatch(onDoReadyRetrive,obj);
		}
		public function ChangeBan(obj:Object):void{
			Evt.dipatch(onChangeBan,obj);
		}
		public function startGame(obj:Object):void{
			Evt.dipatch(onStartGame,obj);
		}
		public function GetRoomList(obj:Object):void{
			Evt.dipatch(onGetRoomList,obj);
		}
	}
}