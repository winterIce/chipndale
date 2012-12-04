package winter.control
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;	
	
	public class Control extends Sprite
	{		
		private var _up:uint = 0;
		private var _down:uint = 0;
		private var _left:uint = 0;
		private var _right:uint = 0;
		private var _fire:uint = 0;
		private var _jump:uint = 0;
		
		private var isUp:Boolean = false;
		private var isDown:Boolean = false;
		private var isLeft:Boolean = false;
		private var isRight:Boolean = false;
		private var isFire:Boolean = false;
		private var isJump:Boolean = false;
		
		public function Control(up:uint=38,down:uint=40,left:uint=37,right:uint=39,fire:uint=65,jump:uint=83):void {
			_up = up;
			_down = down;
			_left = left;
			_right = right;
			_fire = fire;
			_jump = jump;
		}		

		private function keyDown(e:KeyboardEvent):void {			
			switch(e.keyCode) {
				case _left:
				    isLeft = true;
				    break;
				case _up:
				    isUp = true;
				    break;
				case _right:
				    isRight = true;
				    break;
				case _down:
				    isDown = true;
				    break;
				case _fire:
				    isFire = true;
				    break;
				case _jump:
				    isJump = true;
					break;
			}
		}
		//侦听键盘方向键弹起
		private function keyUp(e:KeyboardEvent):void {			
			switch(e.keyCode) {
				case _left:
				    isLeft = false;
				    break;
				case _up:
				    isUp = false;
				    break;
				case _right:
				    isRight = false;
				    break;
				case _down:
				    isDown = false;
				    break;
				case _fire:
				    isFire = false;
				    break;
				case _jump:
				    isJump = false;
					break;
			}
		}
		public function get UP():Boolean {
			return isUp;
		}
		public function get DOWN():Boolean {
			return isDown;
		}
		public function get LEFT():Boolean {
			return isLeft;
		}
		public function get RIGHT():Boolean {
			return isRight;
		}
		public function get FIRE():Boolean {
			return isFire;
		}
		public function get JUMP():Boolean {
			return isJump;
		}
		
		
		//在舞台添加Control对象后开始侦听键盘，而且必须在添加之后，否则报错stage未定义，
		public function startListen():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		//移除按键侦听器
		public function stopListen():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
	}
	
}