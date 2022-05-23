/// @description Activate
var inst = instance_create_layer(position.x, position.y, layer, object);
inst.image_xscale = xscale;
inst.image_yscale = yscale;
inst.image_angle  = angle;

if (onTriggerExt != undefined)
	onTriggerExt(inst);

instance_destroy(id);

