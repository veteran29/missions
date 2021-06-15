#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};


// {
//     [_x, ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1], getMarkerPos "fob", 0, 0, 0, "FOB", 2, 0.05], false, true] call BIS_fnc_addCuratorIcon
// } forEach allCurators;

[] call vn_ms_fnc_persistentPlayerGroups;

["UnloadSuppliesDone", {
    [] call vet_fnc_fobBlu82;
}] call CBA_fnc_addEventHandler;

["BuildFobDone", {
    "fob" setMarkerAlpha 1;
}] call CBA_fnc_addEventHandler;

// start fob attack after it starts building
suppliesDelivered = 0;
["afmf_buildables_delivered", {
    suppliesDelivered = suppliesDelivered + 1;
    if (suppliesDelivered < 5) exitWith {};

    fobAttack = true;
}] call CBA_fnc_addEventHandler;

// load crates into boats and make them carryable
{
    [_x, 1] call ace_cargo_fnc_setSize;
    [_x, selectRandom [nasty1, nasty2], true] call ace_cargo_fnc_loadItem;

    [_x, true, [0, 1, 1], 0] remoteExecCall ["ace_dragging_fnc_setCarryable", 0, true];
} forEach (getMissionLayerEntities "FOB Supplies" select 0);

// detect explosives in NVA armory
armoryDestroyed = false;
["explosiveDetonated", {
    params ["", "", "_explosive"];

    if (!(_explosive inArea tunnelArmory) || {armoryDestroyed}) exitWith {};
    armoryDestroyed = true;

    {_x setDamage 1} forEach (getMissionLayerEntities "tunnel_armory" select 0);

    // more boom booms, it's exploding armory after all
    for "_i" from 0 to 6 do {
        [{
            private _m = "vn_mine_satchel_remote_02_ammo_scripted" createVehicle getPos tunnelArmory;
            _m setDamage 1;
        }, nil, 1 + 1.3*_i] call CBA_fnc_waitAndExecute;
    };

    true // allow explosion
}] call CBA_fnc_addEventHandler;

#include "test.sqf"
