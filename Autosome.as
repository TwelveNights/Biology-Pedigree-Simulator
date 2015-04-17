package 
{

	import flash.display.MovieClip;
	import flash.events.*;


	// INVARIANT: Heterozygous are true/false
	public class Autosome extends MovieClip
	{

		private var firstAllele:Boolean;// true is Dominant, 1.
		private var secondAllele:Boolean;// false is Recessive, 0.
		private var sex:Boolean;

		private var parents:Couple = null;

		private var firstX:Boolean;
		private var secondX:Boolean;
		protected var _root:MovieClip;


		public function Autosome(parents:Couple, gender:Boolean)
		{
			
			firstAllele = false;
			secondAllele = false;
			
			firstX = false;
			secondX = false;
			this.sex = gender;
			this.addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(e:Event):void
		{
			this.addEventListener(Event.ENTER_FRAME, eFrame);
			_root = MovieClip(root);

			assignAlleles();
			if (_root.isRecessive && secondAllele||
			_root.isRecessive && firstAllele ||
			_root.isDominant && firstAllele && secondAllele ||
			_root.isRecessive && firstX ||
			_root.isRecessive && secondX ||
			_root.isDominant && firstX && secondX)
			{
				drawUnaffected();
			}
			else
			{
				drawAffected();
			}
		}


		private function assignAlleles():void
		{
			var selection = roll();

			if (_root.autosomeMode)
			{
				if (parents == null)
				{
					if (selection > 50)
					{
						firstAllele = true;
						secondAllele = false;
					}
					else if (selection <= 50 && selection > 25)
					{
						firstAllele = true;
						secondAllele = true;
					}
					else
					{
						firstAllele = false;
						secondAllele = false;
					}
				}
				else
				{
					var dad1:Boolean = parents.getMan().getA1();
					var dad2:Boolean = parents.getMan().getA2();
					var mom1:Boolean = parents.getGirl().getA1();
					var mom2:Boolean = parents.getGirl().getA2();

					if (dad1 && dad2 && mom1 && mom2)
					{
						firstAllele = true;
						secondAllele = true;
					}
					else if (dad1 && dad2 && mom1 && !mom2)
					{
						if (selection > 50)
						{
							firstAllele = true;
							secondAllele = false;
						}
						else
						{
							firstAllele = true;
							secondAllele = true;
						}
					}
					else if (dad1 && dad2 && !mom1 && !mom2)
					{
						firstAllele = true;
						secondAllele = false;
					}
					else if (dad1 && !dad2 && mom1 && mom2)
					{
						if (selection > 50)
						{
							firstAllele = true;
							secondAllele = false;
						}
						else
						{
							firstAllele = true;
							secondAllele = true;
						}
					}
					else if (dad1 && !dad2 && mom1 && !mom2)
					{
						if (selection > 75)
						{
							firstAllele = false;
							secondAllele = false;
						}
						else if (selection <= 50)
						{
							firstAllele = true;
							secondAllele = false;
						}
						else
						{
							firstAllele = true;
							secondAllele = true;
						}
					}
					else if (dad1 && !dad2 && !mom1 && !mom2)
					{
						if (selection > 50)
						{
							firstAllele = true;
							secondAllele = false;
						}
						else
						{
							firstAllele = false;
							secondAllele = false;
						}
					}
					else if (!dad1 && !dad2 && mom1 && mom2)
					{
						firstAllele = true;
						secondAllele = false;
					}
					else if (!dad1 && !dad2 && mom1 && !mom2)
					{
						if (selection > 50)
						{
							firstAllele = true;
							secondAllele = false;
						}
					}
					else
					{
						firstAllele = false;
						secondAllele = false;
					}
				}
			}
			else if (_root.xLink)
			{
				if (parents == null)
				{
					if (sex)
					{
						if (selection > 50)
						{
							firstX = true;
							secondX = false;
						}
						else if (selection <= 50 && selection > 25)
						{
							firstX = true;
							secondX = true;
						}
						else
						{
							firstX = false;
							secondX = false;
						}
					}
					else
					{
						if (selection > 50)
						{
							firstX = true;
						}
						else
						{
							firstX = false;
						}
					}
				}
				else
				{
					if (sex)
					{
						if (dad1 && mom1 && mom2)
						{
							firstX = true;
							secondX = true;
						}
						else if (!dad1 && mom1 && mom2)
						{
							firstX = true;
							secondX = false;
						}
						else if (dad1 && mom1 && !mom2)
						{
							if (selection > 50)
							{
								firstX = true;
								secondX = true;
							}
							else
							{
								firstX = true;
								secondX = false;
							}
						}
						else if (!dad1 && mom1 && !mom2)
						{

							if (selection > 50)
							{
								firstX = true;
								secondX = false;
							}
							else
							{
								firstX = false;
								secondX = false;
							}
						}
						else if (dad1 && !mom1 && !mom2)
						{
							firstX = true;
							secondX = false;
						}
						else
						{
							firstX = false;
							secondX = false;
						}
					}
					else
					{
						if (dad1 && mom1 && mom2)
						{
							firstX = true;
						}
						else if (!dad1 && mom1 && mom2)
						{
							firstX = true;
						}
						else if (dad1 && mom1 && !mom2)
						{
							if (selection > 50)
							{
								firstX = true;
							}
							else
							{
								firstX = false;
							}
						}
						else if (!dad1 && mom1 && !mom2)
						{

							if (selection > 50)
							{
								firstX = true;
							}
							else
							{
								firstX = false;
							}
						}
						else if (dad1 && !mom1 && !mom2)
						{
							firstX = false;
						}
						else
						{
							firstX = false;
						}
					}
				}
			}
		}


		private function eFrame(e:Event):void
		{
			if (_root.gameOver)
			{
				this.removeEventListener(Event.ADDED, beginClass);
				this.removeEventListener(Event.ENTER_FRAME, eFrame);
				MovieClip(this.parent).removeChild(this);
			}
		}

		private function roll():Number
		{
			return Math.round(Math.random()*100);
		}

		private function drawAffected():void
		{
			this.graphics.beginFill(0x000000);
			if (sex == true)
			{
				this.graphics.drawCircle(10,10,10);
			}
			else
			{
				this.graphics.drawRect(0,0,20,20);
			}
			this.graphics.endFill();
		}

		private function drawUnaffected():void
		{
			this.graphics.beginFill(0x000000);
			if (sex)
			{
				this.graphics.drawCircle(10,10,10);
			}
			else
			{
				this.graphics.drawRect(0,0,20,20);
			}
			this.graphics.endFill();

			this.graphics.beginFill(0xFFFFFF);
			if (sex == true)
			{
				this.graphics.drawCircle(10,10,7.5);
			}
			else
			{
				this.graphics.drawRect(2.5,2.5,15,15);
			}
		}

		public function returnGender():Boolean
		{
			return sex;
		}

		public function getA1():Boolean
		{
			return firstAllele;
		}

		public function getA2():Boolean
		{
			return secondAllele;
		}
	}
}