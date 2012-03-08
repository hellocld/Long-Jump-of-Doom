package  
{
	/**
	 * A basic Main Menu
	 * @author cld
	 */
	
	import org.flixel.*
	public class MenuState extends FlxState
	{
		//the game title
		private var title:FlxText;
		//some info text
		private var info:FlxText;
		
		[Embed(source = "title.png")] private var titlePng:Class;
		private var titleSprite:FlxSprite;
		public function MenuState()
		{
			
		}
		
		override public function create():void
		{
			/*
			title = new FlxText(16, 16, 200, "LONG JUMP OF DOOM - a crappy game by CLD");
			info = new FlxText(16, 64, 200, "TAP 'A' AND 'L' TO  RUN.\nSPACE TO JUMP.\n\nPress X to play");
			add(title);
			add(info);
			*/
			titleSprite = new FlxSprite(0, 0);
			titleSprite.loadGraphic(titlePng, false, false, 320, 240, false);
			add(titleSprite);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.X)
			{
				FlxG.switchState(new PlayState);
			}
		}
		
	}

}