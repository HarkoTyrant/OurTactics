import mx.transitions.Tween;

function IniVariables(){
	mapaRangos =[[0,0,0,0,0,0,0,0,0,0,0,0],
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
							 [0,0,0,0,0,0,0,0,0,0,0,0]];

	RangoTiros =[[0,0,0,0,0,0,0,0,0,0,0,0],
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
							 [0,0,0,0,0,0,0,0,0,0,0,0]];

	rank=[[0,-1],[1,0],[0,1],[-1,0],[0,0]];

	estados=["idle","walk","hit","dead"];
	direcciones=["Norte","Este","Sur","Oeste"];
	tipounit=["cap","inf","arc","cab","dra","tor"]
	ejercitos=["alm","bar","bre","gal"];

	areadespliegue=[[[0,1],[0,10]],
								 [[11,1],[11,10]],
								 [[1,0],[10,0]],
								 [[1,11],[10,11]]];

	despliegueAd=[[[1,3],[1,8]],
							 [[10,3],[10,8]],
							 [[3,1],[8,1]],
							 [[3,10],[8,10]]];

	areamuros=[[[0,0],[3,11]],
						 [[8,0],[11,11]],
						 [[0,0],[11,3]],
						 [[0,8],[11,11]]];
	
	//var game={};
	game.turno=-1;
	game.depth=-8000;
	game.path=_root.game_mc.Partida;
	game.sepx=320;
	game.sepy=95;
	game.anchot=50;
	game.altot=25;
	game.unisel=1;
	game.cantunits=[1,0,0,0,0,0];
	game.totalpuntos=10;
	game.colocaunits=false;
	game.colocamuros=false;
	game.nMuros=0;
	game.ejercito_sel=null;//=ejercitos[2];
	game.ejercito=null;
	game.indice=null;
	game.num_ejercitos=null;
	game.ejercitos_sel=null;
	game.unidades=null;
	game.juegoInicializado=false;
	game.partidaReal=false;
	game.numPlayers=null;
	game.playerIDS=null;
	game.j_activos=null;
	game.nPlyActivos=null;
	game.ejEliminado=null;
	game.playerEliminado=null;
	_global.game.pausa=false;
	//game.avatares;
	
	//var tipo_units={};

	//var units={};
	units.maxunits=7;
	units.select=null;

	//var jugador={};
	jugador.turno=-1;
	jugador.ejercito=-1;
	jugador.num_ejercito=-1;
	jugador.nombre=null;
	jugador.activo=true;

	var name;
	for(var n=0;n<ejercitos.length;n++){
		Ejercito[ejercitos[n]]._alpha=0;
		name="sel_"+ejercitos[n];
		Ejercito[name].text="";
	}

	Reclutar.despedir.nombre.text=lang["Despedir"];
	//.text="Despedir";
	this.Reclutar.reclutar_uni.nombre.text=lang["Reclutar"];
	//.text="Reclutar";
	Reclutar.finalizar.nombre.text=lang["Finalizar"];
	//.text="Finalizar";
	Reclutar.titulo_descripcion.text=lang["Descripcion"];
	Reclutar.Puntos.text=lang["tituloPuntos"];
	//Reclutar.total.text=game.totalpuntos;
	//trace(Reclutar.muestras.arc);

	Reclutar.cant_inf.text="0";
	Reclutar.cant_arc.text="0";
	Reclutar.cant_cab.text="0";
	Reclutar.cant_dra.text="0";
	Reclutar.cant_tor.text="0";
	Reclutar.valor.text="";
	Reclutar.descripcion.text="";
	Reclutar.total.text=game.totalpuntos;
	
	astar.unitfin=0;

}

function carga_units(){
	for(var n=0;n<6;n++){
		var nameunit=tipounit[n];
		tipo_units[nameunit]={};
		tipo_units[nameunit].name=nameunit;
		//trace(n+","+nameunit);
		//tipo_units[tipounit[n]].
		switch(n){
			case 0: tipo_units[tipounit[n]].valor=0;
							//tipo_units[tipounit[n]].nombre="cap";
							tipo_units[tipounit[n]].mov=2;
							tipo_units[tipounit[n]].tipomov="Andar";
							tipo_units[tipounit[n]].descripcion="General del ejercito";
							break;
			case 1: tipo_units[tipounit[n]].valor=1;
							//tipo_units[tipounit[n]].nombre="inf";
							tipo_units[tipounit[n]].mov=2;
							tipo_units[tipounit[n]].tipomov="Andar";
							tipo_units[tipounit[n]].descripcion=lang["inf"];
							//"Unidad basica de infanteria.<br><br>Se oculta en los bosques.<br><br><br>Mueve 2 casillas.<br><br><br><br>Puntos: 1";
							break;
			case 2: tipo_units[tipounit[n]].valor=2;
							//tipo_units[tipounit[n]].nombre="arc";
							tipo_units[tipounit[n]].mov=2;
							tipo_units[tipounit[n]].tipomov="Andar";
							tipo_units[tipounit[n]].descripcion=lang["arc"];
							//"Ataque a distancia con un alcance de 2 casillas.<br><br>Si esta en una montaña su alcance aumenta a 3.<br><br><br>Puntos: 2";
							break;
			case 3: tipo_units[tipounit[n]].valor=2;
							//tipo_units[tipounit[n]].nombre="cab";
							tipo_units[tipounit[n]].mov=4;
							tipo_units[tipounit[n]].tipomov="Andar";
							tipo_units[tipounit[n]].descripcion=lang["cab"];
							//"Una rapida unidad con una movilidad de 4 casillas.<br><br><br><br><br><br>Puntos: 2";
							break;
			case 4: tipo_units[tipounit[n]].valor=4;
							//tipo_units[tipounit[n]].nombre="dra";
							tipo_units[tipounit[n]].mov=4;
							tipo_units[tipounit[n]].tipomov="Volar";
							tipo_units[tipounit[n]].descripcion=lang["dra"];
							//"Poderosa unidad de ataque.<br><br><br>Mueve 4 casillas y puede volar sobre cualquier obstaculo.<br><br><br>Puntos: 4";
							break;
			case 5: tipo_units[tipounit[n]].valor=2;
							//tipo_units[tipounit[n]].nombre="tor";
							tipo_units[tipounit[n]].mov=2;
							tipo_units[tipounit[n]].tipomov="Nadar";
							tipo_units[tipounit[n]].descripcion=lang["tor"];
							//"Unidad anfibia.<br><br><br>Su movimiento de 2 casillas se dobla cuando esta en el agua.<br><br><br>Puntos: 2";
							break;
		}
	}
	//trace(tipo_units.inf.name);
}

/*Presentacion._visible=false;
Ejercito._visible=false;
Reclutar._visible=false;
Partida._visible=false;*/

/*------------------------------Pantalla de presentacion-------------------------------------*/


/*function iniGame(){
	IniVariables();
	carga_units();
	this.Presentacion._visible=true;
	this.Presentacion.inicio._visible=true;
	this.Presentacion.inicio.nombre.text=lang["Continuar"];
	//.text="Jugar";
	//_root.debug("A JUGA");
	this.Presentacion.inicio.onPress = function(){
		//_root.debug("AAA JUGARRRR");
		this.Ejercito._visible=true;
		var myTwDead:Tween = new Tween(_root.game_mc.Presentacion, "_alpha", None, 100, 0, 1, true);
		myTwDead.onMotionFinished = function(){
			this.Presentacion._visible=false;
			this.Presentacion._alpha=100;
			iniSelEjer();
		}
	}
}*/

/*-------------------------------Seleccion de ejercito-------------------------------------*/
//iniSelEjer();

function iniSelEjer(){
	//trace("Area:"+areamuros+",A J1:"+areamuros[0]+",A J1,I:"+areamuros[0][0]+",A J1,I,X:"+areamuros[0][0][0]);
	Ejercito._visible=true;
	
	//Ejercito[name].text=game.jugadores[game.indice];
	//Ejercito[ej].sel=true;
	//var avatar_name="avatar_"+ej;
	//_root.debug("avatar Name:"+avatar_name+",Ej:"+ej);
	//Ejercito[avatar_name]._visible=true;
	_root.debug("Turno:"+game.turno+"JT:"+jugador.turno);
	if(jugador.turno==game.turno){
		for(var n=0;n<ejercitos.length;n++){
			if(Ejercito[ejercitos[n]].sel==false){
				Ejercito[ejercitos[n]].enabled=true;
			}else{
				Ejercito[ejercitos[n]].enabled=false;
			}
		}
		Ejercito.titulo.text=lang["Selecciona_ejercito"];
		//.text="Selecciona ejercito: ";

		Ejercito.alm.onRollOver = function () {
			Ejercito.alm._alpha=100;
			Ejercito.titulo.text=lang["Selecciona_ejercito"]+lang["alm"];
			//.text="Selecciona ejercito: "+"Almogavares";
		}

		Ejercito.bre.onRollOver = function () {
			Ejercito.bre._alpha=100;
			Ejercito.titulo.text=lang["Selecciona_ejercito"]+lang["bre"];
			//.text="Selecciona ejercito: "+"Bretones";
		}

		Ejercito.bar.onRollOver = function () {
			Ejercito.bar._alpha=100;
			Ejercito.titulo.text=lang["Selecciona_ejercito"]+lang["bar"];
			//.text="Selecciona ejercito: "+"Barbaros";
		}

		Ejercito.gal.onRollOver = function () {
			Ejercito.gal._alpha=100;
			Ejercito.titulo.text=lang["Selecciona_ejercito"]+lang["gal"];
			//.text="Selecciona ejercito: "+"Galos";
		}

		//Fuera de plano
		Ejercito.alm.onRollOut = function () {
			Ejercito.alm._alpha=0;
			Ejercito.titulo.text=lang["Selecciona_ejercito"];
			//.text="Selecciona ejercito: ";
		}

		Ejercito.bar.onRollOut = function () {
			Ejercito.bar._alpha=0;
			Ejercito.titulo.text=lang["Selecciona_ejercito"];
			//.text="Selecciona ejercito: ";
		}

		Ejercito.bre.onRollOut = function () {
			Ejercito.bre._alpha=0;
			Ejercito.titulo.text=lang["Selecciona_ejercito"];
			//.text="Selecciona ejercito: ";
		}

		Ejercito.gal.onRollOut = function () {
			Ejercito.gal._alpha=0;
			Ejercito.titulo.text=lang["Selecciona_ejercito"];
			//.text="Selecciona ejercito: ";
		}

		//Seleccion ("alm","bar","bre","gal")
		Ejercito.alm.onPress = function(){
			//game.ejercito_sel=ejercitos[0];
			jugador.ejercito=ejercitos[0];
			jugador.num_ejercito=0;
			//Ejercito._visible=false;
			enviaEjercito();
			//iniReclutar();
		}

		Ejercito.bre.onPress = function(){
			//game.ejercito_sel=ejercitos[2];
			jugador.ejercito=ejercitos[2];
			jugador.num_ejercito=2;
			//Ejercito._visible=false;
			enviaEjercito();
			//iniReclutar();
		}

		Ejercito.bar.onPress = function(){
			//game.ejercito_sel=ejercitos[1];
			jugador.ejercito=ejercitos[1];
			jugador.num_ejercito=1;
			//Ejercito._visible=false;
			enviaEjercito();
			//iniReclutar();
		}

		Ejercito.gal.onPress = function(){
			//game.ejercito_sel=ejercitos[3];
			jugador.ejercito=ejercitos[3];
			jugador.num_ejercito=3;
			//Ejercito._visible=false;
			enviaEjercito();
			//iniReclutar();
		}
	}else{
		//Cambiar mensaje por turno
		_root.debug("Nombres:"+game.jugadores+",indx:"+game.indice+",turno:"+game.jugadores[game.indice]);
		Ejercito.titulo.text=lang["turno_seleccion"]+game.jugadores[game.indice];
		//.text="Es el turno de "+game.jugadores[game.indice];
		Ejercito.alm.enabled=false;
		Ejercito.bre.enabled=false;
		Ejercito.bar.enabled=false;
		Ejercito.gal.enabled=false;
	}
}

function enviaEjercito(){
	//_root.debug("enviamos seleccionde ejercito.");
	switch(jugador.ejercito){
		case "alm": Reclutar.Nom_Ejercito.text=lang["alm"];
		//.text="Almogavares";
								break;
		case "bre": Reclutar.Nom_Ejercito.text=lang["bre"];
		//.text="Bretones";
								break;
		case "bar": Reclutar.Nom_Ejercito.text=lang["bar"];
		//.text="Barbaros";
								break;
		case "gal": Reclutar.Nom_Ejercito.text=lang["gal"];
		//.text="Galos";
								break;
	}
	
	
	
	var resObj={};
	resObj.ejercito_sel=jugador.ejercito;
	resObj.num_ejercito=jugador.num_ejercito;
	resObj.jugIndex=jugador.indice;

	_root.sendXtMsg ("ejercitoSeleccionado", resObj);
}

/*-----------------------------Pantalla de reclutamiento-----------------------------------*/
//iniReclutar();
function cargaReclutar(){
	var peques="muestras";
	Reclutar[peques]=_root.game_mc.Reclutar.attachMovie("rec_"+jugador.ejercito, peques, -300);
	Reclutar[peques]._x=350;
	Reclutar[peques]._y=60;
	var grande="grande";
	Reclutar[grande]=_root.game_mc.Reclutar.attachMovie("rec_"+jugador.ejercito+"_big", grande, -302);
	Reclutar[grande]._xscale=80;
	Reclutar[grande]._yscale=80;
	Reclutar[grande]._x=170;
	Reclutar[grande]._y=250;
	
	uniSelect();
}

function iniReclutar(){
	Reclutar._visible=true;
	
	var peques="muestras";
	/*Reclutar[peques]=_root.game_mc.Reclutar.attachMovie("rec_"+jugador.ejercito, peques, -300);
	Reclutar[peques]._x=350;
	Reclutar[peques]._y=60;*/
	var grande="grande";
	/*Reclutar[grande]=_root.game_mc.Reclutar.attachMovie("rec_"+jugador.ejercito+"_big", grande, -302);
	Reclutar[grande]._xscale=80;
	Reclutar[grande]._yscale=80;
	Reclutar[grande]._x=170;
	Reclutar[grande]._y=250;*/
	//trace("boton:"+Reclutar.despedir+",nombre:"+Reclutar.despedir.nombre+",text:"+Reclutar.despedir.nombre.text);
	
	//mouseListener.onMouseDown = null;
	
	Reclutar.derecha.onPress = function(){
		game.unisel++;
		if(game.unisel>5){
			game.unisel=1;
		}
		uniSelect();
	}
	
	Reclutar.izquierda.onPress = function(){
		game.unisel--;
		if(game.unisel<1){
			game.unisel=5;
		}
		uniSelect();
	}

	Reclutar.muestras.inf.onPress = function(){
		game.unisel=1;
		uniSelect();
	}

	Reclutar.muestras.arc.onPress = function(){
		game.unisel=2;
		uniSelect();
	}

	Reclutar.muestras.cab.onPress = function(){
		game.unisel=3;
		uniSelect();
	}

	Reclutar.muestras.dra.onPress = function(){
		game.unisel=4;
		uniSelect();
	}

	Reclutar.muestras.tor.onPress = function(){
		game.unisel=5;
		uniSelect();
	}

	Reclutar.reclutar_uni.onPress = function(){
		var valor=tipo_units[tipounit[game.unisel]].valor;
		//trace(valor);
		if(game.totalpuntos-valor>=0){
			//var cant=Reclutar["cant_"+tipounit[game.unisel]].text;
			game.cantunits[game.unisel]++;
			var cant=game.cantunits[game.unisel];
			Reclutar["cant_"+tipounit[game.unisel]].text=cant;
			//trace("cant_"+tipounit[game.unisel]);
			//trace(cant);
			game.totalpuntos-=valor;
			Reclutar.total.text=game.totalpuntos;
		}
	}

	Reclutar.despedir.onPress = function(){
		var valor=tipo_units[tipounit[game.unisel]].valor;
		if(game.cantunits[game.unisel]>0){
			game.cantunits[game.unisel]-=1;
			game.totalpuntos+=valor;
			Reclutar["cant_"+tipounit[game.unisel]].text=game.cantunits[game.unisel];
			Reclutar.total.text=game.totalpuntos;
		}
	}

	Reclutar.finalizar.onPress = function(){
		//trace(game.totalpuntos)
		if(game.totalpuntos==0){
			//Reclutar._visible=false;
			//iniPartida();
			game.ejercito=[];
			var cont=0;
			for(n=0;n<6;n++){
				if(game.cantunits[n]>0){
					for(var c=0;c<game.cantunits[n];c++){
						game.ejercito[cont]=n;
						cont++;
					}
				}
			}
			enviaEjercitoRec();
		}
	}
}

function uniSelect(){
	for(var n=0;n<6;n++){
		if(game.unisel==n){
			Reclutar.grande[tipounit[n]]._visible=true;
		}else{
			Reclutar.grande[tipounit[n]]._visible=false;
		}
	}
	//Valores y descripciones
	var n=game.unisel;
	//trace(tipo_units.inf.name);
	//trace(n+","+tipo_units[tipounit[n]].name);
	var val=tipo_units[tipounit[n]].valor;
	switch(game.unisel){
		case 1: Reclutar.valor.text=val+lang["puntos2"];
						//.text=val+" punto";
						Reclutar.descripcion.htmlText=tipo_units[tipounit[n]].descripcion;
						break;
		case 2: Reclutar.valor.text=val+lang["puntos2"];
						//.text=val+" puntos";
						Reclutar.descripcion.htmlText=tipo_units[tipounit[n]].descripcion;
						break;
		case 3: Reclutar.valor.text=val+lang["puntos2"];
						//.text=val+" puntos";
						Reclutar.descripcion.htmlText=tipo_units[tipounit[n]].descripcion;
						break;
		case 4: Reclutar.valor.text=val+lang["puntos2"];
						//.text=val+" puntos";
						Reclutar.descripcion.htmlText=tipo_units[tipounit[n]].descripcion;
						break;
		case 5: Reclutar.valor.text=val+lang["puntos2"];
						//.text=val+" puntos";
						Reclutar.descripcion.htmlText=tipo_units[tipounit[n]].descripcion;
						break;
	}
}

function enviaEjercitoRec(){
	//_root.debug("enviamos ejercito reclutado.");
	var resObj={};
	//resObj.ejercito_sel=jugador.ejercito;
	resObj.ejercito_rec=game.ejercito;
	resObj.jugIndex=jugador.indice;

	_root.sendXtMsg ("EjReclutado", resObj);
	
	//Mostramos ventana de espera
	Reclutar.v_espera.texto.text=lang["Esperando_jug"];
	//.text="Esperando jugadores";
	windowManager("espera","show");
}
//iniPartida();

/*------------------------------Funciones de partida ------------------------------------*/
function iniPartida(){
	Partida._visible=true;
	
	//trace("Partida:"+Partida.getDepth());
	colocaMapa();
	//creaRejilla();
	iniRangoDisparo();
	creaMarcador();
	iniUnits();
	//CompruebaUnits();
	//iniUnit();//Segundo ejercito de ejmplo
	creaMarcadorFlecha();
	iniMapaRangos();
	
	//iniRangosMuros(1);

	//Partida.unit_actual._visible=true;
	//trace("Ejercito:"+game.ejercito_sel);
	game.juegoInicializado=true;
	
}

function Despliegue(){
	colocaEjercito(); //Reclutamiento
	//CompruebaUnits();

	if(jugador.turno==game.turno){
		//var mouseListener:Object = new Object();
		Mouse.addListener(mouseListener);
		movimientoRaton();
		/*mouseListener.onMouseMove = function(){
			var mx = _xmouse;
			var my = _ymouse;
			var xo=mx-game.sepx;
			var yo=my-(game.sepy);
			var x=(yo+(xo/2));
			var y=(yo-(xo/2));
			if(x<0){
				x-=11;
			}
			if(y<0){
				y-=11;
			}
			x=Math.floor(x/25);
			y=Math.floor(y/25);
			if(x>=0 && x<12 && y>=0 && y<12){
				//trace("MouseX:"+x+",MouseY:"+y);
				var name="tile"+x+"_"+y;
				game.marcador._x = game[name]._x;
				game.marcador._y = game[name]._y;
				game.marcador.tilex=x;
				game.marcador.tiley=y;
				var depth = calculaDepth(x, y);
				game.marcador.swapDepths(depth+1);
				game.marcador._visible=true;
				game.flechaMarca._x = game[name]._x;
				game.flechaMarca._y = game[name]._y-65;
				//depth = calculaDepth(x, y);
				game.flechaMarca.swapDepths(depth+4);
				game.flechaMarca._visible=true;
				//trace("Marcador:"+game.marcador.getDepth()+",x:"+x+",y:"+y);
				//trace("Flecha:"+game.flechaMarca.getDepth());
			}else{
				game.marcador._visible=false;
				game.flechaMarca._visible=false;
			}
		}*/

		mouseListener.onMouseDown = function(){
			if(_global.game.pausa==false){
				var mx = _xmouse;
				var my = _ymouse;
				var xo=mx-game.sepx;
				var yo=my-(game.sepy);
				var x=(yo+(xo/2));
				var y=(yo-(xo/2));
				if(x<0){
					x-=11;
				}
				if(y<0){
					y-=11;
				}
				x=Math.floor(x/25);
				y=Math.floor(y/25);
				var accion=false;
				//game.colocaunits=true;
				//game.colocamuros=true;
				if(x>=0 && x<12 && y>=0 && y<12){ //Comprueba si hace click en el mapa
					//_root.debug("colocaunits:"+game.colocaunits+",colocamuros:"+game.colocamuros);
					if(game.colocaunits==true && mapaRangos[x][y]==1 && jugador.turno!=""){//Colocamo unidades, comp. click en area despliegue
						//trace("Pon unit");
						var name="unit_"+jugador.ejercito+"_"+(game.unisel);
						var dir;
						switch(jugador.indice){
							case 0: dir=1;
											break;
							case 1: dir=3;
											break;
							case 2: dir=2;
											break;
							case 3: dir=0;
											break;
							default: _root.debug("No corresponde jugador numero: "+jugador.indice);
											break;
						}
						//_root.debug("colocamos unidad:"+name+" en posicion- X:"+x+",Y:"+y+",DIRECCION:"+dir+"JT:"+jugador.turno);
						plantarUnidad(name,x,y,dir);
						EnviaUniCol(x,y,dir);
						mapaRangos[x][y]=0;
						acualizaRango();
						game.unisel+=1;
						var total=game.ejercito.length;
						//_root.debug("unisel_"+game.unisel+",total:"+total);
						if(game.unisel<total){
							//Partida.unit_actual.title.text="Coloca unidades:";
							Partida.unit_actual.cantidad.text=(game.unisel+1)+"/"+total;
							var name="Ejercito_sel";
							for(var n=0;n<6;n++){
								//trace("unidad:"+game.ejercito[game.unisel]+","+tipounit[n]+","+game[name]+","+game[name][tipounit[n]]);
								if(game.ejercito[game.unisel]==n){
									game[name][tipounit[n]]._visible=true;
									//Partida.unit_actual.units[ejercitos[e]][tipounit[n]]._visible=true;
									//Partida.unit_actual.units[game.ejercito_sel][tipounit[n]]._visible=true;
									//Partida.unit_actual.units[tipounit[n]]._visible=true;
									visualizar(name,0,n);
								}else{
									game[name][tipounit[n]]._visible=false;
									//Partida.unit_actual.units[game.ejercito_sel][tipounit[n]]._visible=false;
									//Partida.unit_actual.units[tipounit[n]]._visible=false;
								}
							}
							var c=HuecosDespliegue(jugador.indice);
							//_root.debug("huecos:"+c);
							if(c==0){
								DespliegueAdicional(jugador.indice);
							}
						}else{
							//Cambia a muros
							game.colocaunits=false;
							_root.debug("Cambiamos a muros, colocaunits:"+game.colocaunits);
							limpiaRango();
							acualizaRango();
							var name="Ejercito_sel";
							game[name].removeMovieClip();
							game[name]._visible=false;
							//Partida.unit_actual._visible=false;
							//game.colocamuros=false
							iniRangosMuros(jugador.indice); //Jugador actual
							name="muro";
							game[name]=game.path.unit_actual.attachMovie("celda", name, game.depth++);
							game[name].Tiled.gotoAndStop(5+jugador.num_ejercito);
							game[name].cacheAsBitmap=true;
							game[name]._x=45
							game[name]._y=70;
							Partida.unit_actual.title.text=lang["Coloca_muros"];
							//.text="Coloca muros:";
							Partida.unit_actual.cantidad.text=(game.nMuros+1)+"/4";
						}
						//trace("units:"+game.colocaunits+",muros:"+game.colocamuros);
					}else if(game.colocaunits==false && game.colocamuros==true && mapaRangos[x][y]==1){
						//Colocamos muros
						//trace("Colocamuros");
						var nametile="tile"+x+"_"+y;
						game[nametile].Tiled.gotoAndStop(5+jugador.num_ejercito);
						game[nametile].type="Muro";
						//game[nametile].ejercito=game.ejercito_sel;
						game[nametile].ejercito=jugador.ejercito;
						mapaRangos[x][y]=0;
						acualizaRango();
						//mapa[y][x]=5+jugador.num_ejercito;
						game.nMuros++;
						Partida.unit_actual.cantidad.text=(game.nMuros+1)+"/4";
						EnviaMuro(nametile,x,y);
						if(game.nMuros>3){
							game.colocamuros=false
							var name="muro";
							removeMovieClip(game[name]);
							game[name]._visible=false;
							delete game[name];
						
							limpiaRango();
							acualizaRango();
							var namemuro="muro";
							game[namemuro].removeMovieClip();
							Partida.unit_actual._visible=false;
							
							//enviamos señal fin de despliegue
							_root.debug("enviamos fin de despliegue.");
							var resObj={};
							//resObj.jugIndex=jugador.turno;
							
							_root.sendXtMsg ("FinDespliegue", resObj);
						}
					}//Despliegue
				}//Dentro rango
			}
		}//mousedown
	}//Turno Jugador
}//funcion

function IniJuego(){
	_root.debug("jTurno:"+jugador.turno+",gTurno:"+game.turno+",comp:"+(jugador.turno==game.turno));
	if(jugador.turno==game.turno){
		mouseListener.onMouseDown = function(){
			if(_global.game.pausa==false){
			var mx = _xmouse;
			var my = _ymouse;
			var xo=mx-game.sepx;
			var yo=my-(game.sepy);
			var x=(yo+(xo/2));
			var y=(yo-(xo/2));
			if(x<0){
				x-=11;
			}
			if(y<0){
				y-=11;
			}
			x=Math.floor(x/25);
			y=Math.floor(y/25);
			var accion=false;
			if(x>=0 && x<12 && y>=0 && y<12){ //Comprueba si hace click en el mapa
				if(game.colocaunits==false && game.colocamuros==false){ 
					//Reaalizamos acciones con la unidad
					var nametile="tile"+x+"_"+y;
					if(game[nametile].unit!=0){ //Comprobamos si esta ocupado el tile
						//Ocupado
						if(units.select==null){//Si no hay seleccion
							//Seleccionamos esta unidad si es de nuestro ejercito
							var name=game[nametile].unit;
							if(units[name].ejercito==jugador.ejercito){//comprobamos si es del jugador
								units.select=name;
								limpiaRango();
								calculaRango(x,y,units[name].movimiento);
								CompruebaRango();
								acualizaRango();
								limpiaRTiro();
							
								if(units[name].tipounit=="arc"){
									//Si es un arquero calculamos area de disparo.
									if(game[nametile].type=="Mountain"){
										calculaRTiro(x,y,units[name].movimiento+1);
									}else{
										calculaRTiro(x,y,units[name].movimiento);
									}
								}
								acualizaRTiro();
							}
						}else if(game[nametile].unit!=units.select){ //Si hay seleccion
							var name=game[nametile].unit;
							//trace("EjS:"+game.ejercito_sel+",curEj:"+units[name].ejercito);
							if(units[name].ejercito==jugador.ejercito){ //Si es del ejercito del jugador
								//Cambiamos selecicon
								units.select=name;
								limpiaRango();
								calculaRango(x,y,units[name].movimiento);
								CompruebaRango();
								acualizaRango();
								limpiaRTiro();
								if(units[name].tipounit=="arc"){
									//Si es un arquero calculamos area de disparo.
									if(game[nametile].type=="Mountain"){
										calculaRTiro(x,y,units[name].movimiento+1);
									}else{
										calculaRTiro(x,y,units[name].movimiento);
									}
								}
								acualizaRTiro();
							}else if(mapaRangos[x][y]==3 || RangoTiros[x][y]==1){ //Si es de otro ejercito

								var nametile="tile"+x+"_"+y;
								var name=game[nametile].unit;
								//Comprobamos si hemos eliminado a un capitan
								if(units[name].tipounit==tipounit[0]){
									//Envia señal de muerte de un capitan
									_root.debug("Enviamos muerte capitan:"+name);
									var resObj={};
									//resObj.ejercito_sel=jugador.ejercito;
									resObj.jugIndex=jugador.turno;
									resObj.unitName=name;
									resObj.EjUnit=units[name].ejercito;

									_root.sendXtMsg ("MuerteCapitan", resObj);
								}

								//Atacamos
								//trace("tipo:"+units[units.select].tipounit);
								if(units[units.select].tipounit!=tipounit[2]){
									var nametile="tile"+x+"_"+y;
									astar.unitfin=game[nametile].unit;
									
									DespejaCaminoAtaque(x,y,units.select);
									var path:Array=calculaCamino(units.select,x,y);
									
									//Enviamos ataque al servidor.
									EnviaAccion(units.select,"Atacar",x,y,path);
									
									trace("Path:"+path);
									//trace("pathA:"+path+",path_0:"+path[0]+",00:"+path[0][0]+",01:"+path[0][1]+",uselect:"+units.select);
									//CompruebaOcultos(units.select,units[units.select].tilex,units[units.select].tiley,false);
									SeparaOcultos(units.select,units[units.select].tilex,units[units.select].tiley);
									atacUnit(units.select,path,units[units.select].tilex,units[units.select].tiley,path[0][0],path[0][1]);
									//mueveUnit(units.select,path,units[units.select].tilex,units[units.select].tiley,path[0][0],path[0][1]);
									//units[units.select].tilex=x;
									//units[units.select].tiley=y;
								}else{
									//Enviamos ataque al servidor.
									EnviaAccion(units.select,"Atacar",x,y,0);
									disparaUnit(units.select,x,y);
								}
								// Y eliminamos la seleccion
								limpiaRango();
								acualizaRango();
								limpiaRTiro();
								acualizaRTiro();
								units.select=null;
								path=null;
							}
						}
					}else{
						//Libre
						if(mapaRangos[x][y]==1){ //Dentro de rango de movimiento
							//Mover
							astar.unitfin=0;
							var path:Array=calculaCamino(units.select,x,y);
							
							//Enviamos movimiento al servidor.
							EnviaAccion(units.select,"Mover",x,y,path);

							//trace("Inicio:"+units[units.select].tilex+","+units[units.select].tiley+",fin:"+x+","+y+",camino:"+path);
							//trace("pathM:"+path+",uselect:"+unist.select);
							trace("DestinoMovimiento: X:"+x+",Y:"+y);
							trace("pathMovimiento:"+path+",Length:"+path.length);
							//CompruebaOcultos(units.select,units[units.select].tilex,units[units.select].tiley,false);
							SeparaOcultos(units.select,units[units.select].tilex,units[units.select].tiley);
							if(path.length==1){
								if(units[units.select].tipounit==tipounit[1]){
									//CompruebaInfanteriaOculta(units.select,units[units.select].tilex,units[units.select].tiley,path[0][0],path[0][1]);
								}
								/*var descubre=DescubreUnidad(units.select,path[0][0],path[0][1],0);
								if(units[units.select].ejercito==jugador.ejercito){
									trace("UnitN:"+units.select+",path00:"+path[0][0]+",path01:"+path[0][1]);
									CompruebaOcultos(units.select,path[0][0],path[0][1]);
									if(units[units.select].tipounit==tipounit[1]  && game[nametile].type=="Bosque"){
										if(descubre==true){
											DescubreInfanteria(units.select);
										}else{
											OcultaInfanteria(units.select);
										}
									}
								}
								if(units[units.select].tipounit==tipounit[1] && game[nametile].type=="Bosque"){
									if(descubre==true){
										DescubreInfanteria(units.select);
									}else{
										OcultaInfanteria(units.select);
									}
								}
								//if(units[units.select].tipounit==tipounit[1]){
									//descubreUnidad(units.select,path[0][0],path[0][1]);
								//}*/
							}
							mueveUnit(units.select,path,units[units.select].tilex,units[units.select].tiley,path[0][0],path[0][1]);
							//units[units.select].tilex=x;
							//units[units.select].tiley=y;
							//y eliminamos la seleccion
							limpiaRango();
							acualizaRango();
							limpiaRTiro();
							acualizaRTiro();
							units.select=null;
							path=null;
						}else{ //Fuera rango
							//eliminar seleccion
							limpiaRango();
							acualizaRango();
							limpiaRTiro();
							acualizaRTiro();
							units.select=null;
						}
					}
				}//partida
			}
			}
		}
	}
}

function movimientoRaton(){
	//Mouse.addListener(mouseListener);
	mouseListener.onMouseMove = function(){
		if(_global.game.pausa==false){
			var mx = _xmouse;
			var my = _ymouse;
			var xo=mx-game.sepx;
			var yo=my-(game.sepy);
			var x=(yo+(xo/2));
			var y=(yo-(xo/2));
			if(x<0){
				x-=11;
			}
			if(y<0){
				y-=11;
			}
			x=Math.floor(x/25);
			y=Math.floor(y/25);
			if(x>=0 && x<12 && y>=0 && y<12){
				//trace("MouseX:"+x+",MouseY:"+y);
				var name="tile"+x+"_"+y;
				game.marcador._x = game[name]._x;
				game.marcador._y = game[name]._y;
				game.marcador.tilex=x;
				game.marcador.tiley=y;
				var depth = calculaDepth(x, y);
				game.marcador.swapDepths(depth+1);
				game.marcador._visible=true;
				game.flechaMarca._x = game[name]._x;
				game.flechaMarca._y = game[name]._y-65;
				//depth = calculaDepth(x, y);
				game.flechaMarca.swapDepths(depth+4);
				game.flechaMarca._visible=true;
				//trace("Marcador:"+game.marcador.getDepth()+",x:"+x+",y:"+y);
				//trace("Flecha:"+game.flechaMarca.getDepth());
			}else{
				game.marcador._visible=false;
				game.flechaMarca._visible=false;
			}
		}
	}
}

/*function ActivaUnidades(valor){
	for(u=0;u<game.ejercito.length;u++){
		var name="unit_"+jugador.ejercito+"_"+u;
		_root.debug("Name:"+name+",unitEnab:"+units[name].enabled+",valor:"+valor);
		units[name].enabled=valor;
	}
}*/

function SuicidioColectivo(nPlayer:Number,ejercito,general){
	_root.debug("SUICIDIO COLECTIVO");
	var tweens={};
	var n;
	if(general==false){
		n=1;
	}else{
		n=0;
	}
	for(n;n<game.unidades[nPlayer].length;n++){
		//eliminamos unidades
		var name="unit_"+ejercito+"_"+n;
		visualizar(name,3,units[name].direccion);
		var myTwDead:Tween = new Tween(units[name], "_alpha", None, 100, 0, 1, true);
	}
	myTwDead.onMotionFinished = function(){
		//eliminamos unidades
		for(n=1;n<game.unidades[nPlayer].length;n++){
			var name="unit_"+ejercito+"_"+n;
			//Vaciamos casilla.
			var nametile=units[name].tile;
			//_root.debug("Nunit:"+name+",Ntile:"+nametile+",UnitenTile:"+game[nametile].unit);
			game[nametile].unit=0;
			//_root.debug("UnitenTile:"+game[nametile].unit);
			units[name].tile=null;
			units[name]=null;
			//Eliminamos al muerto
			removeMovieClip(units[name]);
		}
	}
	game.ejEliminado=null;
	game.playerEliminado=null;
}

function EnviaAccion(name, accion, x:Number, y:Number,path){
	//Envia la accion realizada con la unidad a los otros jugadores.
	_root.debug("Enviamos accion de la unidad:"+name+",Accion:"+accion+",X:"+x+",Y:"+y);

	var resObj={};
	//resObj.ejercito_sel=jugador.ejercito;
	resObj.jugIndex=jugador.turno;
	resObj.unitName=name;
	resObj.accion=accion;
	resObj.posX=x;
	resObj.posY=y;
	resObj.path=path;

	_root.sendXtMsg ("AccionUnidad", resObj);
}

function EnviaUniCol(x:Number, y:Number, dir:Number){
	//Envia unidad colocada
	var name="unit_"+jugador.ejercito+"_"+(game.unisel);

	_root.debug("enviamos unidad colocada:"+name+",X:"+x+",Y:"+y+",Dir:"+dir);

	var resObj={};
	//resObj.ejercito_sel=jugador.ejercito;
	resObj.jugIndex=jugador.turno;
	resObj.uniName=name;
	resObj.posX=units[name].tilex;
	resObj.posY=units[name].tiley;
	resObj.dir=units[name].direccion;

	_root.sendXtMsg ("UnidadColocada", resObj);
}

function EnviaMuro(tile,x:Number,y:Number){
	//Envia unidad colocada
	_root.debug("enviamos muro colocado:"+tile+",X:"+x+",Y:"+y);

	var resObj={};
	//resObj.ejercito_sel=jugador.ejercito;
	resObj.jugIndex=jugador.indice;
	resObj.tileMuro=tile;
	resObj.posX=x;
	resObj.posY=y;

	_root.sendXtMsg ("MuroColocado", resObj);
}

function plantarUnidad(name,x:Number, y:Number, dir:Number){
	units[name].tilex=x;
	units[name].tiley=y;
	var nametile="tile"+x+"_"+y;
	units[name]._x=game[nametile]._x;
	units[name]._y=game[nametile]._y;
	var depth:Number = calculaDepth(x, y)+6;
	units[name].swapDepths(depth);
	//_root.debug("unit name:"+name+",tipo:"+units[name].tipounit+",X:"+x+",Y:"+y+", depth:"+depth);
	//trace(name+":"+units[name].getDepth());
	game[nametile].unit=name;
	units[name].tile=nametile;
	//_root.debug("NAMETILE:"+nametile+",UenTile:"+game[nametile].unit+"TenUnit:"+units[name].tile);
	units[name].direccion=dir;
	units[name]._visible=true;
	visualizar(name,0,dir);
	
	//Ocultamos infanteria en bosque
	if(units[name].tipounit==tipounit[1]){
		units[name].oculta=false;
		if(game[nametile].type=="Bosque"){
			OcultaInfanteria(name);
		}
	}
}

function colocaEjercito(){
	//trace("colocaejercito");
	var total=game.ejercito.length;
	game.unisel=0;
	
	//game.depth+=5;
	//var depth = calculaDepth(x, y);
	var name="Ejercito_sel";
	Partida.unit_actual._visible=true;
	Partida.unit_actual.swapDepths(500000);
	Partida.unit_actual.title.text=lang["Coloca_units"];
	//.text="Coloca unidades:";
	game[name]=game.path.unit_actual.attachMovie(jugador.ejercito+"_seleccion", name, 100);
	//trace(name+":"+game[name].getDepth());
	game[name]._xscale=70;
	game[name]._yscale=70;
	game[name]._x=30;
	game[name]._y=55;
	
	game.colocaunits=true;
	Partida.unit_actual.units_vect._visible=false;
	//trace("ejercito:"+ejercitos[2]);
	Partida.unit_actual.units._visible=false;
	/*for(var e=0;e<4;e++){
		//trace("ejercito:"+ejercitos[e]);
		if(game.ejercito_sel==ejercitos[e]){
			//units[ejercito[n]]._visible=true;
			Partida.unit_actual.units[ejercitos[e]]._visible=true;*/
			for(var n=0;n<6;n++){
				//trace(tipounit[n]+",sel:"+tipounit[game.ejercito[game.unisel]]+","+game.ejercito[game.unisel]+","+game[name][tipounit[n]]);
				if(game.ejercito[game.unisel]==n){
					game[name][tipounit[n]]._visible=true;
					//Partida.unit_actual.units[ejercitos[e]][tipounit[n]]._visible=true;
					//Partida.unit_actual.units[tipounit[n]]._visible=true;
				}else{
					game[name][tipounit[n]]._visible=false;
					//Partida.unit_actual.units[ejercitos[e]][tipounit[n]]._visible=false;
					//Partida.unit_actual.units[tipounit[n]]._visible=false;
				}
			}/*
		}else{
			Partida.unit_actual.units[ejercitos[e]]._visible=false;
		}
	}*/
	/*for(var n=0;n<6;n++){
		//trace(n+","+game.ejercito[n]);
		if(game.ejercito[game.unisel]==n){
			Partida.unit_actual.units[tipounit[n]]._visible=true;
		}else{
			Partida.unit_actual.units[tipounit[n]]._visible=false;
		}
	}*/
	Partida.unit_actual.cantidad.text=(game.unisel+1)+"/"+total;
	
	/*var namerango;
	for(var n=1;n<11;n++){
		namerango="rango0_"+n;
		mapaRangos[0][n]=1;
		
		//game[namerango]._visible=true;
	}
	acualizaRango();*/
	limpiaRango();
	RangosDespliegue(jugador.indice);
}

function colocaMapa(){
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			//game.depth+=5;
			var name="tile"+x+"_"+y;
			var depth = calculaDepth(x, y);
			//var depth = 0;
			//_root.debug("Tile name:"+name+", depth:"+depth);
			game[name]=game.path.attachMovie("celda3", name, depth);//+game.depth
			//trace(name+":"+game[name].getDepth());
			game[name]._x = ((x - y)*game.altot)+game.sepx;
			game[name]._y = ((x + y)*game.altot/2)+game.sepy;
			game[name].unit=0;
			game[name].Tiled.gotoAndStop((mapa[y][x]));
			switch(mapa[y][x]){
				case 1: game[name].type="Normal";
								break;
				case 2: game[name].type="Mountain";
								break;
				case 3: game[name].type="Bosque";
								break;
				case 4: game[name].type="Water";
								break;
				case 5: game[name].type="Muro";
								break;
			}
			game[name].cacheAsBitmap=true;
		}
	}
}

function calculaDepth(x, y) {
	var leeway = 100;
	var x = Math.abs(x)*leeway;
	var y = Math.abs(y)*leeway;
	var a = 12;
	//var floor = a*(b-1)+x;
	//var depth = a*(z-1)+x+floor*y;
	var depth = a*(y-1)+x;//10*(z-1)+x
	//_root.debug("Depth X:"+x+",Y:"+y+"depth:"+depth);
	return depth;
}

function iniMapaRangos(){
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			var depth = calculaDepth(x, y)+2;
			var name="rango"+x+"_"+y;
			game[name]=game.path.attachMovie("rango", name, depth);
			game[name]._x = ((x - y)*game.altot)+game.sepx;
			game[name]._y = ((x + y)*game.altot/2)+game.sepy;
			game[name]._visible=false;
		}
	}
}

function iniRangoDisparo(){
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			//game.depth+=5;
			var depth = calculaDepth(x, y)+3;
			//var depth = 0;
			var name="tiro"+x+"_"+y;
			//_root.debug("Tiro name:"+name+", depth:"+depth);
			game[name]=game.path.attachMovie("Rdisp", name, depth);//+game.depth
			//trace(name+":"+game[name].getDepth());
			game[name]._x = ((x - y)*game.altot)+game.sepx;
			game[name]._y = ((x + y)*game.altot/2)+game.sepy;
			if(RangoTiros[y][x]==0){
				game[name]._visible=false;
			}
		}
	}
}

function RangosDespliegue(jugador:Number){
	// Marcamos las posiciones donde colocar los muros
	// Cuatro casillas de distancia desde zona de despliegue
	limpiaRango();
	var IniX=areadespliegue[jugador][0][0];
	var IniY=areadespliegue[jugador][0][1];
	var FinX=areadespliegue[jugador][1][0];
	var FinY=areadespliegue[jugador][1][1];
	
	//trace("XI:"+IniX+",YI:"+IniY+",XF:"+FinX+",YF:"+FinY);
	var name="";
	var nametile="";
	for(x=IniX;x<=FinX;x++){
		for(y=IniY;y<=FinY;y++){
			//name="rango"+x+"_"+y;
			nametile="tile"+x+"_"+y;
			if(game[nametile].unit==0 && game[nametile].type!="Muro"){
				mapaRangos[x][y]=1;
			}
		}
	}
	acualizaRango();
	//var name="rango"+x+"_"+y;
		//namerango="rango0_"+n;
		//mapaRangos[0][n]=1;
		//game[namerango]._visible=true;
}

function HuecosDespliegue(jugador:Number){
	//_root.debug("Cuenta Huecos jugador:"+jugador);
	var IniX=areadespliegue[jugador][0][0];
	var IniY=areadespliegue[jugador][0][1];
	var FinX=areadespliegue[jugador][1][0];
	var FinY=areadespliegue[jugador][1][1];
	var count=0;
	var nametile="";
	for(x=IniX;x<=FinX;x++){
		for(y=IniY;y<=FinY;y++){
			//name="rango"+x+"_"+y;
			nametile="tile"+x+"_"+y;
			//_root.debug("tile cuentas:"+nametile);
			if(game[nametile].unit==0 && game[nametile].type!="Muro"){
				count++;
			}
		}
	}
	//_root.debug("count:"+count);
	return count;
}

function DespliegueAdicional(jugador:Number){
	var IniX=despliegueAd[jugador][0][0];
	var IniY=despliegueAd[jugador][0][1];
	var FinX=despliegueAd[jugador][1][0];
	var FinY=despliegueAd[jugador][1][1];
	var nametile="";
	for(x=IniX;x<=FinX;x++){
		for(y=IniY;y<=FinY;y++){
			//name="rango"+x+"_"+y;
			nametile="tile"+x+"_"+y;
			if(game[nametile].unit==0 && game[nametile].type!="Muro"){
				mapaRangos[x][y]=1;
			}
		}
	}
	acualizaRango();
	
}

function iniRangosMuros(jugador:Number){
	// Marcamos las posiciones donde colocar los muros
	// Cuatro casillas de distancia desde zona de despliegue
	limpiaRango();
	var IniX=areamuros[jugador][0][0];
	var IniY=areamuros[jugador][0][1];
	var FinX=areamuros[jugador][1][0];
	var FinY=areamuros[jugador][1][1];
	
	//trace("XI:"+IniX+",YI:"+IniY+",XF:"+FinX+",YF:"+FinY);
	var name="";
	var nametile="";
	for(x=IniX;x<=FinX;x++){
		for(y=IniY;y<=FinY;y++){
			//name="rango"+x+"_"+y;
			nametile="tile"+x+"_"+y;
			if(game[nametile].unit==0 && game[nametile].type=="Normal"){
				mapaRangos[x][y]=1;
			}
		}
	}

	//No se pueden poner muros en el area de despliegue de los otros jugadores.
	for(area=0;area<_global.game.j_turnos.length;area++){
		if(_global.game.j_turnos[area]!=-1){
			if(area!=jugador && area>=jugador){
				IniX=areadespliegue[area][0][0];
				IniY=areadespliegue[area][0][1];
				FinX=areadespliegue[area][1][0];
				FinY=areadespliegue[area][1][1];
				for(x=IniX;x<=FinX;x++){
					for(y=IniY;y<=FinY;y++){
						//name="rango"+x+"_"+y;
						nametile="tile"+x+"_"+y;
						mapaRangos[x][y]=0;
					}
				}
			}
		}
	}

	acualizaRango();
	//var name="rango"+x+"_"+y;
		//namerango="rango0_"+n;
		//mapaRangos[0][n]=1;
		//game[namerango]._visible=true;
}

/*function creaRejilla(){
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			var name="rejilla"+x+"_"+y;
			game[name]=game.path.attachMovie("rejilla", name, game.depth++);
			game[name]._x = ((x - y)*game.altot)+game.sepx;
			game[name]._y = ((x + y)*game.altot/2)+game.sepy;
		}
	}
}*/

function creaMarcador(){
	game.depth+=25;
	//var depth = calculaDepth(x, y);
	//_root.debug("Marcador, depth:"+game.depth);
	game.marcador=game.path.attachMovie("tile_situacion", "marcador", game.depth);
	//trace("Marcador:"+game.marcador.getDepth());
	game.marcador._x = -50;
	game.marcador._y = -50;
	game.marcador._visible=false;
}

function creaMarcadorFlecha(){
	game.depth+=25;
	//var depth = calculaDepth(x, y);
	//_root.debug("Flecha animada, depth:"+game.depth);
	game.flechaMarca=game.path.attachMovie("flecha_animada", "marcador", game.depth);
	//trace("Flecha:"+game.flechaMarca.getDepth());
	game.flechaMarca._x = -50;
	game.flechaMarca._y = -50;
	game.flechaMarca._visible=false;
}

/*function iniUnit(){
	var ej=ejercitos[0];
	if(game.ejercito_sel==ej){
		ej=ejercitos[3];
	}
	//var depth = calculaDepth(x, y);
	for(var n=0;n<6;n++){
		game.depth+=5;
		var name="unit_"+ej+"_"+n;
		//trace(name+",tipo:"+tipounit[n]);
		units[name]=game.path.attachMovie(ej+"_"+tipounit[1], name, game.depth);
		//trace(name+":"+units[name].getDepth());
		//units[name]=game.path.attachMovie("Prueba", name, game.depth++);
		var xini=11;
		var yini=n*2+0;
		var depth = calculaDepth(xini, yini);
		units[name].swapDepths(depth+6);
		//trace(name+":"+units[name].getDepth());
		units[name].movimiento=2;
		units[name].typemov="Andar";
		//units[name].typemov="Nadar";
		//units[name].typemov="Volar";
		units[name].tilex=xini;
		units[name].tiley=yini;

		var nametile="tile"+xini+"_"+yini;
		units[name]._x=game[nametile]._x;
		units[name]._y=game[nametile]._y;
		game[nametile].unit=name;
		units[name].tile=nametile;
		units[name].tipounit=n;
		units[name].ejercito=ej;
		units[name].valortile=0; //backup del contenido de la casilla que dejara al mover.
		units[name].dir=3;

		visualizar(name,0,units[name].dir);
	}
}*/

function iniUnits(){
	//trace("Ejericto:"+game.ejercito);
	//trace("lengthEjercito:"+game.ejercito.length);
	game.depth+=5;
	//var depth = calculaDepth(x, y);
	_root.debug("ejercitosL:"+game.ejercitos_sel.length+", ejercitos:"+game.ejercitos_sel);
	for(var e=0;e<game.ejercitos_sel.length;e++){
		if(game.ejercitos_sel[e]!=""){
			_root.debug("unidadesL:"+game.unidades[e].length+", unidades:"+game.unidades);
			for(var n=0;n<game.unidades[e].length;n++){//game.ejercito.length
				game.depth+=5;
				var name="unit_"+game.ejercitos_sel[e]+"_"+n;
				var uname=tipounit[game.unidades[e][n]];
				_root.debug("ej:"+game.ejercitos_sel[e]+"unit:"+name+",tipo:"+uname+",depth:"+game.depth);
				//trace("NombreUnit:"+uname+" name:"+name+",N:"+n);
				//units[name]=game.path.attachMovie(game.ejercito_sel+"_"+uname, name, game.depth);
				units[name]=game.path.attachMovie(game.ejercitos_sel[e]+"_"+uname, name, game.depth);
				_root.debug("unit:"+name+", visible:"+units[name]._visible);
				//trace(name+":"+units[name].getDepth());
				//units[name]=game.path.attachMovie("Prueba", name, game.depth++);
				//units[name].gotoAndStop(1);
				//units[name]._xscale=40;
				//units[name]._yscale=40;
				var xini=-1;
				var yini=-1;
				//var xini=0;
				//var yini=n*2+2;
				units[name].movimiento=tipo_units[uname].mov;
				units[name].typemov=tipo_units[uname].tipomov;
				//units[name].movimiento=2;
				//units[name].typemov="Andar";
				//units[name].typemov="Nadar";
				//units[name].typemov="Volar";
				units[name]._visible=false;
				units[name].tilex=xini;
				units[name].tiley=yini;
				/*var nametile="tile"+xini+"_"+yini;
				//trace(nametile+","+units[name].tilex+","+units[name].tiley);
				units[name]._x=game[nametile]._x;
				units[name]._y=game[nametile]._y;*/
				//game[nametile].unit=name;
				//units[name].tile=nametile;
				units[name].tile=null;
				units[name].tipounit=uname;
				units[name].ejercito=game.ejercitos_sel[e];
				units[name].valortile=0; //backup del contenido de la casilla que dejara al mover.
				units[name].dir=1;
		
				//visualizar(name,0,units[name].dir);
			}
		}
	}
}

/*function CompruebaUnits(){
	_root.debug("COMPROBACIOON");
	for(var e=0;e<game.ejercitos_sel.length;e++){
		_root.debug("unidadesL:"+game.unidades[e].length);
		for(var n=0;n<game.unidades[e].length;n++){//game.ejercito.length
			var name="unit_"+game.ejercitos_sel[e]+"_"+n;
			var uname=tipounit[game.unidades[e][n]];
			_root.debug("ej:"+game.ejercitos_sel[e]+"unit:"+name+",tipo:"+uname+",depth:"+units[name].getDepth());
		}
	}
}*/

function visualizar(unitname, estado, direccion){
	//trace(unitname+","+estado+","+direccion);
	//trace("direccion:"+direccion);
	for(var e=0;e<estados.length;e++){
		if(e!=estado){
			units[unitname][estados[e]]._visible=false;
			units[unitname][estados[e]].stop();
			for(var d=0;d<direcciones.length;d++){
				units[unitname][estados[e]][direcciones[d]]._visible=false;
				units[unitname][estados[e]][direcciones[d]].stop();
			}
		}else{
			//units[unitname][estados[e]].play();
			//units[unitname][estados[e]].stop();
			units[unitname][estados[e]]._visible=true;
			
			//trace("estado:"+e+","+estados[e]+","+units[unitname][estados[e]]._visible);
			for(var d=0;d<direcciones.length;d++){
				if(d!=direccion){
					units[unitname][estados[e]][direcciones[d]]._visible=false;
					units[unitname][estados[e]][direcciones[d]].stop();
				}else{
					units[name].dir=d;
					//trace("dir:"+d+","+direcciones[d]);
					units[unitname][estados[e]][direcciones[d]]._visible=true;
					//units[unitname][estados[e]][direcciones[d]].stop();
					units[unitname][estados[e]][direcciones[d]].gotoAndPlay(0);
					//units[unitname][estados[e]][direcciones[d]].play();
				}
			}
		}
	}
}

function encararUnit(xini:Number, yini:Number, xfin:Number, yfin:Number){
	//0 - Norte.[0,-1]
	//1 - Este.	[1,0]
	//2 - Sur.	[0,1]
	//3 - Oeste.[-1,0]
	var dir=-1;
	if(xini!=xfin){
		if(xini<xfin){
			dir=1;
		}else{
			dir=3;
		}
	}else if(yini!=yfin){
		if(yini>yfin){
			dir=0;
		}else{
			dir=2;
		}
	}
	//trace("direccion:"+dir);
	return dir;
}

function modPosicion(tilename, unitname){
	var mod:Number=0;
	switch(game[tilename].type){
		case "Normal": mod=0;
									break;
		case "Mountain": mod=-20;
										break;
		case "Bosque": mod=-20;
									break;
		case "Water": mod=0;
									break;
		case "Muro": mod=-20;
								break;
	};
	if(mod<>0){
		//trace(mod);
		if(units[unitname].tipounit!="dra"){
			mod+=10;
		}
	}
	//trace("tipoT:"+game[tilename].type+",tipoU:"+units[unitname].tipounit+",mod:"+mod);
	return mod;
}

function mueveUnit(unitname, path:Array, xini:Number, yini:Number, xfin:Number, yfin:Number){
	//var path:Array;
	//trace("UN:"+unitname+",path:"+path+",xi:"+xini+",yi:"+yini+",xf:"+xfin+",yf:"+yfin);
	if(path.length>0){
		var depth=0;
		var tileini="tile"+xini+"_"+yini;
		var tilefin="tile"+xfin+"_"+yfin;
		//trace("Tile1:"+tileini+".type:"+game[tileini].type+"Tile2:"+tilefin+".type:"+game[tilefin].type);
		var dir=encararUnit(xini,yini,xfin,yfin);
		game[tileini].unit=units[unitname].valortile;
		units[unitname].valortile=game[tilefin].unit;
		game[tilefin].unit=unitname;
		units[unitname].tile=tilefin;
		units[unitname].tilex=xfin;
		units[unitname].tiley=yfin;
		if(game[tileini].unit!=0){
			depth = calculaDepth(xini, yini)+6;
			units[game[tileini].unit].swapDepths(depth);
		}
		depth = calculaDepth(xfin, yfin)+6;
		units[unitname].swapDepths(depth);
		//trace("Tini:"+game[tileini].type+",Tfin:"+game[tilefin].type);
		//trace(name+":"+units[name].getDepth());
		var modi=modPosicion(tileini, unitname);
		var modf=modPosicion(tilefin, unitname);
		var myTween:Tween = new Tween(units[unitname], "_x", None, game[tileini]._x, game[tilefin]._x, 6, false);
		var myTween:Tween = new Tween(units[unitname], "_y", None, game[tileini]._y+modi, game[tilefin]._y+modf, 6, false);
		
		//Comprobamos si una unidad de infanteria entra o sale de un bosque
		/*if(units[unitname].tipounit==tipounit[1]){
			if(game[tilefin].type=="Bosque"){
				if(units[unitname]._alpha>10){
					OcultaInfanteria(unitname);
				}
			}else if(game[tilefin].type!="Bosque" && units[unitname]._alpha<10){
				DescubreInfanteria(unitname);
			}
		}*/
		//if(units[unitname].tipounit==tipounit[1]){
			CompruebaInfanteriaOculta(unitname,xini,yini,xfin,yfin);
		//}
		//visualizar(unitname,1,units[unitname].direccion);
		visualizar(unitname,1,dir);
		myTween.onMotionFinished = function(){
			//myTween.start();
			//visualizar(unitname,0,units[unitname].direccion);
			visualizar(unitname,0,dir);
			//game[tileini].unit=0;
			var paso = path.shift();
			//trace("fin,path"+path+",paso"+paso);
			if(path.length>0){
				trace("Path.Length:"+path.length);
				if(path.length==1){
					/*var descubre=DescubreUnidad(unitname,path[0][0],path[0][1],0);
					if(units[unitname].ejercito==jugador.ejercito){
						trace("path:"+path);
						CompruebaOcultos(unitname,path[0][0],path[0][1]);
						if(units[unitname].tipounit==tipounit[1] && game[tilefin].type=="Bosque"){
							if(descubre==true){
								DescubreInfanteria(unitname);
							}else{
								OcultaInfanteria(unitname);
							}
						}
					}
					tilefin="tile"+path[0][0]+"_"+path[0][1];
					if(units[unitname].tipounit==tipounit[1] && game[tilefin].type=="Bosque"){
						if(descubre==true){
							DescubreInfanteria(unitname);
						}else{
							OcultaInfanteria(unitname);
						}
					}*/
				}
				mueveUnit(unitname,path, paso[0], paso[1],path[0][0],path[0][1]);
			}else{
				_root.debug("jturn:"+jugador.turno+",gturn:"+game.turno);
				if(jugador.turno==game.turno){
					CambiaTurno();
				}
			}
		}
	}
}

function atacUnit(unitname, path:Array, xini:Number, yini:Number, xfin:Number, yfin:Number){
	//var path:Array;
	//trace("UN:"+unitname+",path:"+path+",xi:"+xini+",yi:"+yini+",xf:"+xfin+",yf:"+yfin);
	//trace("Path:"+path+",L:"+path.length+",pos0:"+path[0]+",p0x:"+path[0][0]+"p0y:"+path[0][1]);
	if(path.length>0){
		if(path.length!=1){
			var tileini="tile"+xini+"_"+yini;
			var tilefin="tile"+xfin+"_"+yfin;
			//trace("Tile1:"+tileini+".type:"+game[tileini].type+"Tile2:"+tilefin+".type:"+game[tilefin].type);
			var dir=encararUnit(xini,yini,xfin,yfin);
			game[tileini].unit=units[unitname].valortile;
			units[unitname].valortile=game[tilefin].unit;
			game[tilefin].unit=unitname;
			units[unitname].tile=tilefin;
			units[unitname].tilex=xfin;
			units[unitname].tiley=yfin;
			var depth = calculaDepth(xfin, yfin)+6;
			units[unitname].swapDepths(depth);
			var modi=modPosicion(tileini, unitname);
			var modf=modPosicion(tilefin, unitname);
			var myTween:Tween = new Tween(units[unitname], "_x", None, game[tileini]._x, game[tilefin]._x, 6, false);
			var myTween:Tween = new Tween(units[unitname], "_y", None, game[tileini]._y+modi, game[tilefin]._y+modf, 6, false);
			//visualizar(unitname,1,units[unitname].direccion);
			visualizar(unitname,1,dir);
			myTween.onMotionFinished = function(){
				//myTween.start();
				//visualizar(unitname,0,units[unitname].direccion);
				visualizar(unitname,0,dir);
				var paso = path.shift();
				//trace("fin,path:"+path+",paso:"+paso);
				if(path.length>1){ //dejar el ultimo paso para el ataque
					//trace("L:"+path.length);
					atacUnit(unitname,path, paso[0], paso[1],path[0][0],path[0][1]);
				}else{ //realizar el ataque y la muerte de la otra unidad.
					//en path solo queda un paso (la casilla de la otra unidad),
					//la tile de origen esta en paso

					//visualizar(unitname,1,units[unitname].direccion);
					var nametile="tile"+path[0][0]+"_"+path[0][1];
					var name=game[nametile].unit;
					//trace("uname:"+unitname+"udir:"+units[unitname].dir+",Dir:"+dir+",P0:"+path[0][0]+",P1:"+path[0][1]+",nameT:"+nametile+",name:"+name);
					//Animacion ataque
					visualizar(unitname,2,dir);
					//Muerte del atacado
					visualizar(name,3,units[name].direccion);
					//Desaparicion del muerto y ocupacion de su casilla.
					var myTwDead:Tween = new Tween(units[name], "_alpha", None, 100, 5, 1, true);
					myTwDead.onMotionFinished = function(){
						//Eliminamos al muerto
						units[name].removeMovieClip();
						units[name]=null;
						//Ocupamos casilla.
						//game[tilefin].unit=0;
						game[nametile].unit=0;
						//_root.debug("MATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
						//_root.debug("playerElim:"+game.playerEliminado+",EjEliminado:"+game.ejEliminado);
						if(game.ejEliminado!=null && game.playerEliminado!=null){
							SuicidioColectivo(game.playerEliminado,game.ejEliminado,false);
						}
						/*var descubre=DescubreUnidad(unitname,path[0][0],path[0][1],0);
						if(units[unitname].ejercito==jugador.ejercito){
							CompruebaOcultos(unitname,path[0][0],path[0][1]);
							if(units[unitname].tipounit==tipounit[1] && game[tilefin].type=="Bosque"){
								if(descubre==true){
									DescubreInfanteria(unitname);
								}
							}
						}
						if(units[unitname].tipounit==tipounit[1] && units[unitname]._alpha<10){
							DescubreInfanteria(unitname);
						}*/
						mueveUnit(unitname,path, paso[0], paso[1],path[0][0],path[0][1]);
					}
				}
			}
		}else{ //Ataque
			//trace("Ataquerrr");
			var tileini="tile"+xini+"_"+yini;
			var tilefin="tile"+xfin+"_"+yfin;
			var dir=encararUnit(xini,yini,xfin,yfin);
			var nametile="tile"+path[0][0]+"_"+path[0][1];
			var name=game[nametile].unit;
			trace("Ataque, Tileini:"+tileini+",unit:"+game[tileini].unit+",Tilefin:"+tilefin+",unit:"+game[tilefin].unit+",nametile:"+nametile+",unit:"+game[nametile].unit);
			
			/*game[tileini].unit=units[unitname].valortile;
			units[unitname].valortile=game[tilefin].unit;
			game[tilefin].unit=unitname;
			trace("Cambio, Tileini:"+tileini+",unit:"+game[tileini].unit+",Tilefin:"+tilefin+",unit:"+game[tilefin].unit+",nametile:"+nametile+",unit:"+game[nametile].unit);
			units[unitname].tile=tilefin;
			units[unitname].tilex=xfin;
			units[unitname].tiley=yfin;*/
			var depth = calculaDepth(xfin, yfin)+6;
			units[unitname].swapDepths(depth);
			/*
			if(units[name].ejercito!=jugador.ejercito){
				if(game[nametile].type=="Bosque"){
					if(units[name]._alpha<10){
						var TwOcultar:Tween = new Tween(units[name], "_alpha", None, 5, 100, 0.2, true);
					}
				}
			}*/
			visualizar(unitname,2,dir);
			visualizar(name,3,units[name].direccion);
			var myTwDead:Tween = new Tween(units[name], "_alpha", None, 100, 5, 1, true);
			myTwDead.onMotionFinished = function(){
				//Eliminamos al muerto
				units[name].removeMovieClip();
				units[name]=null;
				//Ocupamos casilla.
				//game[tilefin].unit=0;
				game[nametile].unit=0;
				//_root.debug("MATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
				//_root.debug("playerElim:"+game.playerEliminado+",EjEliminado:"+game.ejEliminado);
				if(game.ejEliminado!=null && game.playerEliminado!=null){
					SuicidioColectivo(game.playerEliminado,game.ejEliminado,false);
				}
				/*var descubre=DescubreUnidad(unitname,path[0][0],path[0][1],0);
				if(units[unitname].ejercito==jugador.ejercito){
					CompruebaOcultos(unitname,path[0][0],path[0][1]);
					if(units[unitname].tipounit==tipounit[1] && game[tilefin].type=="Bosque"){
						if(descubre==true){
							DescubreInfanteria(unitname);
						}
					}
				}
				if(units[unitname].tipounit==tipounit[1] && units[unitname]._alpha<10){
					DescubreInfanteria(unitname);
				}*/
				
				trace("Dead, Tileini:"+tileini+",unit:"+game[tileini].unit+",Tilefin:"+tilefin+",unit:"+game[tilefin].unit+",nametile:"+nametile+",unit:"+game[nametile].unit);
				trace("path:"+path+",Xini:"+xini+",yini:"+yini+",path00:"+path[0][0]+",path01:"+path[0][1]);
				mueveUnit(unitname,path, xini, yini, path[0][0], path[0][1]);
				//mueveUnit(unitname,path, paso[0], paso[1],path[0][0],path[0][1]);
			}
		}
	}
}

function disparaUnit(unitname, xobj:Number, yobj:Number){
	var nametile="tile"+xobj+"_"+yobj;
	var name=game[nametile].unit;
	//_root.debug("Disparo de "+unitname+", NTile:"+nametile+", objetivo:"+name);
	var dir=encararUnit(units[unitname].tilex,units[unitname].tiley,xobj,yobj);
	visualizar(unitname,2,dir);
	visualizar(name,3,units[name].direccion);
	var myTwDead:Tween = new Tween(units[name], "_alpha", None, 100, 5, 1, true);
	myTwDead.onMotionFinished = function(){
		//Eliminamos al muerto
		units[name].removeMovieClip();
		units[name]=null;
		//Vaciamos casilla.
		game[nametile].unit=0;
		visualizar(unitname,0,dir);
		//_root.debug("MATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		//_root.debug("playerElim:"+game.playerEliminado+",EjEliminado:"+game.ejEliminado);
		if(game.ejEliminado!=null && game.playerEliminado!=null){
			SuicidioColectivo(game.playerEliminado,game.ejEliminado,false);
		}
		if(jugador.turno==game.turno){
			CambiaTurno();
		}
	}
}

function CambiaTurno(){
	//Envia señal de cambio de turno.
	var resObj={};
	//resObj.ejercito_sel=jugador.ejercito;
	_root.sendXtMsg ("CambioTurno", resObj);
}

function calculaCamino(unitname,x:Number, y:Number){
	//inicio
	astar.s.x = units[unitname].tilex;
	astar.s.y = units[unitname].tiley;
	//destino
	astar.g.x = x;
	astar.g.y = y;
	astar.tileini=units[unitname].tile
	var path = astar.search();
	//trace(path);
	return path;
}

function limpiaRango(){
	for(var x=0;x<12;x++){
		for(var y=0;y<12;y++){
			mapaRangos[x][y]=0;
		}
	}
	//trace("MapaRangos: "+mapaRangos);
}

function acualizaRango(){
	//Hace visible el rango en pantalla.
	//trace(mapaRangos);
	//_root.debug("MapaRangos:"+mapaRangos);
	var name;
	var valor;
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			name="rango"+x+"_"+y;
			valor=mapaRangos[x][y];
			//name="rango"+a+"_"+b;
			//_root.debug("rango:"+name+",ob:"+game[name]+",visible:"+game[name]._visible+"mRangos:"+mapaRangos[x][y]);
			if(valor==0 || valor==2){
				game[name]._visible=false;
			}else if(valor>0){
				game[name]._visible=true;
			}
		}
	}
}

function CompruebaRango(){
	//Comprueba si una unidad enemiga dentro del rango de movimiento esta rodeada o
	//tiene algun espacio vacio alrededor. Si esta rodeada la elimina del rango.
	//trace("CompruebaRangos");
	var name;
	var valor;
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			name="rango"+x+"_"+y;
			valor=mapaRangos[x][y];
			//_root.debug("rango:"+name+",ob:"+game[name]+",visible:"+game[name]._visible+"mRangos:"+mapaRangos[x][y]);
			if(valor==3){
				//trace("name:"+name);
				//Unidad enemiga, comprobamos si es valida.
				valida=0;
				for(var n=0;n<4;n++){
					rx=x+rank[n][0];
					ry=y+rank[n][1];
					if(rx>=0 && rx<12 && ry>=0 && ry<12){
						if(mapaRangos[rx][ry]<2){
							valida=1;
						}
					}
				}
				if(valida==0){
					mapaRangos[x][y]=0;
				}
			}
		}
	}
}

function limpiaRTiro(){
	for(var x=0;x<12;x++){
		for(var y=0;y<12;y++){
			RangoTiros[x][y]=0;
		}
	}
}

function acualizaRTiro(){
	//trace(mapaRangos);
	for(var a=0;a<12;a++){
		for(var b=0;b<12;b++){
			var name="tiro"+a+"_"+b;
			if(RangoTiros[a][b]==0){
				game[name]._visible=false;
			}else if(mapaRangos[a][b]==0){
				game[name]._visible=true;
			}
		}
	}
}

function calculaRTiro(x:Number, y:Number, r:Number){
	//r = Rango movimiento.
	//trace("calcularango:"+x+","+y+","+r);
	//trace("Coste:"+astar.cost(unit.select,x,y)+",X:"+x+",Y:"+y);
	//trace(units.select);
	var coste=0;
	var caminos=[0,0,0,0,0];
	if(r>0 && x>=0 && x<12 && y>=0 && y<12){
		for(var n=0;n<rank.length;n++){
			var tipo=mapa[y+rank[n][1]][x+rank[n][0]];
			//coste=astar.cost(units.select,x+rank[n][0],y+rank[n][1]);
			coste=1;
			//trace("R:"+r+",coste:"+coste+",r-coste:"+Number(r-coste)+",tipo:"+tipo);
			if(r-coste>=0){
				RangoTiros[x+rank[n][0]][y+rank[n][1]]=1;
				caminos[n]=coste;
				//r-=coste;
				calculaRTiro(x+rank[n][0],y+rank[n][1],r-coste);
			}
			//trace("tipo:"+tipo);
		}
	}
	/*trace("Coste:"+coste);
	r-=coste;
	if(r>0 && x>=0 && x<12 && y>=0 && y<12){
		for(var n=0;n<rank.length;n++){
			if(caminos[n]!=0){
				
			}
			var tipo=mapa[y+rank[n][1]][x+rank[n][0]];
			switch(tipo){
				case 1: if(r>0){
									calculaRango(x+rank[n][0],y+rank[n][1],r);
								}
								break;
				case 2: if(r>0){
									calculaRango(x+rank[n][0],y+rank[n][1],r);
								}
								break;
				case 3: if(r>0){
									calculaRango(x+rank[n][0],y+rank[n][1],r);
								}
								break;
				case 4: if(r>0){
									calculaRango(x+rank[n][0],y+rank[n][1],r);
								}
								break;
			}
		}
	}*/
}

/*function calculaRango2(x:Number, y:Number, r:Number){
	//r = Rango movimiento.
	//trace("calcularango:"+x+","+y+","+r);
	//trace("Coste:"+astar.cost(unit.select,x,y)+",X:"+x+",Y:"+y);
	//trace(units.select);
	var coste=0;
	//var caminos=[0,0,0,0,0];
	if(r>0 && x>=0 && x<12 && y>=0 && y<12){
		for(var n=0;n<rank.length;n++){
			//var tipo=mapa[y+rank[n][1]][x+rank[n][0]];
			coste=astar.cost(units.select,x+rank[n][0],y+rank[n][1]);
			//trace("R:"+r+",coste:"+coste+",r-coste:"+Number(r-coste)+",tipo:"+tipo);
			if(r-coste>=0){
				//caminos[n]=coste;
				//r-=coste;
				var nametile="tile"+x+"_"+y;
				var uname=game[nametile].unit;
				//_root.debug("NTile:"+nametile+",UName:"+uname);
				if(uname!=0 && uname!=null){
					
					//_root.debug("UnameEj:"+units[uname].ejercito+"JEj:"+jugador.ejercito);
					if(units[uname].ejercito==jugador.ejercito){
						mapaRangos[x+rank[n][0]][y+rank[n][1]]=0;
						calculaRango(x+rank[n][0],y+rank[n][1],r-coste);
					}/*else{
						mapaRangos[x+rank[n][0]][y+rank[n][1]]=0;
						calculaRango(x+rank[n][0],y+rank[n][1],r-coste);
					}*//*
				}else{
					mapaRangos[x+rank[n][0]][y+rank[n][1]]=1;
					calculaRango(x+rank[n][0],y+rank[n][1],r-coste);
				}
			}
			//trace("tipo:"+tipo);
		}
	}
}*/

function calculaRango(x:Number, y:Number, r:Number){
	if(x>=0 && x<12 && y>=0 && y<12){
		// Comprovamos la actual
		var nametile="tile"+x+"_"+y;
		var uname=game[nametile].unit;
		//trace("Rangonametile:"+nametile+",uname:"+uname);
		if (uname!=0 && uname!=null)
		{
			//trace("Unitname:"+uname+",EjerJug:"+jugador.ejercito+",valorRang:"+mapaRangos[x][y]);
			if(units[uname].ejercito==jugador.ejercito){
				//Unidad amiga
				mapaRangos[x][y]=2;
			}else{
				//Unidad enemiga
				mapaRangos[x][y]=3;
				r=0;
			}
		}
		else
		{
			//Camino libre
			mapaRangos[x][y]=1;
		}
		//trace("valorRang:"+mapaRangos[x][y]);
		var coste;//=astar.cost(units.select,x,y);
		//trace("R:"+r);
		if (r<=0)
			return;
		// Comprovamos las siguientes //rank.length
		var rx=-1;
		var ry=-1;
		for(var i:Number=0;i<4;i++){
			rx=x+rank[i][0];
			ry=y+rank[i][1];
			if(rx>=0 && rx<12 && ry>=0 && ry<12){
				coste=astar.cost(units.select,rx,ry);
				var n=r-coste;
				//trace("Coste:"+coste+"R:"+r+",R-coste:"+n+",RX:"+rx+",RY:"+ry);
				if(n>=0){
					calculaRango(x+rank[i][0],y+rank[i][1],n); 
				}
			}
		}
	}
}

function DespejaCaminoAtaque(x,y,atacante){
	//Si las casillas alrededor de la unidad atacada estan ocupadas pero eran 
	//elejibles como destino las elimina para evitar que se ataque desde alli.
	var name;
	var tileAtac=units[atacante].tile;
	for(var n=0;n<4;n++){
		rx=x+rank[n][0];
		ry=y+rank[n][1];
		if(rx>=0 && rx<12 && ry>=0 && ry<12){
			//trace("Adyacentes:"+mapaRangos[rx][ry]+",valorR:"+mapaRangos[rx][ry]);
			name="tile"+rx+"_"+ry;
			//trace("TileAtac:"+tileAtac+",nametile:"+name);
			if(mapaRangos[rx][ry]>1 && name!=tileAtac){
				mapaRangos[rx][ry]=0;
			}
			//trace("Despues:"+mapaRangos[rx][ry]);
		}
	}
	//trace("MapaRangosFinAtaque: "+mapaRangos);
}

//Ocultar/Descubrir Infanteria en bosque
function OcultaInfanteria(unitname){
	//Oculta a la unidad
	if(units[unitname].oculta==false){
		if(units[unitname].ejercito!=jugador.ejercito){
			var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 100, 5, 0.2, true);
		}else{
			var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 100, 80, 0.2, true);
		}
		units[unitname].oculta=true;
	}
}

function DescubreInfanteria(unitname){
	//Descubre a la unidad
	if(units[unitname].oculta==true){
		if(units[unitname].ejercito!=jugador.ejercito){
			var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 5, 100, 0.2, true);
		}else{
			var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 80, 100, 0.2, true);
		}
		units[unitname].oculta=false;
	}
}

/*function SeparaOcultos(unidad,x,y){
	//Vuelve a ocultar a las unidades descubiertas
	//cuando se separa la unidad de ellas.
	var nametile;
	var rx;
	var ry;
	var unitname;
	for(var r=0;r<4;r++){
		rx=x+rank[r][0];
		ry=y+rank[r][1];
		nametile="tile"+rx+"_"+ry;
		if(game[nametile].type=="Bosque"){
			unitname=game[nametile].unit;
			if(units[unitname].tipounit==tipounit[1]){
				var descubre=DescubreUnidad(unitname,rx,ry,unidad);
				if(descubre==false){
					OcultaInfanteria(unitname);
				}
			}
		}
	}
}*/

function DescubreUnidad(unitOculta,x,y,unidad){
	//Comprueba si hay alguna unidad enemiga alrededor de la unidad oculta
	//"unidad" vale diferente de cero cuando la funcion es llamada desde SeparaOcultos
	//(una unidad enemiga se separa de esta unidad)
	var nametile;
	var rx;
	var ry;
	var unitname;
	var enemigos=false;
	trace("DescubreU, unitO:"+unitOculta+",X:"+x+",Y:"+y+"u,nidad:"+unidad+",enemigos:"+enemigos);
	for(var r=0;r<4;r++){
		rx=x+rank[r][0];
		ry=y+rank[r][1];
		nametile="tile"+rx+"_"+ry;
		unitname=game[nametile].unit;
		trace("nametile:"+nametile+",unitname:"+unitname);
		if(rx>=0 && rx<12 && ry>=0 && ry<12){
			if(unitname!=0){
				if(unitname!=unitOculta){
					if(units[unitname].ejercito!=units[unitOculta].ejercito){
						if(unidad!=0 && unidad!=unitname){
							enemigos=true;
						}else if(unidad==0){
							enemigos=true;
						}
						trace("enemigos:"+enemigos);
					}
				}
			}
		}
	}
	trace("Enemigos?:"+enemigos);
	return enemigos;
	
	/*if(enemigos==true){
		DescubreInfanteria(unitOculta);
	}else{
		nametile=game[unitOculta].unit;
		if(game[nametile].type=="Bosque"){
			OcultaInfanteria(unitOculta);
		}
	}*/

}

/*function CompruebaOcultos(unidad,x,y){
	//trace("CompruebaOc. Unit:"+unidad+",x:"+x+",y:"+y);
	var nametile;
	var unitname;
	var ejercit=units[unidad].ejercito;
	var rx:Number=-1;
	var ry:Number=-1;
	for(var r=0;r<4;r++){
		rx=x+rank[r][0];
		ry=y+rank[r][1];
		nametile="tile"+rx+"_"+ry;
		//trace("NametileOcultos:"+nametile+",rx:"+rx+",ry:"+ry+",Tipo:"+game[nametile].type);
		if(game[nametile].type=="Bosque"){
			unitname=game[nametile].unit;
			//trace("UnitnameOculta:"+unitname+",tipounit:"+units[unitname].tipounit);
			if(unitname!=0 && units[unitname].tipounit==tipounit[1]){
				if(units[unitname].ejercito!=ejercit){
					if(units[unitname]._alpha<10){
						DescubreInfanteria(unitname);
					}
				}
			}
		}
	}
}*/

function CompruebaInfanteriaOculta(unidad,xini,yini,xfin,yfin){
	trace("CompruebaInfanteriaOculta");
	trace("unidad:"+unidad+",xini:"+xini+",yini:"+yini+",xfin:"+xfin+",yfin:"+yfin);
	var tileini="tile"+xini+"_"+yini;
	var tilefin="tile"+xfin+"_"+yfin;
	var rx;
	var ry;
	var nametile;
	var unitname;
	var descubre=false;
	
	//Comprobacion en tileini
	trace("Comprobamos tileini.");
	for(var r=0;r<4;r++){
		rx=xini+rank[r][0];
		ry=yini+rank[r][1];
		if(rx>=0 && rx<12 && ry>=0 && ry<12){
			nametile="tile"+rx+"_"+ry;
			trace("nametile:"+nametile+",tipo:"+game[nametile].type);
			if(game[nametile].type=="Bosque"){
				unitname=game[nametile].unit;
				if(unitname!=0){
					trace("unidadEj:"+units[unidad].ejercito+",unitnameEj:"+units[unitname].ejercito);
					if(units[unitname].ejercito!=units[unidad].ejercito){
						trace("unitnameTipo:"+units[unitname].tipounit);
						if(units[unitname].tipounit==tipounit[1]){
							trace("nametile:"+nametile+",tileini:"+tileini+",tilefin:"+tilefin);
							if(nametile!=tileini && nametile!=tilefin){
								trace("unitnameOculta:"+units[unitname].oculta);
								if(units[unitname].oculta==false){
									descubre=DescubreUnidad(unitname,rx,ry,unidad);
									trace("Descubre:"+descubre);
									if(descubre==false){
										OcultaInfanteria(unitname);
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	//Comprobaciones en tilefin
	trace("Comprobamos tilefin.");
	descubre=false;
	trace("tilefin:"+tilefin+",tipo:"+game[tilefin].type);
	if(game[tilefin].type!="Bosque"){
		trace("unidad:"+unidad+",Oculta:"+units[unidad].oculta);
		if(units[unidad].oculta==true){
			DescubreInfanteria(unidad);
		}
		//Comprobamos alrededor
		for(var r=0;r<4;r++){
			rx=xfin+rank[r][0];
			ry=yfin+rank[r][1];
			if(rx>=0 && rx<12 && ry>=0 && ry<12){
				nametile="tile"+rx+"_"+ry;
				unitname=game[nametile].unit;
				trace("nametile:"+nametile+",Tipo:"+game[nametile].type+",unitname:"+unitname);
				if(game[nametile].type=="Bosque"){
					if(unitname!=0){
						trace("unidadEj:"+units[unidad].ejercito+",unitnameEj:"+units[unitname].ejercito);
						if(units[unitname].ejercito!=units[unidad].ejercito){
							trace("tipounit:"+units[unitname].tipounit+",oculta:"+units[unitname].oculta);
							if(units[unitname].tipounit==tipounit[1]){
								if(units[unitname].oculta==true){
									DescubreInfanteria(unitname);
								}
							}
						}
					}
				}
			}
		}
	}else if(game[tilefin].type=="Bosque"){
		for(var r=0;r<4;r++){
			rx=xfin+rank[r][0];
			ry=yfin+rank[r][1];
			if(rx>=0 && rx<12 && ry>=0 && ry<12){
				nametile="tile"+rx+"_"+ry;
				unitname=game[nametile].unit;
				trace("nametile:"+nametile+",unitname:"+unitname);
				if(unitname!=0){
					trace("unidadEj:"+units[unidad].ejercito+",unitnameEj:"+units[unitname].ejercito);
					if(units[unitname].ejercito!=units[unidad].ejercito){
						trace("tipounit:"+units[unitname].tipounit+",oculta:"+units[unitname].oculta);
						if(units[unitname].tipounit==tipounit[1]){
							if(units[unitname].oculta==true){
								DescubreInfanteria(unitname);
							}
						}
						descubre=true;
					}
				}
			}
		}
		if(units[unidad].tipounit==tipounit[1]){
			trace("Descubre:"+descubre+",unidadOculta:"+units[unidad].oculta);
			if(descubre==true){
				if(units[unidad].oculta==true){
					DescubreInfanteria(unidad);
				}
			}else if(descubre==false){
				if(units[unidad].oculta==false){
					OcultaInfanteria(unidad);
				}
			}
		}
	}
}

/*function CompruebaOcultos(unidad,x,y,descubrir){
	var nametile;
	var unitname;
	var ejercit=units[unidad].ejercito;
	var rx:Number=-1;
	var ry:Number=-1;
	//trace("X:"+x+",Y:"+y);
	for(var nR=0;nR<4;nR++){
		rx=x+rank[nR][0];
		ry=y+rank[nR][1];
		nametile="tile"+rx+"_"+ry;
		//trace("NametileOcultos:"+nametile+",rx:"+rx+",ry:"+ry+",Tipo:"+game[nametile].type);
		if(game[nametile].type=="Bosque"){
			unitname=game[nametile].unit;
			trace("UnitnameOculta:"+unitname);
			if(unitname!=0){
				if(descubrir==true && units[unitname]._alpha<10){
					DescubreInfanteria(unitname);
					//nameTw="TwOcultarOculT"+nR;
					//game[nameTW]=  new Tween(units[unitname], "_alpha", None, 5, 100, 0.2, true);
					//var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 5, 100, 0.2, true);
				}else if(descubrir==false && units[unitname].ejercito!=ejercit){
					if(units[unitname].tipounit==tipounit[1]){
						if(units[unitname]._alpha>10){
							OcultaInfanteria(unitname);
							//nameTw="TwOcultarOculF"+nR;
							//game[nameTW]= new Tween(units[unitname], "_alpha", None, 100, 5, 0.2, true);
							//var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 100, 5, 0.2, true);
						}
					}
				}
			}
		}
	}
}*/

/*function descubreUnidad(unitname,x,y){
	var nametile;
	var unitenemy;
	var rx:Number=-1;
	var ry:Number=-1;
	var nameTw;
	for(var dR=0;dR<4;n++){
		rx=x+rank[dR][0];
		ry=y+rank[dR][1];
		nametile="tile"+rx+"_"+ry;
		unitenemy=game[nametile].unit;
		if(units[unitenemy].ejercito!=units[unitname].ejercito && units[unitname]._alpha<10){
			nameTw="TwOcultarDes"+dR;
			game[nameTW]= new Tween(units[unitname], "_alpha", None, 5, 100, 0.2, true);
			//var TwOcultar:Tween = new Tween(units[unitname], "_alpha", None, 5, 100, 0.2, true);
		}
	}
}*/
//Fin de Ocultar/Descubrir Infanteria en bosque

function LimpiaPartida(){
	var name;
	for(var y=0;y<12;y++){
		for(var x=0;x<12;x++){
			//game.depth+=5;
			name="tile"+x+"_"+y;
			removeMovieClip(game[name]);
			delete game[name];
			name="rango"+x+"_"+y;
			removeMovieClip(game[name]);
			delete game[name];
			name="tiro"+x+"_"+y;
			removeMovieClip(game[name]);
			delete game[name];
		}
	}
	removeMovieClip(game.marcador);
	delete game.marcador;
	removeMovieClip(game.flechaMarca);
	delete game.flechaMarca;

	//delete game;
	//delete tipo_units;
	
	for(var e=0;e<game.ejercitos_sel.length;e++){
		for(var n=0;n<game.unidades[e].length;n++){//game.ejercito.length
				name="unit_"+game.ejercitos_sel[e]+"_"+n;
				removeMovieClip(units[name]);
				delete units[name];
		}
	}
	//delete units;

	//delete jugador;
}






















