package 
{
	
	/**
	 * ...
	 * @author winterIce
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import winter.control.*;
	import winter.Load.*;
	import winter.Event.*;
	import winter.Data.*;
	import winter.Hero.*;
	import winter.HeroState.*;
	import winter.Chapter.*;
	import winter.Box2d.*;
	
	[SWF(width = "800", height = "600", frameRate = "60", backgroundColor = "0x000000")]
	
	public class Main extends Sprite
	{
		private var load:LoadPublicRes;
		private var chapter:ChapterBase;
		private var ctrl:Control;
		public function Main() {
			load = new LoadPublicRes();
			addChild(load);
			addEventListener(MainProcessEvent.LOAD_COMPLETE, loadEnd);
		}
		
		private function loadEnd(evt:MainProcessEvent) {
			removeChild(load);
			removeEventListener(MainProcessEvent.LOAD_COMPLETE, loadEnd);
			startGame();
		}
		
		private function startGame() {
			ctrl = new Control();
			addChild(ctrl);
			chapter = new Chapter7(ctrl);
			addChild(chapter);
		}
	}
	
}