package 
{
	import flash.events.*;
	import flash.text.*;
	import flash.display.MovieClip;

	public class AnswerButton extends MovieClip
	{

		private var answer:String;
		private var txt:TextField;
		private var _root:MovieClip;

		public function AnswerButton(a:String)
		{
			txt = new TextField();
			this.answer = a;
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);

			txt.border = true;
			txt.borderColor = 0x000000;
			txt.textColor = 0x000000;
			
			txt.y = 0;
			txt.width = 150;
			txt.height = 20;
			txt.wordWrap = true;
			txt.text = answer;

			this.addEventListener(MouseEvent.CLICK, thisClick);

			if (answer == "Recessive Autosome")
			{
				txt.x = 0;
				addChild(txt);
			}
			else if (answer == "Dominant Autosome")
			{
				txt.x = 150;
				addChild(txt);
			}
			else if (answer == "Recessive X-linked Chromosome")
			{
				txt.x = 300;
				addChild(txt);
			}
			else if (answer == "Dominant X-linked Chromosome")
			{
				txt.x = 450;
				addChild(txt);
			}
		}

		private function eFrame(e:Event):void
		{
			if (_root.gameOver)
			{
				this.removeEventListener(Event.ADDED, beginClass);
				this.removeEventListener(Event.ENTER_FRAME, eFrame);
				this.removeEventListener(MouseEvent.CLICK, thisClick);
				MovieClip(this.parent).removeChild(this);
			}
		}


		private function thisClick(e:MouseEvent):void
		{
			_root.selectedAnswer = answer;
		}
	}
}