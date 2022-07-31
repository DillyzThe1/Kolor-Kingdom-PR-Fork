package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MenuButton extends KKSprite
{
	var side:String;

	public var selected:Bool = false;
	public var confirmed:Bool = false;
	public var tweening:Bool = false;

	var tween:FlxTween;
	var ogX:Float;
	var ogY:Float;

	public var globalType:String;

	override public function new(x:Float, y:Float, type:String)
	{
		super(x, y, 'buttons', true);

		ogX = this.x;
		ogY = this.y;
		globalType = type;

		this.addAnim("start", "start idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("startConfirm", "start confirm", new FlxPoint(0, 8));
		this.addAnim("options", "options idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("multiplayer", "multiplayer idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("achievements", "achievements idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("quit", "quit idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("quitConfirm", "quit confirm", new FlxPoint(10, 40));

		this.playAnim(type, true);

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

		if (!confirmed || !tweening)
		{
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
	}

	public function clicked()
	{
		if (globalType == "start" || globalType == "quit")
		{
			confirmed = true;
			this.animation.play('${globalType}Confirm');

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
					FadeManager.fadeAndSwitchState(PlayState);
				}
				else
				{
					trace("no functionality :sad_sping_bing:");
				}
			}, 0);
		}
	}
}
