package utils
{
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	public class OBJUtil
	{
		/**
		 * 返回一个圆形坐标系
		 * @param num    个数
		 * @param cx   圆心坐标
		 * @param cy
		 * @param radio  半径
		 * @return 
		 * 
		 */		
		public static function getCirclePos(num:int, cx:int,cy:int,radio:int):Array{
							var i:Number=  360/num;
							var result:Array=[];
							var a:Number=0;
							for(var j:int=0;j<num;j++){
								a+=i/180*Math.PI;
								result.push({x:cx+Math.cos(a)*radio,y:cy+Math.sin(a)*radio});
							}
							return result;
		}
		public static function getCenterPos(cw:int,ch:int,carNum:int,carW:int,carH:int,space:int=3):Array{
			var toWidth:int=carW*carNum+space*(carNum-1);
			var tx:Number;
			var ty:Number=(ch-carH)/2;
			var temp:Array=[];
			if(toWidth>cw){
				tx=(cw-carW)/(carNum-1);
				for(var i:int=0;i<carNum;i++){
					temp.push({x:tx*i,y:ty});
				}
			}else{
				tx=(cw-toWidth)/2;
				for(var i:int=0;i<carNum;i++){
					temp.push({x:tx+(carW+space)*i,y:ty});
				}
			}
			return temp;
		}
		public static function getInstanceByClassName(n:String):Object{
			try
			{
				var o:*=getDefinitionByName(n);
				return new o();
			}catch(error:Error) 
			{
				trace("错误的类名！！");
				return null;
			}
		}
		public static function copyObject(source:*):*{
//			var typeName:String = getQualifiedClassName(source);//获取全名
//	        var packageName:String = typeName.split("::")[1];//切出包名
//	        var type:Class = Class(getDefinitionByName(typeName));//获取Class
//	        registerClassAlias(packageName, type);//注册Class
	        //复制对象
	        var copier:ByteArray = new ByteArray();
	        copier.writeObject(source);
	        copier.position = 0;
	        return copier.readObject();
		}
		/**
		 *复制一个对象属性值到另一对象 
		 * @param source	源对象
		 * @param target	目标对象
		 * 
		 */		
		public static function copyProperties(source:Object,target:Object):Object{
			for(var i:* in source){
				if(target.hasOwnProperty(i)){
					target[i]=source[i]
				}
			}
			return target;
		}
//		public static function copyProperties(source:Object,target:Object):Object{
//			for(var i in source){
//				if(target.hasOwnProperty(i)){
//					target[i]=source[i]
//				}
//			}
//			return target;
//		}
	}
}