
//esta variable es siempre a true NO TOCAR
var orphan=true; 

//La variable "lang" es array que contiene todas los textos 
//que salen en el juego para el idioma elegido. 
var lang=["texto1","texto2"];  

if (_root.orphan){
    windowManager("all", "hide");
}else{
	game_client("init");
}

//-------------------- VARIABLES GLOBALES ------------------------------//

_global.lang;

var mouseListener:Object = new Object();

_global.mapa;/* =[[1,1,1,1,1,1,1,1,1,1,1,1],
					 [1,1,1,1,1,1,1,1,1,1,1,1],
					 [1,1,1,3,1,2,2,2,1,3,3,1],
					 [1,1,1,3,1,2,2,2,1,3,3,1],
					 [1,1,1,1,1,1,1,1,1,3,3,1],
					 [1,1,1,1,4,4,4,4,4,1,1,1],
					 [1,1,1,1,4,4,4,4,4,1,1,1],
					 [1,1,1,1,1,1,1,1,1,1,1,1],
					 [1,1,1,2,1,3,3,1,2,2,1,1],
					 [2,1,1,2,1,3,3,1,2,2,1,1],
					 [2,1,1,1,1,1,1,1,1,1,1,1],
					 [2,1,1,1,1,1,1,1,1,1,1,1]];*/

_global.mapaRangos;/* =[[0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0]];*/

_global.RangoTiros;/* =[[0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0],
								 [0,0,0,0,0,0,0,0,0,0,0,0]];*/

var rank:Array;//=[[0,-1],[1,0],[0,1],[-1,0],[0,0]];

var estados:Array;//=["idle","walk","hit","dead"];
var direcciones:Array;//=["Norte","Este","Sur","Oeste"];
//var direcciones:Array=["Este","Oeste","Sur","Norte"];//Reordenadas para mejor colocacion
var tipounit:Array;//=["cap","inf","arc","cab","dra","tor"]
var ejercitos:Array;//=["alm","bar","bre","gal"];

var areadespliegue:Array;/*=[[[0,1],[0,10]],
												 [[11,1],[11,10]],
												 [[1,0],[10,0]],
												 [[1,11],[10,11]]];*/

var despliegueAd:Array;/*=[[[1,4],[1,7]],
											 [[10,4],[10,7]],
											 [[4,1],[7,1]],
											 [[4,10],[7,10]]];*/

var areamuros:Array;/*=[[[0,0],[3,11]],
										 [[8,0],[11,11]],
										 [[0,0],[11,3]],
										 [[0,8],[11,11]]];*/

_global.game={};
	_global.game.turno;
	_global.game.depth;
	_global.game.path;
	_global.game.sepx;
	_global.game.sepy;
	//game.sepx=0;
	//game.sepy=0;
	_global.game.anchot;
	_global.game.altot;
	_global.game.unisel;
	_global.game.cantunits;
	_global.game.totalpuntos;
	//game.colocaunits=false;
	_global.game.colocaunits;
	_global.game.colocamuros;
	_global.game.nMuros;
	_global.game.ejercito_sel;//=ejercitos[2];
	_global.game.indice;
	_global.game.num_ejercitos;
	_global.game.ejercitos_sel;
	_global.game.ejercito=null;
	_global.game.unidades;
	_global.game.juegoInicializado;
	_global.game.partidaReal;
	_global.game.numPlayers;
	_global.game.playerIDS;
	_global.game.j_activos;
	_global.game.j_turnos;
	_global.game.nPlyActivos;
	_global.game.ejEliminado;
	_global.game.playerEliminado;
	_global.game.avatares;
	_global.game.pausa;
	
_global.tipo_units={};

_global.units={};
	_global.units.maxunits;
	_global.units.select;

_global.jugador={};
	_global.jugador.turno;
	_global.jugador.indice;
	_global.jugador.ejercito;
	_global.jugador.num_ejercito;
	_global.jugador.nombre;
	_global.jugador.activo;













