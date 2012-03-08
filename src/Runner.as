package  
{
	/**
	 * The running dude
	 * 
	 * @author cld
	 */
	
	import org.flixel.*;
	
	public class Runner extends FlxSprite
	{
		[Embed(source = "player.png")] private var sheet:Class;
		
		//gravity
		private var gravity:Number = 400;
		
		//speed per press
		private var speed:Number = 200;
		
		//jump power
		public var jumpPower:Number = 0;
		
		//boolean for key flip
		private var akey:Boolean = false;
		
		//boolean for allowing input before jump
		public var jumped:Boolean = false;
		
		public function Runner() 
		{
			super(8, (240/2)-8);
			
			//basic square graphic
			loadGraphic(sheet, true, false, 8, 16, false);
			
			addAnimation("run", [0, 1, 2], 12, true);
			addAnimation("up", [3], 0, false);
			addAnimation("down", [4], 0, false);
			addAnimation("die", [5, 6, 7, 8, 9], 6, true);
			
			maxVelocity.x = speed * 4;
			drag.x = 400;
			
			solid = true;
			
			//gravity
			acceleration.y = gravity;
		}
		
		override public function update():void
		{
			super.update();
			if (!jumped)
			{
				play("run");
				if (akey && FlxG.keys.justPressed("L"))
				{
					velocity.x += speed;
					akey = false;
				} else if (!akey && FlxG.keys.justPressed("A")) {
					velocity.x += speed;
					akey = true;
				}
				
				if (FlxG.keys.justPressed("SPACE"))
				{
					jumped = true;
					drag.x = 200;
					jumpPower = 300;
					velocity.y -= jumpPower;
					play("up");
				}
				
			}
			if (velocity.y > 0) play("up");
			if (velocity.y < 0) play ("down");
		}
	}

}