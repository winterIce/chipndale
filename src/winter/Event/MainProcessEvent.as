package winter.Event
{
	import flash.events.Event;
	public class MainProcessEvent extends Event {
		public static const LOAD_COMPLETE:String="LOAD_COMPLETE";
		private var _step:uint;
		public function MainProcessEvent() {
			super(LOAD_COMPLETE,true);  
		}
		public function set step(para:uint):void {
			_step=para;
		}
		public function get step():uint {
			return _step;
		}
	}
	
}