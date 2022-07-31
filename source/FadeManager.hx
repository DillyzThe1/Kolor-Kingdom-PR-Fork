package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class FadeManager
{
	public static var nextFadeIn:Bool = false;
	public static var nextFadeDuration:Float = 0.5;

	public static function fadeAndSwitchState(newState:Class<FlxState>, ?duration:Float = 0.5)
	{
		FlxG.camera.fade(FlxColor.BLACK, duration, false, function()
		{
			nextFadeIn = true;
			nextFadeDuration = duration;
			FlxG.switchState(Type.createInstance(newState, []));
		});
	}
}
