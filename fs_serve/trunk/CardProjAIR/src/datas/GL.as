package datas
{
	import flash.utils.ByteArray;
	
	import utils.HashMap;

	public class GL
	{
		[Embed(source="/assets/xml/cactions.xml",mimeType="application/octet-stream")] 
		private static var cactions:Class;
		[Embed(source="/assets/xml/role.xml",mimeType="application/octet-stream")] 
		private static var rolexml:Class;
		[Embed(source="/assets/xml/position.xml",mimeType="application/octet-stream")] 
		private static var positionxml:Class;
		[Embed(source="/assets/xml/skill.xml",mimeType="application/octet-stream")] 
		private static var skillxml:Class;
		[Embed(source="/assets/xml/task.xml",mimeType="application/octet-stream")] 
		private static var taskxml:Class;
		[Embed(source="/assets/xml/prop.xml",mimeType="application/octet-stream")] 
		private static var propxml:Class;
		public static var currentRoomName:String="";
		public static var name:String;          //用户名
		public static var id:int=-1;					//用户ID
		private static var _layout:HashMap;  //布局表
		public static var battleMaxU:int;     //战场的信息，桌台对象
		public static var tableId:int;					//当前的桌台ID
		private static var _roleData:HashMap;  //角色信息表
		private static var _skillData:HashMap;  //技能信息表
		private static var _taskData:HashMap;  //技能信息表
		private static var _propData:HashMap;  //道具信息表
		public static var iden:int; 						//角色的身份
		private static var _infoPos:HashMap;   //传情报的坐标
		private static var _cdata:HashMap; //功能牌数据
		public static var nick:String;
		public static var roomId:int;
		public static var coin:Number=0;
		public static var rankdata:Array;
		public static var exp:Number=0;
		public static var favor:String;
		public static var hate:String;
		public static var bag:HashMap;  //背包

		public static function get propData():HashMap
		{
			if(!_propData){
				var hash:HashMap=new HashMap();
				var byteDataXml:ByteArray = new propxml();  
				var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
				var xl:XMLList=xml.prop;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					hash.put(int(xl[i].@id),{id:int(xl[i].@id),n:String(xl[i].@n),tag:int(xl[i].@tag),t:int(xl[i].@t),cv:int(xl[i].@cv),ct:int(xl[i].@ct),desc:String(xl[i].@desc)});
				}
				_propData=hash;
			}
			return _propData;
		}

		public static function set propData(value:HashMap):void
		{
			_propData = value;
		}

		public static function get taskData():HashMap
		{
			if(!_taskData){
				var hash:HashMap=new HashMap();
				var byteDataXml:ByteArray = new taskxml();  
				var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
				var xl:XMLList=xml.tas;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					hash.put(int(xl[i].@id),{n:String(xl[i].@n)});
				}
				_taskData=hash;
			}
			return _taskData;
		}

		public static function set taskData(value:HashMap):void
		{
			_taskData = value;
		}

		public static function get skillData():HashMap
		{
			if(!_skillData){
				var hash:HashMap=new HashMap();
				var byteDataXml:ByteArray = new skillxml();  
				var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
				var xl:XMLList=xml.ski;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					hash.put(int(xl[i].@id),{n:String(xl[i].@n),co:int(xl[i].@co),desc:String(xl[i].@desc)});
				}
				_skillData=hash;
			}
			return _skillData;
		}

		public static function set skillData(value:HashMap):void
		{
			_skillData = value;
		}

		public static function get infoPos():HashMap
		{
			if(!_infoPos){
				var temp:HashMap=GL.layout;
			}
			return _infoPos;
		}

		public static function get layout():HashMap
		{
			if(!_layout){
				var hash:HashMap=new HashMap();
				var byteDataXml:ByteArray = new positionxml();  
				var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
				var xl:XMLList=xml.pos;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					var xc:XMLList=xl[i].children();
					var arr:Array=[];
					for (var j:int = 0; j < xc.length(); j++) 
					{
						arr.push({x:int(xc[j].@x),y:int(xc[j].@y)});
					}
					hash.put(int(xl[i].@c),arr);
				}
				_layout=hash;
				
				var hash1:HashMap=new HashMap();
				xl=xml.cpos;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					var xc:XMLList=xl[i].children();
					var arr:Array=[];
					for (var j:int = 0; j < xc.length(); j++) 
					{
						arr.push({x:int(xc[j].@x),y:int(xc[j].@y),r:int(xc[j].@r)});
					}
					hash1.put(int(xl[i].@c),arr);
				}
				_infoPos=hash1;
			}
			return _layout;
		}

		public static function get roleData():HashMap
		{
			if(!_roleData){
				var hash:HashMap=new HashMap();
				var byteDataXml:ByteArray = new rolexml();  
				var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
				var xl:XMLList=xml.role;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					hash.put(int(xl[i].@id),{id:int(xl[i].@id),n:String(xl[i].@n),h:int(xl[i].@h),s1:int(xl[i].@s1),s2:int(xl[i].@s2),s3:int(xl[i].@s3),s4:int(xl[i].@s4),st:int(xl[i].@st),sex:int(xl[i].@sex)});
				}
				_roleData=hash;
			}
			return _roleData;
		}

		public static function get cdata():HashMap{
			if(!_cdata){
				var hash:HashMap=new HashMap;
				var byteDataXml:ByteArray = new cactions();  
				var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
				var xl:XMLList=xml.act;
				for (var i:int = 0; i < xl.length(); i++) 
				{
					hash.put(int(xl[i].@id),
						{n:String(xl[i].@n),
							s:int(xl[i].@s)});
				}
				hash.put(99,{n:"试探"});
				_cdata=hash;
				
			}
			return _cdata; 
		}
	}
}