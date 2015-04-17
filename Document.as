package 
{
	import flash.display.MovieClip
	
	public class Document extends MovieClip
	{

		private var correctAnswer:String;

		public function Document()
		{
		}
		
		public function setCorrectAnswer(a:String):void {
			this.correctAnswer = a;
		}
		
		public function returnCorrectAnswer():String {
			return this.correctAnswer;
		}
	}
}