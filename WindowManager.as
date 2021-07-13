/*							FUNCIÓN execButton							**
**																		**
** 	Esta función la usamos para invocar las diferentes partes del juego **
**	(las ventanas) desde una función neutral, necesaria debido a que no **
** 	siempre sabremos donde estan dichas ventanas (la desarrollamos 		**
**	pensando en la estructura cliente-servidor).						**
**																		**
**	No hay ninguna manera obligatoria de crear una ventana, aunque por	**
**	convención todas las ventanas deben soportar los metodos "show" y	**
**	"hide", que muestran y esconden la ventana respectivamente.			**
**																		**
**	Esta plantilla contiene el código mínimo a implementar por cada 	**
**	ventana en windowManager.											**
**																		**
		case "name":
			switch (action) {
				case "show":
					
					break;
				case "hide":
					
					break;
				default:
					debug ("No entiendo la accion '" + action + "' para la ventana '" + window + "'.", 1);
					break;
			}
			break;
**																		**
**	La sintaxis de windowManager es la siguiente:						**
	windowManager (window, action, params);
** 																		**
**	donde	"window" es la ventana que intentamos llamar				**
** 			"action" es la acción que queremos ejecutar					**
**	y		"params" (opcional) son los parametros que le queramos 		**
**			pasar a la acción. Habitualmente los formateo como string	**
**			(si solo es uno), o como Array u Objeto (si son varios)		**
**																		**
**	windowManager se utiliza extensivamente en el cliente netWizzy y	**
**	en la documentación sobre el funcionamiento del mismo se realizan	**
**	multiples referencias al concepto de "ventanas".					**

** NOTA IMPORTANTE: Todos los casos que se muestran a continuación son  **
** necesarios para la comunicación entre cliente_rapido.swf y el juego. **
** Se pueden añadir más casos a tu elección.                            */

function windowManager(windowname, action, evntObj){

	switch (windowname){

		case "all":
			switch(action){
				//esconde todos los elementos visuales
				case "hide":
					//chat_mc._visible=false;
					windowManager("waiting_room","hide");
					windowManager("Ej_espera","hide");
					windowManager("espera","hide");
					//_root.debug("Oculta todoo.");
					//Presentacion._visible=true;
					this.Presentacion._alpha=100;
					this.Presentacion._visible=true;
					_root.game_mc.Presentacion._visible=true;
					_root.game_mc.Presentacion.inicio._visible=false;
					this.Ejercito._visible=false;
					this.Reclutar._visible=false;
					this.Partida._visible=false;
					//_root.debug("alpha pre:"+this.Presentacion._alpha+", "+_root.game_mc.Presentacion._alpha);
					//_root.debug("Visibilidad Pre:"+_root.game_mc.Presentacion._visible+", Ej:"+this.Ejercito._visible+", Rec:"+this.Reclutar._visible+", Par:"+this.Partida._visible);
					break;
			}
			break;
		
		//ESTE CASO ES UNICAMENTE PARA EL CLIENTE DE TEST, PARA SABER SI UN JUGADOR SE ESTA UNIENDO A LA PARTIDA O NO
		case "waiting_room":
			switch (action){
				case "show":
					//no se utiliza
					break;
				case "connect":
					//se llama desde el cliente justo después de clicar en el botón JUGAR y justo antes de empezar la partida
					//ESPERAMOS JUGADORES (cuando todos se han unido se llama a game_client("start");
					_root.windowManager("loading","show",["Conectando","Esperando Jugadores"]);
					break;
				case "hide":
					//no se utiliza
						_root.game_mc.Presentacion.inicio._visible=false;
            break;
	      default:
          break;
			}
      break;

		case "training":
			switch (action){
				case "show":
					//muestra/esconde el juego de 1 jugador (equivale a presionar el botón "Single Player" en el menu del juego)
					iniGame();
					break;
        case "hide":
					//esconde el juego y elimina eventos de raton, teclado y timers
					this.Presentacion.inicio._visible=false;
					break;
	      default:
					break;
			}
			break;
		
		case "presentacion":
			switch (action){
				case "show":
					//_root.debug("presentacion TRUE");
					_root.game_mc._visible=true;
					this.Presentacion._visible=true;
					_root.game_mc.Presentacion._visible=true;
					break;
        case "hide":
					this.Presentacion._visible=false;
					_root.game_mc.Presentacion._visible=false;
					break;
	      default:
					break;
			}
			break;
		
		case "Ej_espera":
			switch(action){
				case "show":
					this.Ejercito.v_espera._visible=true;
					this.Ejercito.v_espera.b_continuar._visible=false;
					this.Ejercito.v_espera.b_salir._visible=false;
					break;
				
				case "hide":
					this.Ejercito.v_espera._visible=false;
					this.Ejercito.v_espera.b_continuar._visible=false;
					//.text=lang["Continuar"];
					this.Ejercito.v_espera.b_continuar.nombre.text=lang["Continuar"];
					//this.Ejercito.v_espera.b_continuar.nombre.text="Continuar";
					this.Ejercito.v_espera.b_salir._visible=false;
					this.Ejercito.v_espera.b_salir.nombre.text=lang["Salir"];
					//this.Ejercito.v_espera.b_salir.nombre.text="Salir";
					break;
				
				default:
					break;
			}
			break;
		
		case "espera":
			//Muestra ventana de espera de jugadores.
			switch (action){
				case "show":
					this.Reclutar.v_espera._visible=true;
					this.Reclutar.v_espera.b_continuar._visible=false;
					this.Reclutar.v_espera.b_salir._visible=false;
					this.Reclutar.v_espera.swapDepths(10000);
					//Partida.espera.texto.text="Esperando jugadores";
					
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

					break;
        case "hide":
					this.Reclutar.v_espera._visible=false;
					this.Reclutar.v_espera.b_continuar._visible=false;
					this.Reclutar.v_espera.b_continuar.nombre.text=lang["Continuar"];
					//.text="Continuar";
					this.Reclutar.v_espera.b_salir._visible=false;
					this.Reclutar.v_espera.b_salir.nombre.text=lang["Salir"];
					//.text="Salir";
					
					this.Reclutar.derecha.enabled=true;
					this.Reclutar.izquierda.enabled=true;
					this.Reclutar.muestras.inf.enabled=true;
					this.Reclutar.muestras.arc.enabled=true;
					this.Reclutar.muestras.cab.enabled=true;
					this.Reclutar.muestras.dra.enabled=true;
					this.Reclutar.muestras.tor.enabled=true;
					this.Reclutar.reclutar_uni.enabled=true;
					this.Reclutar.despedir.enabled=true;
					this.Reclutar.finalizar.enabled=true;
					break;
	      default:
					break;
			}
			break;

		//muestra la pantalla de creditos del juego si la tuviera
		case "credits":
			switch (action){
				case "show":
                break;
                case "hide":
                break;
	            default:
                break;
			}
			break;
		//muestra la pantalla de reglas del juego si la tuviera
		case "rules":
			switch (action){
				case "show":
		        break;
        case "hide":
            break;
				default:
            break;
			}
			break;
		default:
			_root.debug ("No entiendo la accion '" + action + "' para la ventana '" + windowname + "'.", 1);
			break;
    }
}