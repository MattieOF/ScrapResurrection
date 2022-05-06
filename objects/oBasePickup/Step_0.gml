/// @description Unhighlight if needed

if (!active) return;

if (sprite.layer == global.highlightedPickupsLayer && !highlighted)
	sprite.layer = global.pickupsLayer;

highlighted = false;

