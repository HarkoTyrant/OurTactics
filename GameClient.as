import mx.transitions.Tween;

/* game_client es una función que sirve para la comunicación 
** cliente_rapido.swf y el juego. Contempla los casos "init" y "start" **
** que serán llamados desde cliente_rapido en el momento oportuno      */

//devuelve el índice dentro del array de jugadores en funcion de la id del jugador
function getPlayerIndexByID(userId) {
	for(var i=0; i < game.playerIDS.length; i++) {
		if (userId == game.playerIDS[i]){
			return i;
		}
	}
	return -1;
}

function game_client (action, resObj) {
	switch (action){
		
		//El caso init se llama cuando el primer fotograma del juego ha sido cargado
		//lo habitual es esconder todos los elementos visuales 
		case "init":
			
			//obtenemos el array de frases del juego para un idioma (_root se referirá al cliente no al juego)
			//puede ser un array simple o un array asociativo ej: trace(lang.jugar) --> "Jugar" o "Play"...
			//langArray=_root.getLang();
			lang=_root.getLang();
			
			//escondemos todos los elementos visuales
			windowManager("all", "hide");
			
			//mostraríamos la portada del juego esperaríamos a que el cliente_rapido.swf llamara a la 
			//funcion windowManager("waiting_room","show") (VER CAPA WindowManager)
			
			//TEST LOCAL SI QUEREMOS CARGAR EL JUEGO EN MODO STAND ALONE PARA TESTEAR EL MOTOR POR EJ
			//windowManager("training","show");
			break;
		
		case "start":
			//SI el juego tiene datos propios para cada usuario la extensión del juego (código del servidor)
			//puede devolver los datos de todos los usuarios en params
			//ej: resObj.gamedata0...
			_root.debug("Recibida señal inicio partida.",2);
			windowManager("all", "hide");

			//AQUI EMPEZARIA EL JUEGO (VISUALIZAR ELEMENTOS DEL JUEGO E INICIAR PARTIDA)
			gotoAndStop(2);
			IniVariables();
			carga_units();
			
			var myId=_root.smartfox.myUserId;
			_global.game.numPlayers=resObj.numPlayers;
			_global.game.playerIDS=resObj.playerIDS;
			_root.debug("myId:"+myId+"pIndex:"+getPlayerIndexByID(myId));
			_global.jugador.indice=getPlayerIndexByID(myId);
			_global.jugador.nombre=playerNames[_global.jugador.indice];
			_global.game.jugadores=resObj.playerNames;
			_global.game.j_activos=resObj.j_activos;
			_global.game.j_turnos=resObj.j_turnos;
			_global.jugador.turno=_global.game.j_turnos[_global.jugador.indice];
			_root.debug(resObj.playerNames+" - myId:"+myId+",JUGADOR.TURNO:"+_global.jugador.indice+",Name:"+resObj.playerNames[_global.jugador.indice]+",nombres:"+_global.game.jugadores,2); //Nombres de usuarios.
			
			_global.game.avatares=resObj.avatardatas;
			_global.game.turno=resObj.turno;
			_global.game.indice=resObj.turno;
			
			Ejercito._visible=true;
			Ejercito.alm.sel=false;
			Ejercito.bre.sel=false;
			Ejercito.bar.sel=false;
			Ejercito.gal.sel=false;
			Ejercito.avatar_alm._visible=false;
			Ejercito.avatar_bre._visible=false;
			Ejercito.avatar_bar._visible=false;
			Ejercito.avatar_gal._visible=false;
			
			_root.debug("PLAYERIDS:"+game.playerIDS+",length:"+game.playerIDS.length);
			_root.debug("AVATARES:"+game.avatares+",lenght:"+game.avatares.length);
			var name;
			var ind=-1;
			for(var n=0;n<4;n++){
				var pID=game.playerIDS[n];
				ind=getPlayerIndexByID(pID);
				name="player"+(n+1);
				_root.debug("pID:"+pID+",name:"+name+",ind:"+ind);
				if(pID>=0){
					Partida[name]._visible=true;
					showAvatar(Partida[name],_global.game.avatares[n]);
					//showAvatar(name,game.avatares[pID]);
				}else{
					Partida[name]._visible=false;
				}
				_root.debug("name:"+name+", visible:"+Partida[name]._visible);
			}
			
			var myTwDead:Tween = new Tween(this.Presentacion, "_alpha", None, 100, 0, 1, true);
			myTwDead.onMotionFinished = function(){
				this.Presentacion._visible=false;
				this.Presentacion._alpha=100;
				iniSelEjer(); 
			}

			//Por ejemplo mostramos un chat
			//chat_mc._visible=true;
			//initGameChat();
			break;
		case "stop":
			//se llama cuando el jugador sale del juego y vuelve al lobby
			//Hay que parar cualquier evento existente del tipo setInterval, onEnterFrame, keylisteners...
			//y esconder todo menos la portada
			_root.debug("FIN DE PARTIDA",1);
			windowManager("all","hide");
			LimpiaPartida();
			break;
		default:
			break;
	}
}
