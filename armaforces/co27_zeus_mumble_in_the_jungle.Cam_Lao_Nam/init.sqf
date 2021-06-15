#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 2000;


vet_fnc_preventDestruction = {
    params ["_vehicle"];

    _vehicle addEventHandler ["HandleDamage", {
        // wrap in call so exitWith won't break whole HandleDamage EH chain
        call {
            params ["_object", "", "_damage", "", "_ammo", "", "", "_hitPoint"];

            if (_hitPoint in ["hitengine", "hitbody"]) exitWith {
                _damage
            };

            _damage min 0.8// return
        };
    }];

};

vet_fnc_fobBlu82 = {
    ["vn_c130_flyover_sound"] remoteExecCall ["playSound", 0];

    ([markerPos "fob", 900] call vn_fnc_bomb_blu82) params ["_bomb"];

    [{isNull _this}, {
        private _trees = nearestTerrainObjects [markerPos "fob", ["Tree"], 53];
        {_x hideObjectGlobal true} forEach _trees;
    }, _bomb] call CBA_fnc_waitUntilAndExecute;
};

vet_fnc_ambushSurvived = {
    params ["_ambushEnemies"];

    [buildspawn_east, buildspawn_south] findIf {_x getVariable "tickets" > 0} == -1 && {count _ambushEnemies < 5}
};

vet_fnc_suppliesUnloaded = {
    private _supplies = getMissionLayerEntities "FOB Supplies" select 0;

    {isNull attachedTo _x} count (_supplies inAreaArray ambushArea) >= 5
};

// prevent destruction of boats
{_x call vet_fnc_preventDestruction} forEach [nasty1, nasty2];

// auto carry items unloaded from boats
["ace_unloadCargo", {
    params ["_item", "_vehicle", ["_unloader", objNull]];
    if (isNull _unloader || {!(_vehicle isKindOf "Ship")}) exitWith {};
    // we can't support virtual items
    if (_item isEqualType "") exitWith {};

    [{
        params ["_item", "", "_unloader"];
        // unloading failed
        if (!isNull attachedTo _item) exitWith {};

        [ACE_player, _item] call ace_dragging_fnc_carryObject;
    }, _this] call CBA_fnc_execNextFrame;

}] call CBA_fnc_addEventHandler;

// inform server about explosive detonations
[{
    ["explosiveDetonated", _this] call CBA_fnc_serverEvent;

    true // allow explosion
}] call ace_explosives_fnc_addDetonateHandler;
