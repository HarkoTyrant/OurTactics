astar = {};

astar.initialize = function(){
	//trace("astar,this:"+this);
	this.solidOb = {solid:true, exists:true};
	this.maxSearchTime = 5000;
	this.s = {};
	this.g = {};
	this.open = [];
	this.closed = [];
	this.nodes = {};
	this.preventClipping = true;
}

astar.findHeuristic = function(x, y){
	var dx = Match.round(Math.abs(x-this.g.x));/*Math.abs(x-this.g.x);*/
	var dy = Match.round(Math.abs(y-this.g.y));/*Math.abs(y-this.g.y);*/
	var val1 = Math.min(dx, dy)*1.41;
	var val2 = Math.max(dx, dy)-Math.min(dx, dy);
	return val1+val2;
}

//astar.cost = function(who, newx, newy) {
astar.cost = function(nameunit, newx, newy){
	var val:Number = 100;
	var tipomov=units[nameunit].typemov;
	//trace(tipomov);
	//var name="tile"+who.x+"_"+who.y;
	//var nameunit=game[astar.tileini].unit;
	//trace("UNIT:"+game[astar.tileini].unit+",tile:"+astar.tileini+",typemov:"+units[nameunit].typemov);
	var name="tile"+newx+"_"+newy;
	//trace("UNIT2:"+game[name].unit);
	//_root.debug("UnitFin: luego");
	//_root.debug("UnitFin:"+astar.unitfin);
	switch(game[name].type){
		case "Normal":	val=1;
										break;
		case "Mountain":	if(tipomov=="Volar"){
												//units[game[astar.tileini].unit].typemov=="Volar"
												val=1;
											}else if(tipomov!="Volar"){
												//units[game[astar.tileini].unit].typemov
												val=2;
											}
											break;
		case "Bosque":	if(tipomov=="Volar"){
											//units[game[astar.tileini].unit].typemov
											val=1;
										}else if(tipomov!="Volar"){
											//units[game[astar.tileini].unit].typemov
											val=2;
										}
										break;
		case "Water": if(tipomov=="Nadar"){
										//units[game[astar.tileini].unit].typemov
										val=1/2;
									}else if(tipomov=="Volar"){
										//units[game[astar.tileini].unit].typemov
										val=1;
									}else if(tipomov=="Andar"){
										//units[game[astar.tileini].unit].typemov
										val=10;
									}
									break;
		case "Muro": if(tipomov=="Volar"){
										val=1;
									}else if(units[nameunit].ejercito==game[name].ejercito){
										val=1;
									}else{
										val=10;
									}
									break;
	}
	//trace("Coste:"+val);
	return val;
}

astar.checkNode = function(newx, newy, whoName){
	var who = this.nodes[whoName];
	var name = "node"+newx+"_"+newy;
	//var g = who.g+this.cost(who, newx, newy);
	//game[astar.tileini].unit
	var coste:Number=this.cost(units.select, newx, newy);
	var gcoste:Number = who.g+coste;
	/*if(astar.unitfin!=0){
		trace("G:"+gcoste+", newx:"+newx+", newy:"+newy+", nodesG:"+this.nodes[name].g);
	}*/
	if (who.x == this.g.x && who.y == this.g.y){
		this.keepSearching = false;
	}
	if (!this.nodes[name].exists){
		//doesnt exist yet, so add it
		this.addOpen(newx, newy, gcoste, whoName);
	} else /*if (!this.nodes[name].solid)*/{
		//exists already, see if the new g is less than the original g
		if (this.nodes[name].g>gcoste){
			//this is a better g
			var ob = this.nodes[name];
			ob.parent = whoName;
			ob.g = gcoste;
			ob.f = ob.h+gcoste;
			var f = ob.f;
			if (this.nodes[name].where == "open"){
				for (var j = 0; j<this.open.length; ++j) {
					if (this.open[j].name == name){
						this.open.splice(j, 1);
					}
				}
				for (var i = 0; i<this.open.length; ++i){
					if (f<this.open[i].f) {
						//insert before
						this.open.splice(i, 0, ob);
						this.nodes[name] = this.open[i];
						break;
					}
					if (i == this.open.length-1) {
						//add to the end
						this.open.push(ob);
						this.nodes[name] = astar.open[i+1];
						break;
					}
				}
			}
			if (this.nodes[name].where == "closed"){
				//Remove it from closed
				for (var j = 0; j<this.closed.length; ++j){
					if (this.closed[j].name == name){
						this.closed.splice(j, 1);
					}
				}
			}
		}
	}
}

astar.buildPath = function(name){
	var name = "node"+this.g.x+"_"+this.g.y;
	var parent = this.nodes[name].parent;
	this.path = [];
	while (parent != null){
		this.path.push([this.nodes[parent].x, this.nodes[parent].y]);
		var parent = this.nodes[parent].parent;
	}
	this.path.reverse();
	this.path.shift();
	this.path.push([this.g.x, this.g.y]);
}

astar.expandNode = function(index){
	var who = this.open[index];
	//counter clockwise
	var nodex = who.x;
	var nodey = who.y;
	var cordx:Number=0;
	var cordy:Number=0;
	var whoName = "node"+nodex+"_"+nodey;
	var tilename;
	var uname;
	//
	for(var n=0;n<4;n++){
		cordx=nodex+rank[n][0];
		cordy=nodey+rank[n][1];
		tilename="tile"+cordx+"_"+cordy;
		uname=_global.game[tilename].unit;
		if(cordx>=0 && cordx<12 && cordy>=0 && cordy<12){
			if(astar.unitfin==0){ //Moviendose
				if(mapaRangos[cordx][cordy]!=3){
					this.checkNode(cordx, cordy, whoName);
				}
			}else if(astar.unitfin!=0){ //Atacando
				if(mapaRangos[cordx][cordy]!=3 || (mapaRangos[cordx][cordy]==3 && uname==astar.unitfin)){
					if(mapaRangos[cordx][cordy]!=0){
						this.checkNode(cordx, cordy, whoName);
					}
				}
			}
		}
		/*if(nodex+1<12){
			this.checkNode(nodex+1, nodey, whoName);
		}
		//this.checkNode(nodex+1, nodey-1, whoName);
		if(nodey-1>=0){
			this.checkNode(nodex, nodey-1, whoName);
		}
		//this.checkNode(nodex-1, nodey-1, whoName);
		if(nodex-1>=0){
			this.checkNode(nodex-1, nodey, whoName);
		}
		//this.checkNode(nodex-1, nodey+1, whoName);
		if(nodey+1<12){
			this.checkNode(nodex, nodey+1, whoName);
		}*/
	}
	//this.checkNode(nodex+1, nodey+1, whoName);
	//move to closed
	var temp = this.open[index];
	temp.where = "closed";
	this.open.splice(index, 1);
	this.closed.push(temp);
	if (!this.keepSearching) {
		this.buildPath();
	}
}

astar.addOpen = function(x, y, g, parent){
	var h = this.findHeuristic(x, y);
	var f = g+h;
	var name = "node"+x+"_"+y;
	var ob = {x:x, y:y, g:g, h:h, f:f, name:name, parent:parent, exists:true, where:"open"};
	if (parent == null){
		this.open.push(ob);
		this.nodes[name] = open[0];
	}
	for (var i = 0; i<this.open.length; ++i){
		if (f<this.open[i].f){
			//insert before
			this.open.splice(i, 0, ob);
			this.nodes[name] = this.open[i];
			break;
		}
		if (i == this.open.length-1){
			//add to the end
			this.open.push(ob);
			this.nodes[name] = astar.open[i+1];
			break;
		}
	}
}

astar.search = function(){
	delete this.path;
	this.now = getTimer();
	this.addOpen(astar.s.x, astar.s.y, 0, null);
	this.keepSearching = true;
	//_root.debug("unitfin:"+astar.unitfin);
	while (this.keepSearching){
		this.expandNode(0);
		if (getTimer()-this.now>this.maxSearchTime){
			//kill search
			trace("no solution");
			this.keepSearching = false;
		}
	}
	st.text = (getTimer()-this.now);
	this.initialize();
	return this.path;
}

astar.initialize();
