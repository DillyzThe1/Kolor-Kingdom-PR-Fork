package;

import KKSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

using StringTools;

class Player extends KKSprite
{
	var intendedAnim:String = "idle";
	var isRunning:Bool = false;

	override public function new(x:Float, y:Float)
	{
		super(x, y, "player", true);

		this.addAnim("idle", "idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("runRight", "stop running :nerd:", new FlxPoint(0, 0), 24, true);
		this.addAnim("runLeft", "stop running :nerd:", new FlxPoint(50, 0), 24, true);
		this.playAnim("idle");
	}

	var lastRunLeft:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.LEFT)
		{
			isRunning = true;
			this.x = this.x - 5;
			intendedAnim = "runLeft";
			this.flipX = lastRunLeft = true;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			isRunning = true;
			this.x = this.x + 5;
			intendedAnim = "runRight";
			this.flipX = lastRunLeft = false;
		}
		if (FlxG.keys.pressed.UP)
		{
			isRunning = true;
			this.y = this.y - 5;
			intendedAnim = 'run${lastRunLeft ? 'Left' : 'Right'}';
		}
		else if (FlxG.keys.pressed.DOWN)
		{
			isRunning = true;
			this.y = this.y + 5;
			intendedAnim = 'run${lastRunLeft ? 'Left' : 'Right'}';
		}
		if (!FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP && isRunning)
		{
			isRunning = false;
			intendedAnim = "idle";
		}

		if (this.animation.curAnim.name != intendedAnim)
			this.playAnim(intendedAnim, true, false, this.animation.curAnim.name.startsWith("run") ? this.animation.curAnim.curFrame : 0);
	}
}
/*  ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⡀⠄⠄⠄⠄⠄⠄⠄⠄⣀⣀⣀⠄⠄⠄⠄⠄⠄⢰⠄⠄⠄⠄⠄⠄⠄⠄⣀⡀⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡰⠖⠛⠛⠒⠂⠄⠄⠄⠄⠄⢀⣉⡉⠉⠙⠳⠶⠤⠤⠶⠚⠋⠉⠄⣀⣈⣉⠒⠢⢤⣤⣤⡼⠶⠤⠐⠠⢤⣴⠖⠛⠁⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⠁⠄⠄⠄⠄⣴⣦⠄⠄⠄⠄⠈⡉⡿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⠋⡉⠙⠄⠄⠄⠄⠄⠄⢀⣀⡀⠄⠄⠈⣷⠄⢀⡄⠄⠄⠄⠄⠄⢀
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⠄⠄⣀⠄⠄⠛⠁⠄⠄⠄⣠⡾⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢹⣄⠄⠄⠄⠄⠄⠄⠈⠻⠟⠄⠄⢀⡏⠄⡾⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣠⣤⣶⣿⣍⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⠄⠄⠈⠙⢳⣦⣄⣀⣀⠄⠄⠄⠄⠄⢀⡞⠄⠄⣧⠄⠄⠄⠄⣤⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡰⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠄⠄⠄⠄⠄⠄⠠⠊⠄⣀⣤⣾⣿⣿⣿⣿⣿⣿⣿⡛⠛⠻⠟⠛⡆⠄⠄⠘⠷⣤⣤⣼⠟⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡄⠄⢠⣾⣿⣿⣿⣿⣿⣿⡿⠟⠠⣻⣿⣧⡀⠄⠄⠄⠐⠁⢠⣾⣿⣿⣿⣿⣿⣿⣷⡾⣟⣿⣿⣄⠄⠄⢠⠆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⠁⢀⣿⣿⣿⣿⣿⣿⣿⣿⡄⠄⠄⣿⣿⣿⣧⠄⠄⣤⠄⢠⣿⡿⣼⣿⣿⣿⣿⣿⠁⠄⠈⣷⣽⣿⣆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡞⠄⢸⣿⠅⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣹⣿⠄⠄⡟⠄⢸⣿⠷⣿⣿⣿⣿⣿⣿⣷⣦⣾⣿⣧⣼⣿⠄⠄⢰⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣇⠄⠸⣏⡠⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⡿⠄⢀⡇⠄⢸⣿⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⠄⠄⡸⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢻⡀⠄⠻⣷⣄⠿⣿⣿⣿⣿⣿⣿⣿⡛⢷⣿⠃⠄⣼⣧⠄⠈⢿⣆⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⢩⣿⠃⠄⢀⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄ 
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢳⡀⠄⠙⢿⣄⡈⣹⠛⠛⠛⣉⣀⣿⠟⠁⢠⣾⡇⠘⣧⡀⠈⠻⣶⣯⠙⢻⠿⠿⠟⣟⢻⣀⡿⠋⠄⣠⠟⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢹⣦⣀⠄⠈⠙⠛⠛⠛⠛⠛⠋⠁⣠⣴⣿⣿⡇⠰⣿⣷⣤⡀⠈⠙⠻⠾⠾⠶⠶⠿⠟⠉⠄⣠⠔⢻⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣷⣶⣶⣤⣤⣤⣴⣶⣿⣿⠛⣿⣿⡇⠄⡏⠙⢻⣿⣷⣶⣤⣄⣀⣀⣠⣤⣤⠶⠛⠁⢠⡾⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⠉⠛⠿⠿⠿⠟⠛⠛⠛⠛⠋⠁⠄⢸⣿⡇⠄⡇⠄⠄⠈⠙⠛⠻⠿⠉⠁⠄⠁⠄⠄⠄⠄⣾⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣼⠃⠄⠄⢠⣄⠄⠄⠄⠄⠄⠄⠄⢀⣴⣾⣿⡇⠄⣧⣄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣻⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⣿⣄⠄⠄⠄⠁⠄⠄⠄⠄⠄⠄⢀⡞⢁⣾⣿⠃⠄⡿⠙⢷⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⣶⡆⢀⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢻⣿⡆⠄⠄⣤⣤⣄⠄⠄⠄⠄⡾⠄⠄⣿⣿⠄⠄⡇⠄⠄⠇⢀⠄⠄⠄⠄⠄⠄⠄⠄⠉⢡⠿⣿⡁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀
	⢐⢈⢀⣠⠄⠄⣤⠄⣤⣤⣶⣿⡿⡼⠁⠄⠄⠄⠙⠻⠛⠁⠄⠄⣦⣡⠆⠄⣿⣿⠄⠄⠁⠄⢰⣠⠞⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⠄⢹⡇⠄⠄⠄⠄⠄⠄⠄⢀⡀⠄⠄⢸
	⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠄⠃⠄⠄⡐⠒⠂⠄⠐⠒⠄⠴⠞⠛⠓⠒⢿⣿⠄⠄⡶⠄⠄⠄⠐⠒⠒⠒⠄⠠⠤⠤⢄⣀⠆⠄⠸⡇⢀⣤⣶⣦⡆⠄⠄⣿⡏⠄⠄⢸
	⣸⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠄⠄⣿⣿⡿⢧⣀⣀⣀⣀⡀⠄⠄⠄⠄⠄⠄⢀⡟⠄⠄⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠻⣷⡶⠚⢁⣾⣿⣿⣿⡗⢀⣴⣽⣿⠄⠄⢸
	⣿⣿⣿⣿⣿⣿⣿⣿⣾⠄⠄⣤⣾⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠄⠄⣿⣿⣿⣿⣿⣶⣾⣷⣶⣶⣶⣶⣶⡇⣿⡧⣰⣿⣿⣿⣿⠏⠁⠄⣿⣿⣿⡇⠄⣾
	⠄⠈⠉⠉⠉⠁⠄⠄⠄⠄⠘⠛⠛⠛⠛⣧⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣇⡉⠄⠄⠄⣽⣿⡿⠄⣠⣿
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡟⠹⣿⠟⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠿⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⡏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⠛⠃⠄⠉⠉
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⢠⡄⡟⠄⠸⢿⣿⣿⣿⣿⣿⣿⣇⠄⠄⠄⠄⠄⠄⠄⠿⣿⣿⣿⣿⣿⡇⠄⠄⡟⢀⠱⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⣎⣷⡅⠄⠄⠄⠄⢸⠁⡉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⠉⠋⠄⠄⠄⠄⣇⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢿⣌⠄⠄⠄⠄⠄⠠⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⠤⠄⠄⠄⠄⠄⢸⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠄⠄⠄⠄⠄⠸⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠄⠄⠄⠄⠄⠄⠄⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⡀⠄⢀⣀⠄⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⢀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⣿⣯⣿⣶⣿⣿⣶⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⣾⣷⣼⣿⣆⣤⡶⠶⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
	⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢿⣿⣿⡿⠿⢿⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⣿⣿⣿⣿⣿⣿⣿⣾⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄ */
