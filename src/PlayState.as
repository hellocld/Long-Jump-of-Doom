package  
{
	/**
	 * The PlayState
	 * @author cld
	 */
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		//embed the graphics
		[Embed(source = "floortiles.png")] private var floortilePNG:Class;
		[Embed(source = "background.png")] private var backgroundPNG:Class;
		public var player:Runner;
		
		//the floor map and spike map
		public var floor:FlxTilemap;
		public var spikes:FlxTilemap;
		
		//background
		public var background:FlxSprite;
		
		//the game over text
		private var endText:FlxText;
		private var distance:int = 0;
		
		//the distance text
		private var distText: FlxText;
		
		private var endRun:Boolean = false;
		
		public function PlayState():void 
		{
			
		}
		
		override public function create():void
		{
			background = new FlxSprite(0, 0);
			background.loadGraphic(backgroundPNG, false, false, 640, 240, false);
			background.scrollFactor.x = 0.1;
			add(background);
			
			floor = new FlxTilemap();
			floor.loadMap("1, 1, 1, 1, 1, 1, 1, 2", floortilePNG, 128, 32, 0, 0, 1, 1);
			floor.x = 0;
			floor.y = (240 / 2) + 8;
			floor.solid = true;
			add(floor);
			
			spikes = new FlxTilemap();
			spikes.loadMap("3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3", floortilePNG, 128, 32, 0, 0, 1, 1);
			spikes.x = 1024;
			spikes.y = (240 / 2) + 8;
			spikes.immovable = true;
			spikes.solid = true;
			add(spikes);
			
			
			player = new Runner();
			add(player);
			
			distText = new FlxText(16, 16, 300, "Distance: " + distance, true);
			distText.color = 0xff000000;
			distText.scrollFactor.x = 0;
			distText.scrollFactor.y = 0;
			
			FlxG.worldBounds.make(0, 0, 26000, 240);
			FlxG.worldDivisions = 128;
			
			FlxG.camera.setBounds(0, 0, 20000, 240);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		}
		
		override public function update():void
		{
			super.update();
			
			distance = player.x - 1024;
			if (distance < 0) distance = 0;
			distText.text = "Distance: " + distance;
			add(distText);
			
			FlxG.collide(player, floor);
			FlxG.collide(player, spikes, hitSpikes);
			
			if (endRun)
			{
				endText = new FlxText(16, 16, 300, "\n\n'R' = retry\n'Q' = quit", true);
				endText.scrollFactor.x = 0;
				endText.color = 0xff000000;
				add(endText);
				
			}
			
			if (FlxG.keys.justPressed("R"))
			{
				FlxG.resetState();
			}
			if (FlxG.keys.justPressed("Q"))
			{
				FlxG.switchState(new MenuState);
			}
			
			FlxG.watch(player.velocity, "x");
			FlxG.watch(player, "x");
			FlxG.watch(FlxG.worldBounds, "x");
		}
		
		public function hitSpikes(r:Runner, s:FlxTilemap):void
		{
			FlxG.log("Spike hit!");
			r.play("die");
			if (!r.jumped)
			{
				r.jumped = true;
			}
			if (r.jumpPower > 50)
			{
				r.jumpPower = r.jumpPower / 1.5;
				r.velocity.y -= r.jumpPower;
			} else {
				r.velocity.y = 0;
				r.acceleration.y = 0;
				distance = r.x;
				
				endRun = true;
			}
			
		}
	}

}