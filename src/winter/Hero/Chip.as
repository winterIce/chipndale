package winter.Hero
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2FilterData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import winter.control.Control;
	import winter.HeroState.*;
	import winter.Data.GameData;
	import winter.Chapter.*;
	import flash.utils.getTimer;
	
	public class Chip extends Sprite 
	{
		private var speedX:uint = 5;
		private var speedY:uint = 15;
		public var mc:MovieClip;
		public var curState:HeroState;
		public var body:b2Body;
		private var chapter:ChapterBase;
		private var ctrl:Control;
		private var moveV:b2Vec2;
		private var pixelsPerMeter:uint;
		private var stateArr:Object;
		
		private var readyJump:Boolean;
		private var readyFire:Boolean;
		
		private var fd:b2FilterData;
		public var dir:String = "right";  //标记当前方向
		private var isLift:Boolean = false;
		
		//子弹最好是抽象成一个类，时间有限，暂且耦合在Chip类下面
		public var bullet:b2Body;
		public var bulletState:String;
		public var bulletDir:String;
		
		public function Chip(chapter:ChapterBase) {
			this.chapter = chapter;
			this.pixelsPerMeter = chapter.pixelsPerMeter;
			this.ctrl = chapter.ctrl;
			mc = new GameData.heroMcArray[0]() as MovieClip;
			addChild(mc);
			body = chapter.box2d.createBox(400, 40, 20, 25, true,"chip");
			body.SetUserData(mc);
			
			stateArr = new Object();
			stateArr.stand = new HeroStand(this);
			stateArr.jump = new HeroJump(this);
			stateArr.walk = new HeroWalk(this);
			stateArr.down = new HeroDown(this);
			
			curState = stateArr.stand;
			curState.dir = "right";
			curState.lift = false;
			curState.transition = 0;
			
			addEventListener(Event.ENTER_FRAME, onenterframe);
			ctrl.startListen();
		}
		public function onenterframe(evt:Event) {
			place();
			checkReady();
			action();
			animation();
		}
		
		private function place() {
			body.GetUserData().x = body.GetPosition().x * chapter.pixelsPerMeter;
			body.GetUserData().y = body.GetPosition().y * chapter.pixelsPerMeter;
			body.GetUserData().rotation = body.GetAngle() * 180 / Math.PI;
		}
		private function checkReady() {
			if (!ctrl.JUMP) {
				readyJump = true;
			}
			if (!ctrl.FIRE) {
				readyFire = true;
			}
		}
		
		private function action() {
			if(ctrl.LEFT){
			    moveV = new b2Vec2(-this.speedX,body.GetLinearVelocity().y);
				body.SetAwake(true);
				body.SetLinearVelocity(moveV);
			}
			else if(ctrl.RIGHT){
			    moveV = new b2Vec2(this.speedX,body.GetLinearVelocity().y);
				body.SetAwake(true);
				body.SetLinearVelocity(moveV);
			}
		    else {
				moveV = new b2Vec2(0, body.GetLinearVelocity().y);
			    body.SetAwake(true);
				body.SetLinearVelocity(moveV);
			}
			
			if (ctrl.JUMP && body.GetLinearVelocity().y == 0 && readyJump) {
				readyJump = false;
				moveV = new b2Vec2(body.GetLinearVelocity().x, -this.speedY);
				body.SetAwake(true);
				body.SetLinearVelocity(moveV);
			}

			if (ctrl.FIRE && readyFire && curState.transition==0) {
				readyFire = false;
				if (!curState.lift) {
					if (ctrl.RIGHT&&isTouchBulletLeftEdge()) {
					    liftBullet();
				    }
				    else if (ctrl.LEFT&&isTouchBulletRightEdge()) {
					    liftBullet();
				    }
				}
				else{
					fire();
				}
			}
			
		}
		
		private function animation() {
			if (curState.startTime!=0) {
				if (getTimer() - curState.startTime >= 150) {
					curState.startTime = 0;
					curState.transition = 0;
				}
				else return ;
			}
			
				if (body.GetLinearVelocity().x == 0 && body.GetLinearVelocity().y == 0) {		
					if (ctrl.DOWN) {
						curState = stateArr.down;
						curState.dir = dir;
						curState.lift = isLift;
						curState.play();
						return ;
					}
					//碰到静态物体的右面仍然要有向左走的动画
					if ( ctrl.LEFT && !(curState is HeroWalk && curState.dir=="left") ) {
						curState = stateArr.walk;
						curState.dir = dir;
						curState.lift = isLift;
						curState.play();
					}
					//碰到静态物体的左面仍然要有向右走的动画
					else if ( ctrl.RIGHT && !(curState is HeroWalk && curState.dir=="right") ) {
						curState = stateArr.walk;
						curState.dir = dir;
						curState.lift = isLift;
						curState.play();
					}
					else if(!ctrl.LEFT&&!ctrl.RIGHT){
						curState = stateArr.stand;
						curState.dir = dir;
						curState.lift = isLift;
						curState.play();
					}
				}
				//水平运动
				else if (body.GetLinearVelocity().y == 0) {
	                if ( body.GetLinearVelocity().x > 0 && !((curState is HeroWalk) && curState.dir == "right") ) {
						dir = "right";
					    curState = stateArr.walk;
						curState.dir = dir;
						curState.lift = isLift;
						curState.play();
					}
					else if (body.GetLinearVelocity().x < 0 && !((curState is HeroWalk) && curState.dir == "left")) {
						dir = "left";
						curState = stateArr.walk;
						curState.dir = dir;
						curState.lift = isLift;
						curState.play();
					}
				}
				//垂直运动
				else if (body.GetLinearVelocity().y != 0) {
					curState = stateArr.jump;
					if (ctrl.LEFT) {
						dir = "left";
					}
					if (ctrl.RIGHT) {
						dir = "right";
					}
					curState.dir = dir;
					curState.lift = isLift;
					curState.play();
					
					//上升过程穿透静态物体
					if (body.GetLinearVelocity().y < 0) {
						fd = new b2FilterData();
				        fd.maskBits = 1;
				        body.GetFixtureList().SetFilterData(fd);
					}
					//下落过程接触物体
					else {
						fd = new b2FilterData();
				        fd.maskBits = 2;
				        body.GetFixtureList().SetFilterData(fd);
					}
				}
		}
		
		
		
		private function fire() {
			curState.transition = 2;
			curState.lift = false;
			isLift = false;
			curState.startTime = getTimer();
		    mc.gotoAndPlay("fire");
			
			bulletState = "fire";
			bulletDir = dir;
			bullet.SetType(b2Body.b2_dynamicBody);//一定要设为动态型
			fd = new b2FilterData();
			fd.maskBits = 4;
			fd.categoryBits = 6;
			bullet.GetFixtureList().SetFilterData(fd);//穿透静态物
			bullet.SetPosition(new b2Vec2(body.GetPosition().x, body.GetPosition().y - 1.5));
		}
		private function liftBullet() {
			bullet.SetPosition(new b2Vec2( -10, -10));
			bulletState = "lift";
			curState.transition = 1;
			curState.lift = true;
			isLift = true;
			curState.startTime = getTimer();
			//mc.gotoAndPlay("down");
		}
		
		private function isTouchBulletLeftEdge() {
			bullet = touchBullet();
			if (bullet) {
				if(body.GetPosition().x*pixelsPerMeter>=bullet.GetPosition().x*pixelsPerMeter-40.25){
                	return true;	
				}
				else return false;
			}
			else return false;
		}
		private function isTouchBulletRightEdge() {
			bullet = touchBullet();
			if (bullet) {
				if(body.GetPosition().x*pixelsPerMeter<=bullet.GetPosition().x*pixelsPerMeter+40.25){
                	return true;	
				}
				else return false;
			}
			else return false;
		}
		
		private function touchBullet() {
			for (var a = body.GetContactList(); a; a = a.next) {
				if (a.contact.GetFixtureB().GetBody().GetUserData() is GameData.heroMcArray[1]) {
					return a.contact.GetFixtureB().GetBody();
				}
			}
		}
	}
}