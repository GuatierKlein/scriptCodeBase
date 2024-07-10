/*
Que fait ce script?
Joue une playlist prédéfinie de manière alétoire durant la mission
*/
//executez avec if(isServer) then {execVM "scripts\music.sqf"};
//pour arreter la musique, mettre music = false dans un déclencheur ou un script côté server
//pour arreter la music sans attendre la fin du morceau -> "" remoteExec["playmusic",0]; hors d'un déclencheur et playMusic ""; dans un déclencheur
music = true;

while {music} do {	
	//liste de classname de musique (à trouver outils/utilitaire/jukebox dans l'éditeur)
	//à modifier à votre guise
	private _music_list = [
		"Music_Probe_Discovered",
		"Music_Roaming_Night",
		"Music_Freeroam_02_MissionStart",
		"Music_Roaming_Night_Fragment_01_20s",
		"Music_Roaming_Night_Fragment_01_60s",
		"AmbientTrack01a_F_Tacops",
		"AmbientTrack01b_F_Tacops",
		"AmbientTrack02b_F_Tacops",
		"AmbientTrack03a_F_Tacops",
		"AmbientTrack01_F_Orange",
		"AmbientTrack01_F_EPB",
		"EventTrack03_F_EPB",
		"EventTrack01_F_EPB",
		"EventTrack01_F_EPC"
	];

	while {count _music_list != 0 && music} do {
		music_played = false;
		private _music = selectRandom _music_list;
		_music remoteExec["playmusic",0];
		systemChat ("Playing : " + _music); //seulement affiché en solo
		addMusicEventHandler ["MusicStop", { music_played = true}];
		_music_list = _music_list - [_music];
		waitUntil { music_played };

		sleep (300 + random 720); //temps en seconde avant la prochaine musique
	};
};