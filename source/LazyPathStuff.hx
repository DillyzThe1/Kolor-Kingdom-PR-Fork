package;

import flixel.graphics.frames.FlxAtlasFrames;

/**
	*funny path class based off fnf that i use in all my haxeflixel stuff
 */
class LazyPathStuff
{
	public static function soundPath(file:String, subfolder:String = "")
	{
		return "assets/sounds/" + subfolder + file;
	}

	public static function imagePath(file:String, subfolder:String = "")
	{
		return "assets/images/" + subfolder + file;
	}

	public static function songPath(file:String, subfolder:String = "")
	{
		return "assets/music/" + subfolder + file;
	}

	inline public static function getXml(file:String, subfolder:String = ""):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow("assets/images/" + subfolder + file + ".png", "assets/images/" + subfolder + file + ".xml");
	}
}
