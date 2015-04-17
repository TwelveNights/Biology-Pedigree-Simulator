package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;

	public class Couple extends MovieClip
	{

		private var wife:Autosome;
		private var husband:Autosome;
 
		private var _root:MovieClip;

		public function Couple(m:Autosome, f:Autosome)
		{
			if (f.returnGender())
			{
				wife = f;
				husband = m;
			}
			else if (m.returnGender())
			{
				husband = f;
				wife = m;
			}

			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrame);
			husband.x = 0;
			husband.y = 0;
			wife.x = 20;
			wife.y = 0;

		}

		public function rollBool():Boolean
		{
			var dice:int = Math.round(Math.random() * 100);

			if (dice > 50)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);

			addChild(husband);
			addChild(wife);
		}

		private function eFrame(e:Event):void
		{
			if (_root.gameOver == true)
			{
				this.removeEventListener(Event.ADDED, beginClass);
				this.removeEventListener(Event.ENTER_FRAME, eFrame);
				MovieClip(this.parent).removeChild(this);
			}
		}

		public function getMan():Autosome
		{
			return husband;
		}

		public function getGirl():Autosome
		{
			return wife;
		}
	}
}