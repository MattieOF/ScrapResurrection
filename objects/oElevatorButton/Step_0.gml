/// @description Check for layers

if (sprite.layer == global.highlightedUsablesLayer && (!highlighted || !active))
	sprite.layer = global.usablesLayer;
	
if (!active) return;

highlighted = false;

