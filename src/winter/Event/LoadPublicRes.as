package winter.Event
{
	import flash.display.Sprite;
	import flash.events.Event;
	import winter.Data.GameData;
	import winter.Load.SwfLoad;
	import winter.Event.*;
	public class LoadPublicRes extends Sprite {
		private var loader:SwfLoad;
		public function LoadPublicRes(){
			loader = new SwfLoad(GameData.heroPath, GameData.heroEleArray, 0);
			addChild(loader);
			addEventListener(LoadSwfCompleteEvent.LOAD_SWF_COMPLETE,loadNextSWF);
		}
		private function loadNextSWF(evt:LoadSwfCompleteEvent) {
			if (evt.step == 0) {
				GameData.heroMcArray = evt.mcArray;
				removeChild(loader);
				removeEventListener(LoadSwfCompleteEvent.LOAD_SWF_COMPLETE, loadNextSWF);
				loaded();
			}else if (evt.step == 3) {
				
			}
		}
		private function loaded():void {
			var mainProcessEvent:MainProcessEvent=new MainProcessEvent();
			mainProcessEvent.step=1;
			dispatchEvent(mainProcessEvent);
		}
	}
}