package utils
{
	
	import flash.display.MovieClip;
	
	public class MovieSharedLibrary
	{
		private static var msl:MovieSharedLibrary=new MovieSharedLibrary;
		private var sharedMovies:HashMap;
		public static function instance():MovieSharedLibrary
		{
			return msl;
		}
		
		public function MovieSharedLibrary(){
			sharedMovies=new HashMap;
		}
		
		public function hasMovie(url:String):Boolean{
			if(sharedMovies.getValue(url)){
				return true;
			}
			return false;
		}
		
		public function getContent(url:String):Object{
			return sharedMovies.getValue(url)
		}
		
		public function getMovie(url:String):MovieClip{	
			try{
				var mov:MovieClip=sharedMovies.getValue(url).getMC();
			}catch(e:Error){
				throw Error("读取不到模型文件,地址为:"+url);
//				trace("读取不到模型文件,地址为:"+url)
			}
			return mov;
		}
		
		
		public function saveMovie(url:String,mc:Object):void{
			sharedMovies.put(url,mc);
		}
		
		public function removeMovie(url:String):void{
			sharedMovies.remove(url);			
		}
		
		public function removeAllMovie():void{
			sharedMovies.clear();
		}

	}
}