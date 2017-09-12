package manage
{
	import net.singuerinc.media.audio.Audio;

	public class AudioManager
	{
		private var _audio:Audio;
		public function AudioManager()
		{
			
		}
		private var _musicOn:Boolean=true;
		public var voiceOn:Boolean=true;

		public function get musicOn():Boolean
		{
			return _musicOn;
		}

		public function set musicOn(value:Boolean):void
		{
			_musicOn = value;
			if(!value)_audio.pause()
			else _audio.resume();
		}

		public function play(url:String):void{
			if(!voiceOn)return;
			var a:Audio=new Audio("id",url);
			a.play();
		}
		public function backPlay(url:String):void{
			if(!musicOn)return;
			if(_audio && _audio.isPlaying())_audio.destroy();
			_audio = new Audio('id',  'assets/sounds/'+url+'.mp3');
			_audio.loops=10000;
			_audio.play();
		}
	}
}