/// @description Unhighlight if needed

if (!active) return;

if (sprite.layer == global.highlightedUsablesLayer && !highlighted)
	sprite.layer = global.usablesLayer;

highlighted = false;

