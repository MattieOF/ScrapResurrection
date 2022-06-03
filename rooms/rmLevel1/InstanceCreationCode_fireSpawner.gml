/// @description Set fire as levers target, init fire
onTriggerExt = function(inst)
{
	fireLever.target = inst;
	inst.calc_points();
}

