package utils
{

	public class ArrayUtil {

		/**
		 * 是否存在数组中
		 * @param arr
		 * @param item
		 * @return
		 */
		public static function hasItem(arr:Array, item:Object):Boolean {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] == item) {
					return true;
				}
			}
			return false;
		}
		/**
		 *找到符合对象的索引 
		 * @param arr
		 * @param item
		 * @return 
		 * 
		 */		
		public static function getIndexByParam(arr:Array,parm:String,item:Object):int {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] && arr[i][parm] == item) {
					return i;
				}
			}
			return -1;
		}

		/**
		 * 是否存在数值中
		 * @param arr
		 * @param parm
		 * @param item
		 * @return
		 */
		public static function hasItemByParm(arr:Array, parm:String, item:Object):Boolean {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm] == item) {
					return true;
				}
			}
			return false;
		}

		/**
		 * 返回数组中符合的对象
		 * @param arr
		 * @param item
		 * @return
		 */
		public static function getItem(arr:Array, item:Object):Object {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] == item) {
					return arr[i];
				}
			}
			return null;
		}

		/**
		 * 返回数组中不符合的对象
		 * @param arr
		 * @param item
		 * @return
		 */
		public static function getNotItem(arr:Array, item:Object):Array {
			var returnArr:Array = new Array();
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] == item) {
					returnArr.push(arr[i]);
				}
			}
			return returnArr;
		}

		/**
		 * 返回数组中符合的对象
		 * @param arr
		 * @param parm
		 * @param item
		 * @return
		 */
		public static function getItemByParm(arr:Array, parm:String, item:Object):Object {
			for (var i:int in arr) {
				if (arr[i][parm] == item) {
					return arr[i];
				}
			}
			return null;
		}

		/**
		 *返回符合条件的数组 
		 * @param arr
		 * @param index
		 * @param item
		 * @return 
		 * 
		 */
		public static function getArrByParm(arr:Array, index:String, item:Object):Array {
			var temp:Array=[];
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][index] == item) {
					temp.push(arr[i]);
				}
			}
			return temp;
		}

		/**
		 * 返回数组中符合的对象数组
		 * @param arr
		 * @param parm
		 * @param item
		 * @param states
		 * @return
		 */
		public static function getItemsByParm(arr:Array, parm:String, item:Object, state:int = 0):Array {
			var retrunArr:Array = new Array();
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] != null && arr[i][parm] != null) {
					if (state == 0) {
						if (arr[i][parm] == item) {
							retrunArr.push(arr[i]);
						}
					} else if (state == -1) {
						if (arr[i][parm] < item) {
							retrunArr.push(arr[i]);
						}
					} else if (state == 1) {
						if (arr[i][parm] > item) {
							retrunArr.push(arr[i]);
						}
					}
				}
			}
			return retrunArr;
		}

		/**
		 * 返回数组中不符合值的数组
		 * @param arr
		 * @param parm
		 * @param item
		 * @return
		 */
		public static function getItemsByParmNot(arr:Array, parm:String, item:Object):Array {
			var retrunArr:Array = new Array()
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm] != item) {
					retrunArr.push(arr[i]);
				}
			}
			return retrunArr;
		}

		/**
		 * 移除某对象
		 * @param arr
		 * @param item
		 */
		public static function removeItem(arr:Array, item:Object):int {
			for (var i:int in arr) {
				if (arr[i] == item) {
					arr.splice(i, 1);
					return i;
				}
			}
			return -1
		}

		/**
		 * 移除某对象
		 * @param arr
		 * @param parm
		 * @param item
		 */
		public static function removeItemByParm(arr:Array, parm:String, item:Object,isFirst:Boolean=true):Object {
			var o:Object;
			for(var i:int in arr){
				if (arr[i][parm] == item) {
					o=arr.splice(i, 1);
					if(isFirst){
						break;	
					}
				}
			}
			if(o)return o[0];
			return null;
		}
		/**
		 * 修改某元素
		 * @param arr
		 * @param parm
		 * @param item
		 * 
		 */		
		public static function updateItemByParm(arr:Array, parm:String, item:Object):void {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm] == item[parm]) {
					arr[i]=item;
				}
			}
		}

		/**
		 * 移除符合数组中对象的属性的属性的对象
		 * @param arr
		 * @param parm
		 * @param childParm
		 * @param item
		 *
		 */
		public static function removeItemByParmChild(arr:Array, parm:String, childParm:String, item:Object):void {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm][childParm] == item) {
					arr.splice(i, 1);
					i--;
				}
			}
		}

		/**
		 * 获得符合数组中符合对象的属性的属性的数组
		 * @param arr
		 * @param parm
		 * @param childParm
		 * @param item
		 * @return
		 */
		public static function getItemsByParmChild(arr:Array, parm:String, childParm:String, item:Object):Array {
			var items:Array = new Array();
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm][childParm] == item) {
					items.push(arr[i]);
				}
			}
			return items;
		}

		/**
		 * 获得符合数组中符合对象的属性的属性的对象
		 * @param arr
		 * @param parm
		 * @param childParm
		 * @param item
		 * @return
		 */
		public static function getItemByParmChild(arr:Array, parm:String, childParm:String, item:Object):Object {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm][childParm] == item) {
					return (arr[i]);
				}
			}
			return null;
		}

		/**
		 * 获得符合数组中符合对象的属性的属性的属性对象
		 * @param arr 数组
		 * @param parm 数组对象的属性
		 * @param childParm 数组对象里的对象的属性
		 * @param item  对应的属性值
		 * @return  数组对象
		 */
		public static function getItemChildByParmChild(arr:Array, parm:String, childParm:String, item:Object):Object {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][parm][childParm] == item) {
					return (arr[i][parm]);
				}
			}
			return null;
		}


		public static function getItemsByPameValues(arr:Array, parm:String, values:Array):Array {
			var items:Array = new Array();
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] != null) {
					if (hasItem(values, arr[i][parm])) {
						items.push(arr[i]);
					}
				}
			}
			return items;
		}

		/**
		 *获得某对象在数组里的序列号
		 * @param arr
		 * @param item
		 * @return
		 *
		 */
		public static function getSeriaNumByItem(arr:Array, item:Object):int {
			var len:int=arr.length;
			for (var i:int = 0; i < len; i++) {
				if (arr[i] == item) {
					return i;
				}
			}
			return -1;
		}

	}
}