package winter.Event
{
	import flash.events.Event;
	public class LoadSwfCompleteEvent extends Event {
		public static const LOAD_SWF_COMPLETE:String="LOAD_SWF_COMPLETE";
		private var _mcArray:Array;
		private var _step:uint;
		public function LoadSwfCompleteEvent() {
			super(LOAD_SWF_COMPLETE,true);  //Event(type,bubbles,cancelable),这里第二个参数一定要true才能冒泡触发父容器  
		}
		public function set step(para:uint):void {
			_step=para;
		}
		public function get step():uint {
			return _step;
		}
		public function set mcArray(arr:Array):void {
			_mcArray=arr;
		}
		public function get mcArray():Array {
			return _mcArray;
		}
	}
	
}