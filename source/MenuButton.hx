package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MenuButton extends FlxSprite
{
	var side:String;

	public var selected:Bool = false;

	var tween:FlxTween;
	var ogX:Float;
	var ogY:Float;

	public var globalType:String;

	override public function new(x:Float, y:Float, type:String)
	{
		super(x, y);

		ogX = this.x;
		ogY = this.y;
		globalType = type;

		this.frames = LazyPathStuff.getXml("buttons");
		this.animation.addByPrefix("idle", type + " idle", 24, true);

		if (type == "start" || type == "quit")
			this.animation.addByPrefix("confirm", type + " confirm", 24, true);

		this.animation.play("idle", true);

		if (type == "start" || type == "multiplayer")
			side = "left";
		else if (type == "options" || type == "achievements")
			side = "right";
		else if (type == "quit")
			side = "bottom";
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this) && !selected)
		{
			FlxG.sound.play(LazyPathStuff.soundPath("buttonHover.ogg"));

			selected = true;
			if (tween != null)
				tween.cancel();

			if (side == "left")
				tween = FlxTween.tween(this, {x: ogX + 20}, 0.2, {ease: FlxEase.cubeInOut});
			else if (side == "right")
				tween = FlxTween.tween(this, {x: ogX - 20}, 0.2, {ease: FlxEase.cubeInOut});
			else if (side == "bottom")
				tween = FlxTween.tween(this, {y: ogY - 20}, 0.2, {ease: FlxEase.cubeInOut});
		}
		else if (!FlxG.mouse.overlaps(this) && selected)
		{
			FlxG.sound.play(LazyPathStuff.soundPath("buttonDeselect.ogg"));

			selected = false;
			if (tween != null)
				tween.cancel();

			if (side == "left")
				tween = FlxTween.tween(this, {x: ogX}, 0.2, {ease: FlxEase.cubeInOut});
			else if (side == "right")
				tween = FlxTween.tween(this, {x: ogX}, 0.2, {ease: FlxEase.cubeInOut});
			else if (side == "bottom")
				tween = FlxTween.tween(this, {y: ogY}, 0.2, {ease: FlxEase.cubeInOut});
		}
	}

	public function clicked()
	{
		if (globalType == "start" || globalType == "quit")
			this.animation.play("confirm");

		FlxG.sound.play(LazyPathStuff.soundPath("buttonConfirm.ogg"));
		var clickedTimer:FlxTimer = new FlxTimer();
		clickedTimer.start(1, function(time:FlxTimer)
		{
			if (globalType == "quit")
			{
				#if (desktop && cpp)
				Sys.exit(0);
				#end
			}
			else if (globalType == "start")
			{
				FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
				{
					FlxG.switchState(new PlayState());
				});
			}
			else
			{
				trace("no functionality :sad_sping_bing:");
			}
		}, 0);
	}
}
