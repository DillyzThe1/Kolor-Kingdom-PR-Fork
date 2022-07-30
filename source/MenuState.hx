package;

import KKSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var logo:KKSprite;
	var play:MenuButton;
	var options:MenuButton;
	var multiplayer:MenuButton;
	var achievements:MenuButton;
	var quit:MenuButton;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.WHITE;

		play = new MenuButton(-100, 0, "start");
		add(play);

		options = new MenuButton(980, 0, "options");
		options.alpha = 0.7;
		add(options);

		multiplayer = new MenuButton(-100, 0, "multiplayer");
		multiplayer.alpha = 0.7;
		add(multiplayer);

		achievements = new MenuButton(920, 0, "achievements");
		achievements.alpha = 0.7;
		add(achievements);

		quit = new MenuButton(0, 620, "quit");
		quit.screenCenter(X);
		quit.x += 70;
		add(quit);

		logo = new KKSprite(0, 10, "logo", true);
		logo.screenCenter(X);
		logo.addAnim("idle", "real logo", new FlxPoint(0, 0), 24, true);
		logo.playAnim("idle");
		add(logo);

		play.y = logo.y + 265;
		options.y = play.y + 85;
		multiplayer.y = options.y + 85;
		achievements.y = multiplayer.y + 85;

		trace(FlxNerd.nerd("momazos diego"));

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(LazyPathStuff.songPath("funny game menu.ogg"));

		if (FlxG.mouse.justPressed)
		{
			var buttons = [play, options, multiplayer, achievements, quit];

			for (i in buttons)
			{
				if (i.selected)
				{
					if (!i.confirmed)
					{
						i.clicked();
						if (i == play || i == quit)
							tweenButtons(i);
					}
				}
			}
		}

		#if debug
		if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new OffsetState());
		#end
	}

	public function tweenButtons(type:MenuButton)
	{
		trace(FlxNerd.nerd(type.globalType));

		if (!type.confirmed)
			type.tweening = true;

		if (type != play)
			FlxTween.tween(play, {x: play.x - 500}, 0.5, {ease: FlxEase.backIn});
		if (type != options)
			FlxTween.tween(options, {x: options.x + 500}, 0.5, {ease: FlxEase.backIn});
		if (type != multiplayer)
			FlxTween.tween(multiplayer, {x: multiplayer.x - 500}, 0.5, {ease: FlxEase.backIn});
		if (type != achievements)
			FlxTween.tween(achievements, {x: achievements.x + 500}, 0.5, {ease: FlxEase.backIn});
		if (type != quit)
			FlxTween.tween(quit, {y: quit.y + 500}, 0.5, {ease: FlxEase.backIn});
	}
}
