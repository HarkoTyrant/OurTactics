import mx.transitions.Tween;

//Esta función evalúa las acciones enviadas desde la extensión (código del servidor)
//en el servidor se enviaría un objeto con un parámetro resObj._cmd que identificaría la acción
function evaluateXtResponse(resObj:Object,protocol:String) {
	if(protocol=="str") var cmd=resObj[0];
	else var cmd=resObj._cmd;
	//_root.debug("GAME: evaluateXtResponse cmd="+cmd+" protocol="+protocol);
	switch(cmd){
		case "SelEjCambioTurno":
			//Cambiamos turno de seleccion de ejercito y actualizamos selecciones.
			_root.debug("Cambiamos turno");
			game.turno=resObj.turno;
			for(var t=0;t<_global.game.j_turnos.length;t++){
				if(_global.game.j_turnos[t]==game.turno){
					game.indice=t;
				}
			}
			var ej=resObj.ejSeleccionado;
			var name="sel_"+ej;
			_root.debug("Turno:"+game.turno+",Indice:"+game.indice+", j_turnos:"+_global.game.j_turnos);
			//_root.debug("Nom:"+game.jugadores[game.indice]+",Text:"+name);
			if(resObj.indJugador!=-1){
				Ejercito[name].text=game.jugadores[resObj.indJugador];
				Ejercito[ej].sel=true;
				//var avatar_name="avatar_"+ej;
				//_root.debug("avatar Name:"+avatar_name+",Ej:"+ej);
				//Ejercito[avatar_name]._visible=true;
				//showAvatar(Ejercito[avatar_name],game.avatares[game.indice]);
			}
			iniSelEjer();
			break;

		case "ReclutarEjercito":
			game.turno=resObj.turno;
			game.indice=resObj.indJugador;
			var ej=resObj.ejSeleccionado;
			var name="sel_"+ej;
			//_root.debug("Turno:"+game.turno+",Indice:"+game.indice);
			//_root.debug("Nom:"+game.jugadores[game.indice]+",Text:"+name);
			Ejercito[name].text=game.jugadores[game.indice];
			Ejercito[ej].sel=true;
			var avatar_name="avatar_"+ej;
			//_root.debug("avatar Name:"+avatar_name+",Ej:"+ej);
			//Ejercito[avatar_name]._visible=true;
			//showAvatar(Ejercito[avatar_name],game.avatares[game.indice]);
			
			_root.debug("Inicio reclutamiento");
			this.Reclutar._visible=true;
			cargaReclutar();
			var myTwDead:Tween = new Tween(_root.game_mc.Ejercito, "_alpha", None, 100, 0, 1, true);
			myTwDead.onMotionFinished = function(){
				Ejercito._visible=false;
				Ejercito._alpha=100;
				iniReclutar();
			}
			break;
			
		/*case "EsperaRec":
			_root.debug("Esperamos fin de reclutamiento");
			//Ejercito._visible=false;
			//iniReclutar();
			break;*/
			
		case "InicioPartida":
			_root.debug("Pasamos al tablero");
			if(Reclutar._visible==true){
				var myTwDead:Tween = new Tween(_root.game_mc.Reclutar, "_alpha", None, 100, 0, 1, true);
				myTwDead.onMotionFinished = function(){
					windowManager("espera","hide");
					Reclutar._visible=false;
					Reclutar._alpha=100;
				}
			}
			game.turno=resObj.turno;
			for(var t=0;t<_global.game.j_turnos.length;t++){
				if(_global.game.j_turnos[t]==game.turno){
					game.indice=t;
				}
			}
			game.num_ejercitos=resObj.num_ejercito;
			game.ejercitos_sel=resObj.ejSeleccionados;
			game.unidades=resObj.unidades;
			//_root.debug("unidades:"+game.unidades);
			Partida.v_espera.swapDepths(490000);
			Partida.v_espera.b_continuar._visible=false;
			Partida.v_espera.b_continuar.nombre.text=lang["Continuar"];
			//.text="Continuar";
			Partida.v_espera.b_salir._visible=false;
			Partida.v_espera.b_salir.nombre.text=lang["Salir"];
			//.text="Salir";
			
			if(	game.juegoInicializado==false){
				mapa=resObj.mapa;
				iniPartida();
			}
			_root.debug("jugind:"+jugador.indice+", gamind:"+game.indice);
			if(jugador.indice==game.indice){
				_root.debug("Iniciamos despliegue");
				Partida.v_espera._visible=false;
				game.colocaunits=true;
				game.colocamuros=true;
				Despliegue();
			}else{
				_root.debug("Colocamos cartel");
				Partida.unit_actual._visible=false;
				Partida.v_espera._visible=true;
				Partida.v_espera.texto.text=lang["Despliega_jugr"]+game.jugadores[game.indice];
				//.text="Despliega jugador "+game.jugadores[game.indice];
			}
			break;
			
		case "ColocaUnidad":
			//Recibimos unidad colocada por otro jugador.
			if(jugador.turno!=resObj.jugador){
				//_root.debug("Colocamos unidad "+resObj.uniName+" de jugador "+resObj.jugador);
				plantarUnidad(resObj.uniName,resObj.posX,resObj.posY,resObj.dir);
			}
			break;

		case "ColocaMuro":
			//Recibimos muro colocado.
			var turnoJug=resObj.jugador;
			if(jugador.indice!=turnoJug){
				var posX=resObj.posX;
				var posY=resObj.posY;
				var nametile=resObj.tile;
				_root.debug("NJug:"+turnoJug+",NEj:"+game.num_ejercitos[turnoJug]+",EjS:"+game.ejercitos_sel[turnoJug]);
				game[nametile].Tiled.gotoAndStop(5+game.num_ejercitos[turnoJug]);
				game[nametile].type="Muro";
				//game[nametile].ejercito=game.ejercito_sel;
				game[nametile].ejercito=game.ejercitos_sel[turnoJug];
				//mapaRangos[posX][posY]=0;
				//mapa[posY][posX]=5+game.num_ejercitos[turnoJug];
				
				//acualizaRango();
			}
			break;
			
		case "ComienzaJuego":
			//Inicio de la partida.
			game.turno=resObj.turno;
			for(var t=0;t<_global.game.j_turnos.length;t++){
				if(_global.game.j_turnos[t]==game.turno){
					game.indice=t;
				}
			}
			game.partidaReal=resObj.partidaReal;
			_root.debug("Empieza la partida. J_activo:"+game.j_activos[jugador.indice]+",partidaReal:"+game.partidaReal);
			_global.game.pausa=false;
			_root.debug("j_activos:"+game.j_activos+",plyActiv:"+game.nPlyActivos);
			_root.debug("jugador.turno:"+jugador.turno+", game.turno:"+game.turno);
			if(jugador.turno==game.turno){
				_root.debug("Jugadores Activos:"+game.nPlyActivos);
				if(game.nPlyActivos==1){
					_global.game.pausa=true;
					Partida.v_espera._visible=true;
					Partida.v_espera.texto.text=lang["Player_Win"];
					//.text="Has ganado";
					
					var resObj={};
					resObj.winnerID=_root.smartfox.myUserId;
						
					_root.sendXtMsg ("endGame", resObj);
					
					game.turno=-1;
				}else{
					//ActivaUnidades(true);
					Partida.v_espera._visible=false;
					IniJuego();
				}
			}else if(jugador.turno!=game.turno && game.j_activos[jugador.indice]==1){
				_global.game.pausa=true;
				Partida.v_espera._visible=true;
				Partida.v_espera.texto.text=lang["Turno_jug"]+game.jugadores[game.indice];
				//.text="Turno jugador "+game.jugadores[game.indice];
				mouseListener.onMouseDown = null;
				//ActivaUnidades(false);
			}else if(jugador.turno!=game.turno && game.j_activos[jugador.indice]==0){
				_global.game.pausa=true;
				_root.debug("jugador eliminado.");
				Partida.v_espera._visible=true;
				Partida.v_espera.texto.text=lang["Player_Lost"];
				//.text="Estas eliminado";
				game.turno=-1;
			}
			break;
			
		case "AccionUnit":
			_root.debug("Recibimos accion "+resObj.accion+" de unidad:"+resObj.unitName);
			var turno=resObj.jugIndex;
			if(jugador.turno!=turno){
				switch(resObj.accion){
					case "Mover":
						var path:Array=resObj.path;
						//SeparaOcultos(units.select,units[units.select].tilex,units[units.select].tiley);
						var tilefin="tile"+path[0][0]+"_"+path[0][1];
						if(path.length==1){
							if(units[resObj.unitName].tipounit==tipounit[1]){
								//CompruebaInfanteriaOculta(resObj.unitName,units[resObj.unitName].tilex,units[resObj.unitName].tiley,path[0][0],path[0][1]);
							}
							/*var descubre=DescubreUnidad(units.select,path[0][0],path[0][1],0);
							trace("ResultadoDesc:"+descubre);
							if(units[resObj.unitName].ejercito==jugador.ejercito){
								trace("UnitN:"+resObj.unitName+",path00:"+path[0][0]+",path01:"+path[0][1]);
								CompruebaOcultos(resObj.unitName,path[0][0],path[0][1]);
								if(units[resObj.unitName].tipounit==tipounit[1] && game[tilefin].type=="Bosque"){
									if(descubre==true){
										DescubreInfanteria(resObj.unitName);
									}else{
										OcultaInfanteria(resObj.unitName);
									}
								}
							}
							if(units[resObj.unitName].tipounit==tipounit[1] && game[tilefin].type=="Bosque"){
								if(descubre==true){
									DescubreInfanteria(resObj.unitName);
								}else{
									OcultaInfanteria(resObj.unitName);
								}
							}*/
						}
						mueveUnit(resObj.unitName,path,units[resObj.unitName].tilex,units[resObj.unitName].tiley,path[0][0],path[0][1]);
						path=null;
						break;
					
					case "Atacar":
							if(units[resObj.unitName].tipounit!=tipounit[2]){
								var path:Array=resObj.path;
								//trace("pathA:"+path+",path_0:"+path[0]+",00:"+path[0][0]+",01:"+path[0][1]+",uselect:"+units.select);
								atacUnit(resObj.unitName,path,units[resObj.unitName].tilex,units[resObj.unitName].tiley,path[0][0],path[0][1]);
								//mueveUnit(units.select,path,units[units.select].tilex,units[units.select].tiley,path[0][0],path[0][1]);
								//units[units.select].tilex=x;
								//units[units.select].tiley=y;
								path=null;
							}else{
								_root.debug("Ataque disparo");
								disparaUnit(resObj.unitName,resObj.posX,resObj.posY);
							}
						break;
					
					default:
						_root.debug("No entiendo la accion "+resObj.accion);
						break;
				}
			}
			break;
		
		case "EjercitoEliminado":
			_root.debug("Eliminamos al ejercito "+resObj.ejercito+" sin capitan.");
			//_root.debug("NJugador:"+resObj.numPlayer+",JugActivos:"+resObj.j_activos);
			game.j_activos=resObj.j_activos;
			game.j_turnos=resObj.j_turnos;
			game.turno=resObj.turno;
			jugador.turno=game.j_turnos[jugador.indice];
			_root.debug("j_turnos:"+game.j_turnos+", j.ind:"+jugador.indice+", game.j_turnos[jugador.indice]:"+game.j_turnos[jugador.indice]+", jugador.turno:"+jugador.turno);
			game.nPlyActivos=CuentaJugActivos();
			game.ejEliminado=resObj.ejercito;
			game.playerEliminado=resObj.numPlayer;
			_global.game.numPlayers=resObj.numPlayers;
			var ind=_global.game.playerEliminado+1;
			var name="player"+ind;
			_root.debug("playerElim:"+game.playerEliminado+",name:"+name);
			Partida[name]._visible=false;
			//_root.debug("EjEliminado:"+game.ejEliminado+",playerElim:"+game.playerEliminado);
			//SuicidioColectivo(game.playerEliminado,game.ejEliminado);

			break;
			
		case "playerLeft":
			//Un jugador avandona la partida.
			_root.debug("Jugador "+resObj.uId+", index:"+getPlayerIndexByID(resObj.uId)+", nombre:"+game.jugadores[game.playerEliminado]+" abandona la partida. Numplayers:"+resObj.numPlayers+", playerIDS:"+resObj.playerIDS);
			var jugadorAbandona=resObj.uId;
			_global.game.playerEliminado=resObj.playerIndex;
			_global.game.numPlayers=resObj.numPlayers;
			_global.game.playerIDS=resObj.playerIDS;
			_global.game.j_turnos=resObj.j_turnos;
			_global.jugador.turno=_global.game.j_turnos[_global.jugador.indice];
			
			var ejercitoEliminado=resObj.ejercito;
			Ejercito[ejercitoEliminado].sel=false;
			var name="sel_"+ejercitoEliminado;
			Ejercito[name].text="";
			
			//Averiguamos cual es la pantalla activa.
			var posicion=null;
			if(Ejercito._visible==true){
				posicion="Ejercito";
			}else if(Reclutar._visible==true){
				posicion="Reclutar";
			}else if(Partida._visible==true){
				posicion="Partida";
			}
			
			if(_global.game.numPlayers<=1){
				//Se ha quedado solo
				if(game.partidaReal==true){
					//Ya se habia desplegado
					if(ejercitoEliminado!=null){
						SuicidioColectivo(game.playerEliminado,ejercitoEliminado,true);
					}
					//Mostramos ventana, solo salir
					//Al salir manda puntuacion
					mouseListener.onMouseMove = null;
					mouseListener.onMouseDown = null;
					this[posicion].v_espera.texto.text=lang["NoPlayer_Win"];
					//.text="Sin jugadores, has ganado.";
					this[posicion].v_espera._visible=true;
					this[posicion].v_espera.b_continuar._visible=false;
					this[posicion].v_espera.b_salir._visible=true;
					
					this[posicion].v_espera.b_salir.onPress = function(){
						var resObj={};
						resObj.winnerID=jugadorAbandona;
						
						_root.sendXtMsg ("endGame", resObj);
					
						_root.exitGame();
					}
					
				}else{
					//Mostramos ventana, solo salir
					//Al salir termina la partida.
					//_root.debug("Visibles. Ejercito:"+Ejercito.v_espera._visible+",Reclutar:"+Reclutar.v_espera._visible+",Partida:"+Partida.v_espera._visible);
					//_root.debug("Posicion:"+posicion);
					//var vis=this[posicion].v_espera._visible;
					//_root.debug("[posicion].v_espera._visible:"+vis);
					this.Ejercito.v_espera.texto.text=lang["NoPlayer_Lost"];
					//.text="Sin jugadores, partida anulada.";
					this.Reclutar.v_espera.texto.text=lang["NoPlayer_Lost"];
					//.text="Sin jugadores, partida anulada.";
					this.Partida.v_espera.texto.text=lang["NoPlayer_Lost"];
					//.text="Sin jugadores, partida anulada.";
					//this[posicion].v_espera.texto.text="Sin jugadores, partida anulada.";
					this.Ejercito.v_espera._visible=true;
					this.Reclutar.v_espera._visible=true;
					this.Partida.v_espera._visible=true;
					//this[posicion].v_espera._visible=true;
					this.Ejercito.v_espera.b_continuar._visible=false;
					this.Reclutar.v_espera.b_continuar._visible=false;
					this.Partida.v_espera.b_continuar._visible=false;
					//this[posicion].v_espera.b_continuar._visible=false;
					this.Ejercito.v_espera.b_salir._visible=true;
					this.Reclutar.v_espera.b_salir._visible=true;
					this.Partida.v_espera.b_salir._visible=true;
					//this[posicion].v_espera.b_salir._visible=true;
					
					//if(posicion=="Ejercito"){
						Ejercito.alm.enabled=false;
						Ejercito.bre.enabled=false;
						Ejercito.bar.enabled=false;
						Ejercito.gal.enabled=false;
					//}else if(posicion=="Reclutar"){
						this.Reclutar.v_espera.swapDepths(10000);
						this.Reclutar.derecha.enabled=false;
						this.Reclutar.izquierda.enabled=false;
						this.Reclutar.muestras.inf.enabled=false;
						this.Reclutar.muestras.arc.enabled=false;
						this.Reclutar.muestras.cab.enabled=false;
						this.Reclutar.muestras.dra.enabled=false;
						this.Reclutar.muestras.tor.enabled=false;
						this.Reclutar.reclutar_uni.enabled=false;
						this.Reclutar.despedir.enabled=false;
						this.Reclutar.finalizar.enabled=false;
					//}else{
						mouseListener.onMouseMove = null;
						mouseListener.onMouseDown = null;
					//}
					
					this[posicion].v_espera.b_salir.onPress = function(){
						_root.exitGame();
					}
					/*
					Reclutar.v_espera.b_salir.onPress = function(){
						_root.exitGame();
					}
					
					Partida.v_espera.b_salir.onPress = function(){
						_root.exitGame();
					}*/
				}
			}else{
				
				var ind=_global.game.playerEliminado+1
				var name="player"+ind;
				_root.debug("playerElim:"+_global.game.playerEliminado+",name:"+name);
				_root.debug("game.jugadores:"+game.jugadores+", playerEliminado:"+_global.game.playerEliminado);
				Partida[name]._visible=false;
				
				//Aun quedan jugadores.
				//Mostramos ventana, continuar o salir.
				//var vis=this[posicion].v_espera._visible;
				//_root.debug("[posicion].v_espera._visible:"+vis);
				/*this.Ejercito.v_espera.texto.text=game.jugadores[game.playerEliminado]+" a abandonado la partida.";
				this.Reclutar.v_espera.texto.text=game.jugadores[game.playerEliminado]+" a abandonado la partida.";
				this.Partida.v_espera.texto.text=game.jugadores[game.playerEliminado]+" a abandonado la partida.";*/
				this[posicion].v_espera.texto.text=game.jugadores[_global.game.playerEliminado]+lang["PlayerQuit"];
				//.text=game.jugadores[_global.game.playerEliminado]+" a abandonado la partida.";
				/*this.Ejercito.v_espera._visible=true;
				this.Reclutar.v_espera._visible=true;
				this.Partida.v_espera._visible=true;*/
				this[posicion].v_espera._visible=true;
				/*this.Ejercito.v_espera.b_continuar._visible=true;
				this.Reclutar.v_espera.b_continuar._visible=true;
				this.Partida.v_espera.b_continuar._visible=true;*/
				this[posicion].v_espera.b_continuar._visible=true;
				/*this.Ejercito.v_espera.b_salir._visible=true;
				this.Reclutar.v_espera.b_salir._visible=true;
				this.Partida.v_espera.b_salir._visible=true;*/
				this[posicion].v_espera.b_salir._visible=true;
				
				if(ejercitoEliminado!=null){
					SuicidioColectivo(game.playerEliminado,ejercitoEliminado,true);
					}
				
				if(posicion=="Ejercito"){
					Ejercito.alm.enabled=false;
					Ejercito.bre.enabled=false;
					Ejercito.bar.enabled=false;
					Ejercito.gal.enabled=false;
				}else if(posicion=="Reclutar"){
					this.Reclutar.v_espera.swapDepths(10000);
					this.Reclutar.derecha.enabled=false;
					this.Reclutar.izquierda.enabled=false;
					this.Reclutar.muestras.inf.enabled=false;
					this.Reclutar.muestras.arc.enabled=false;
					this.Reclutar.muestras.cab.enabled=false;
					this.Reclutar.muestras.dra.enabled=false;
					this.Reclutar.muestras.tor.enabled=false;
					this.Reclutar.reclutar_uni.enabled=false;
					this.Reclutar.despedir.enabled=false;
					this.Reclutar.finalizar.enabled=false;
				}else{
					_global.game.pausa=true;
					//mouseListener.onMouseMove = null;
					//mouseListener.onMouseDown = null;
				}
					
				this[posicion].v_espera.b_salir.onPress = function(){
					_root.exitGame();
				}
				
				this[posicion].v_espera.b_continuar.onPress = function(){
					
					var resObj={};
					//resObj.ejercito_sel=jugador.ejercito;
					//resObj.num_ejercito=jugador.num_ejercito;
					resObj.turn=jugador.turno;
					resObj.posicion=posicion;
					
					_root.sendXtMsg ("Continuar", resObj);
					
					this._parent.texto.text=lang["EsperaRespuesta"];
					//.text="Esperando respuesta";
					//Ejercito.v_espera._visible=false;
					//Reclutar.v_espera._visible=false;
					//Partida.v_espera._visible=false;
					//this._parent._visible=false;
					Ejercito.v_espera.b_continuar._visible=false;
					Reclutar.v_espera.b_continuar._visible=false;
					Partida.v_espera.b_continuar._visible=false;
					//this._visible=false;
					Ejercito.v_espera.b_salir._visible=false;
					Reclutar.v_espera.b_salir._visible=false;
					Partida.v_espera.b_salir._visible=false;
					//this._parent.b_salir._visible=false;
					
					/*if(game.partidaReal==false){
						movimientoRaton();
					}else{
						movimientoRaton();
						IniJuego();
					}*/
					//mouseListener.onMouseMove = null;
					//mouseListener.onMouseDown = null;
				}
			}
		//}
		
		break;
			
		case "ContinuaPartida":
			//Averiguamos cual es la pantalla activa.
			game.turno=resObj.turno;
			for(var t=0;t<_global.game.j_turnos.length;t++){
				if(_global.game.j_turnos[t]==game.turno){
					game.indice=t;
				}
			}
			
			var posicion=null;
			if(Ejercito._visible==true){
				posicion="Ejercito";
			}else if(Reclutar._visible==true){
				posicion="Reclutar";
			}else if(Partida._visible==true){
				posicion="Partida";
			}
			
			/*var turnosiguiente=resObj.turno;
			//_global.game.turno=resObj.turno;
			_global.game.j_turnos=resObj.j_turnos;
			if(turnosiguiente!=_global.game.turno){
				switch(posicion){
					case "Ejercito":
						break;
					
					case "Reclutar":
						break;
				}
			}*/
			
			//_root.debug("posicion:"+posicion);
			if(posicion=="Ejercito"){
				Ejercito.v_espera._visible=false;
				if(_global.jugador.ejercito==-1){
					Ejercito.alm.enabled=true;
					Ejercito.bre.enabled=true;
					Ejercito.bar.enabled=true;
					Ejercito.gal.enabled=true;
				}else{
					
				}
			}else if(posicion=="Reclutar"){
				//this.Reclutar.v_espera.swapDepths(10000);
				if(_global.game.ejercito==null){
					this[posicion].v_espera._visible=false;
					Reclutar.derecha.enabled=true;
					Reclutar.izquierda.enabled=true;
					Reclutar.muestras.inf.enabled=true;
					Reclutar.muestras.arc.enabled=true;
					Reclutar.muestras.cab.enabled=true;
					Reclutar.muestras.dra.enabled=true;
					Reclutar.muestras.tor.enabled=true;
					Reclutar.reclutar_uni.enabled=true;
					Reclutar.despedir.enabled=true;
					Reclutar.finalizar.enabled=true;
				}else{
					Reclutar.v_espera.texto.text=lang["Esperando_jug"];
					//.text="Esperando jugadores";
					windowManager("espera","show");
				}
			}else{
				_global.game.pausa=false;
				if(game.partidaReal!=true){
					//si es su turno, esconde ventana
					_root.debug("jugturn:"+jugador.turno+", gamturn:"+game.turno);
					if(jugador.turno==game.turno){
						this[posicion].v_espera._visible=false;
					}else{
						//sino muestra la ventana
						this.Partida.v_espera.texto.text=lang["Despliega_jugr"]+game.jugadores[game.indice];
						//.text="Despliega jugador "+game.jugadores[game.turno];
						this.Partida.v_espera.b_continuar._visible=false;
						this.Partida.v_espera.b_salir._visible=false;
					}
				}else{
					//si es su turno, esconde ventana
					if(jugador.turno==game.turno){
						this[posicion].v_espera._visible=false;
					}else{
						//sino muestra la ventana
						this.Partida.v_espera.texto.text=lang["Turno_jug"]+game.jugadores[game.indice];
						//.text="Turno jugador "+game.jugadores[game.turno];
						this.Partida.v_espera.b_continuar._visible=false;
						this.Partida.v_espera.b_salir._visible=false;
					}
				}
			}
			
			break;
		
		default:
			_root.debug("GAME: Comando "+cmd+" no definido",1);
			break;
	}
}

//guarda los datos del usuario en el juego en la base de datos
//Esta función TAN SOLO se debe utilizar si el juego dispone de datos específicos para cada usuario
//por ejemplo en el juego de futbol se guardan datos del tipo (teamName, teamColors,...)
function saveGameData(){
	var args={};
	args.gamedata={};
	if(!_root.orphan){
		//enviar un comando a la extensión de zona (
		_root.sendZoneMsg ("setGameData", args);
	}
}

// MUY IMPORTANTE
//Para enviar un comando a la extensión de habitación utiliza el siguinte código
//args es un objeto que contiene cualquier tipo de parámetro (args.loquesea)
_root.sendXtMsg ("gameActionID", args);

function CuentaJugActivos(){
	//Devuelve el numero de jugadores activos.
	var count=0;
	for(c=0;c<game.j_activos.length;c++){
		if(game.j_activos[c]==1){
			count++;
		}
	}
	_root.debug("Cuenta JActivos:"+count);
	return count;
}
