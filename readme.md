# Scripts du BAR

## Prérequis

ACE

## Documentation

!!! Tous les scripts necessite le dossier GUI.
Le script radio necessite le dossier Sounds.

### Kit_select

Dans initPlayerLocal.sqf mettez :
```
#include "scripts\kit_select\core.sqf";
```

Dans votre onPlayerRespawn.sqf mettez :
```
call BAR_fnc_applyKit;

if(!isNil "BAR_enableCustomKitOnRespawn") then {
	if(BAR_enableCustomKitOnRespawn) then {
		player setUnitLoadout BAR_customKit;
	};
};
```

Creer un marker GDGM_camKit pour positionner la camera. Elle sera toujours orientée vers le Nord.

Faites vos mannequins dans l'éditeur puis remplissez Scripts/kit_select/open_kitSelectMenu.sqf
Pour rendre un mannequin médecin, mettez dans l'init du mannequin :

```
available_kits = [
	kit_ne,
	kit_rifle,
	kit_medic,
	kit_eng,
	kit_radio
]; //mettre ici les noms des mannequins, laissez kit_ne pour le kit sans equipement car il 
//est referencé à d'autre endroit dans le code et causera des erreurs d'initalisation de variable si supprimé

_available_kits_name = [
	"Sans équipement",
	"Fusilier",
	"Medic",
	"Sapeur",
	"Radio (menu arty)"
]; //ici les noms d'affichages dans la liste (même ordre que les mannequins)
```

```
this setVariable ["GDGM_isMedic", true];
```

Pour rendre un mannequin ingénieur, mettez dans l'init du mannequin :
```
this setVariable ["GDGM_isEng", true];
```

Pensez à définir au moin kit_ne, qui est obligatoire pour le fonctionnement du script.
Le script addPilot necessite aussi un mannequin kit_crew pour fonctionner.

Dans l'init de l'objet ou vous voulez les actions entrez :

```
[this] execVM "scripts\kit_select\kitSelectAction.sqf";
[this] execVM "scripts\kit_select\customKitAction.sqf"; 
```

Enfin vous pouvez régler un paramètre dans Scripts/kit_select/core.sqf :
```
BAR_enableCustomKitOnRespawn = false; 
//true = le kit sauvegardé à l'arsenal sera automatiquement appliqué au respawn en plus de la spécialisation du mannequin choisit
//false = le kit du mannequin et la spécialisation sera appliqué au respawn sans le kit sauvegardé à l'arsenal
```


### TP

Dans l'init de l'objet ou vous voulez les actions entrez :

```
[this] execVM "scripts\tp\tp_action.sqf"; 
```

Dans Scripts/tp/open_tp.sqf vous voulez régler un paramètre :
```
GDGM_allowTPNearEnnemies = false; // true -> on peut se tp si des ennemis sont proches du joueur cible
```

### Arty

Dans initPlayerLocal.sqf mettez :
```
#include "scripts\arty\core.sqf";
```

Dans votre onPlayerRespawn.sqf mettez :
```
player addAction
[
	"<t color='#0044c2'>Arty menu</t>",	// title
	{
		execVM "scripts\arty\arty_openmenu.sqf";
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"backpack player == 'B_radioBag_01_mtp_F'", 	// condition, remplacez par le sac de votre choix
	5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];
```

### Add_pilot

Dans Scripts/addPilot/addPilot.sqf
paramètrez _kit_used et _baseUnit si vous en avez besoin
```
//mannequin pour l'équipement du pilot
_kit_used = kit_crew;
//classname du pilote !!! dépend du camp des joueur
_baseUnit = "B_Soldier_F";
```

Dans l'init de l'objet ou vous voulez les actions entrez :
```
[this] execVM "scripts\addPilot\addPilotAction.sqf"
```

### Tracker

#### Que fait ce script?

Ce script est inspiré des trackers du DLC vietnam
Il spawn dynamiquement des trackers qui traquent les joueurs dans un déclencheur 
Le script fonctionne comme un graphe, il grimpe d'état en état jusqu'a atteindre l'état maximum
Un état représente la statut d'alerte des ennemis, plus l'état est haut, plus la force ennemie sera grande 
Un augmente d'un état dès qu'un groupe de tracker localise un joueur (un groupe ne peut faire monter l'état qu'une fois)

#### Instrutions

creer un déclencheur et le remplir ainsi

on act
```
[thisTrigger,spawn cap,maxstate,usecar,usebuilding,sentriesaroundplayer] spawn GDGM_fnc_initTrackerTrigger;
```
exemple : 
```
[thisTrigger,100,10,true,true,false] spawn GDGM_fnc_initTrackerTrigger;
```

deact
``` 
[thisTrigger] spawn GDGM_fnc_masterClean;
```

le script se lancera quand le déclencheur s'activera, et trackera les joueur DANS le déclencheur
il est préférable que le déclencheur soit un cercle, et entre 400 et 1000m de diamètre
A vous de tester tout les paramètres pour trouver les réglages qui vous conviennent

#### Les paramètres du script :

thisTrigger : ne pas modifier 

spawn cap : nombre maximum de tracker qui peut spawn, NE PAS UTILISER POUR GERER LA DIFFICULTE, ceci sert uniquement pour les performance, idéalement, laisser à 100

maxstate : état maximum que peut atteindre le script, plus la valeur est grande, plus le script enverra de reserve sur vous, une valeur plus petite rend le script plus facile

	exemple : 5 = facile, 10 = moyen plus, 15 = difficile
usecar : 

	true : les tracker utiliseront des véhicules

	false : pas de véhicules

useBuilding : 

	true : les tracker utiliseront les batiment pour cacher leur spawn (à n'utiliser que dans les grande ville avec bcp de batiment ouverts et avec des positions préconfigurées)

	false : les tracker spawneront de manière normale sans se soucier des batiments 

sentriesaroundplayer : 

	true : le spawn des sentinelles de départ (état 0) se fait autour du joueur

	false : le spawn des sentinelles de départ (état 0) se fait autour du déclencheur


### Music
à venir