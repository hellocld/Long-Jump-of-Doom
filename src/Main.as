package 
{
	import org.flixel.*;
	
	/**
	 * LONG JUMP OF DOOM for the Pirate Kart V game jam
	 * @author cld
	 */
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	
	public class Main extends FlxGame 
	{
		function Main():void
		{
			super(320, 240, MenuState, 2, 60, 60, true);
			forceDebugger = false;		
		}
	}
	
}