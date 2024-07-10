private _camera = "camera" camCreate [0, 0, 0];
_camera camPrepareTarget player;
_camera camCommitPrepared 0; // needed for relative position
_camera camPrepareRelPos [0, 0, 500];
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;
waitUntil { camCommitted _camera };

_camera camPrepareRelPos [0, 0, 4];
_camera camCommitPrepared 5;

waitUntil { camCommitted _camera };
titleCut ["", "BLACK", 1];

sleep 2;
[worldName, mapGridPosition player, str(date select 1) + "." + str(date select 2) + "." + str(date select 0)] spawn BIS_fnc_infoText;
"dynamicBlur" ppEffectEnable true;   
"dynamicBlur" ppEffectAdjust [6];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 5;  

titleCut ["", "BLACK IN", 5];

_camera cameraEffect ["terminate", "back"];
camDestroy _camera;








