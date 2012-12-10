package winter.Boss
{
	import flash.display.Sprite;
	import winter.Chapter.*;
	import winter.Hero.Chip;
	
	public class Boss extends Sprite 
	{
		public var chapter:ChapterBase;
		
		public function Boss(chapter:ChapterBase) {
			this.chapter = chapter;
		}
	}
	
}