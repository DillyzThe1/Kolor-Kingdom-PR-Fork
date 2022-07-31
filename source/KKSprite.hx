package;

import LazyPathStuff;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class KKSprite extends FlxSprite
{
	public var animOffsets:Map<String, FlxPoint> = new Map<String, FlxPoint>(); // this thing right here is taken from ccsprite

	override public function new(x:Float, y:Float, image:String, animated:Bool = false, subfolder:String = "")
	{
		super(x, y);

		this.antialiasing = true;

		if (animated)
			this.frames = LazyPathStuff.getXml(image, subfolder);
		else
			this.loadGraphic(LazyPathStuff.imagePath(image, subfolder));
	}

	public function addAnim(name:String, prefix:String, offset:FlxPoint, ?fps:Int = 24, ?loop:Bool = false, ?flipX:Bool = false, ?flipY:Bool = false)
	{
		this.animation.addByPrefix(name, prefix, fps, loop, flipX, flipY);
		animOffsets.set(name, offset);
	}

	public function playAnim(name:String, force:Bool = false, reverse:Bool = false, frame:Int = 0)
	{
		this.animation.play(name, force, reverse, frame);

		if (animOffsets.exists(name)) // this thing right here is also taken from ccsprite
		{
			var off = animOffsets.get(name);
			offset.set(off.x, off.y);
		}
		else
			offset.set(0, 0);
	}
}
