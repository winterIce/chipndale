package winter.Load
{
	
	/**
	 * ...
	 * @author winterIce
	 */
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import flash.system.ApplicationDomain;
	import flash.events.Event;
	import flash.display.Loader;
	import winter.Event.LoadSwfCompleteEvent;
	
	public class SwfLoad extends Sprite
	{
		private var loader:Loader;
		private var requests:URLRequest;
		private var swfPath:String;
		private var eleArray:Array;
		private var mcArray:Array;
		private var step:uint;
		
	    public function SwfLoad(swfPath, eleArray, step) {
			this.swfPath = swfPath;
			this.eleArray = eleArray;
			this.step = step;
			load();
		}
		
		private function load() {
			loader= new Loader();
			requests= new URLRequest(this.swfPath);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(this.requests);
		}
		
		private function onComplete(events:Event):void {
			mcArray=new Array();
			var loadedSWF=events.target;
			var domain:ApplicationDomain=loadedSWF.applicationDomain as ApplicationDomain;
			for (var i:uint=0; i<eleArray.length; i++) {
				mcArray.push(domain.getDefinition(eleArray[i]) as Class);
			}
            var loadCompleteEvent:LoadSwfCompleteEvent=new LoadSwfCompleteEvent();
			loadCompleteEvent.mcArray=mcArray;
			loadCompleteEvent.step=step;
			dispatchEvent(loadCompleteEvent);
		}
	}
	
}