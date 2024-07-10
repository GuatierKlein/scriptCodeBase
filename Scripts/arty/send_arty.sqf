//serverside
_id = _this select 0;

artillery_pieces_array = [arty];
artillery_pieces_array_client = artillery_pieces_array;



{
	group _x setGroupOwner _id;
} foreach artillery_pieces_array;

_id publicVariableClient "artillery_pieces_array_client";
