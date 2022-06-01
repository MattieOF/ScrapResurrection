/// @description Check for layers

if (sprite.layer == global.highlightedUsablesLayer && (!highlighted || !active))
	sprite.layer = global.usablesLayer;
	
sprite.x = x;
sprite.y = y;
	
if (!active) return;

highlighted = false;

