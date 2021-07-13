import src.geom.ColorMatrix;

// ------------------------- GESTION DE AVATARES -----------------------

//gestion de señas
function showSign(signID,player_index){
	_root.debug("showSign: signID="+signID+" player_index="+player_index);
	clearTimeout(signTimeout);
	showAvatar(player_index);
	var pos=rotatedUserMatrix[player_index];	
	var player_mc=avatars[pos];
	switch(signID){
		
		//espadón
		case 1:
			player_mc.eyebrows_mc._y=37.5;
		break;
		
		//guiñar ojo dcho
		case 2:
			player_mc.eye_r_mc.gotoAndStop("gesture");
		break;
		
		//guiñar ojo izqdo
		case 3:
			player_mc.eye_l_mc.gotoAndStop("gesture");
		break;
		
		//guiñar ambos ojos
		case 4:
			player_mc.eye_r_mc.gotoAndStop("gesture");
			player_mc.eye_l_mc.gotoAndStop("gesture");
		break;
		
		//hinchar mofletes
		case 5:
			player_mc.face_mc.mofletes_mc.gotoAndPlay(2);
			player_mc.mouth_mc.gotoAndStop("gesture6");
		break;
		
		//lengua dcha
		case 6:
			player_mc.mouth_mc.gotoAndStop("gesture2");
		break;
		
		//lengua izqda
		case 7:
			player_mc.mouth_mc.gotoAndStop("gesture1");
		break;
		
		//morder labios
		case 8:
			player_mc.mouth_mc.gotoAndStop("gesture3");
		break;
		default:
		break;
	}	
	signInterval=setTimeout(this,"showAvatar",2000,[player_index]);
}

//randomiza datos de avatar y los devuelve como avatardata
function randomizeAvatarData(player_mc:MovieClip):Object{
	var avatardata={};
	avatardata.faces=[];
	var parts=getParts(player_mc);
	for(var i=0;i<parts.length;i++){
		avatardata.faces[i]=random(parts[i].numVariants);
	}
	avatardata.colors=[randomizeColor(),randomizeColor(),randomizeColor(),randomizeColor(),randomizeColor()];
	return avatardata;
}

//muestra un avatar en un clip de pelicula
function showAvatar(player_mc:MovieClip,avatardata:Object){	
	if(!avatardata){
		avatardata=randomizeAvatarData(player_mc);		
	}		
	var parts=getParts(player_mc);
	player_mc.face_mc.mofletes_mc.gotoAndStop(1);
	player_mc.name_txt.text=playerNames[player_index];
	player_mc.eyebrows_mc._y=47.5;
	_root.debug("showAvatar: avatardata.colors="+avatardata.colors+" avatardata.faces="+avatardata.faces);
	for(var i=0;i<parts.length;i++){
		var part=parts[i];		
		setPartFace(part,avatardata.faces[i]);		
		setPartColor(part,avatardata.colors[part.colorID]);
	}		
	player_mc._visible=true;
}

//obtiene datos de los clips de pelicula involucrados en cada parte del cuerpo
function getParts(player_mc:MovieClip){
	var parts=[];
	//orden --> ojos, cara, orejas, nariz, cejas, boca, pelo, camiseta 
	var part={};
	part.id=lang["ojos"];
	part.isEyes=true;
	part.player_movies=[player_mc.eye_r_mc,player_mc.eye_l_mc];	
	part.color_movies=[player_mc.eye_r_mc,player_mc.eye_l_mc];
	part.colorID=0;	
	part.numVariants=8;
	parts.push(part.clone());
	
	part.isEyes=false;
	part.id=lang["cara"];
	part.player_movies=[player_mc.face_mc];
	part.color_movies=[player_mc.ear_r_mc,player_mc.ear_l_mc,player_mc.face_mc,player_mc.body_mc,player_mc.nose_mc];
	part.colorID=1;
	part.numVariants=8;
	parts.push(part.clone());
	
	part.id=lang["orejas"];
	part.player_movies=[player_mc.ear_r_mc,player_mc.ear_l_mc];
	part.color_movies=[player_mc.ear_r_mc,player_mc.ear_l_mc,player_mc.face_mc,player_mc.body_mc,player_mc.nose_mc];
	part.numVariants=9;
	part.colorID=1;
	parts.push(part.clone());
	
	part.id=lang["nariz"];
	part.player_movies=[player_mc.nose_mc];
	part.color_movies=[player_mc.ear_r_mc,player_mc.ear_l_mc,player_mc.face_mc,player_mc.body_mc,player_mc.nose_mc];
	part.colorID=1;
	part.numVariants=9;
	parts.push(part.clone());
	
	
	part.id=lang["cejas"];
	part.player_movies=[player_mc.eyebrows_mc];
	part.color_movies=[player_mc.eyebrows_mc];
	part.colorID=2;
	part.numVariants=9;
	parts.push(part.clone());
	
	part.id=lang["boca"];
	part.player_movies=[player_mc.mouth_mc];
	part.color_movies=[];
	part.colorID=3;
	part.numVariants=8;
	parts.push(part.clone());
	
	part.id=lang["pelo"];
	part.player_movies=[player_mc.hair_mc,player_mc.highlight_mc];
	part.color_movies=[player_mc.hair_mc];
	part.colorID=2;
	part.numVariants=12;
	parts.push(part.clone());
	
	part.id=lang["camisa"];
	part.player_movies=[player_mc.shirt_mc];
	part.color_movies=[player_mc.shirt_mc];
	part.colorID=4;
	part.numVariants=8;
	parts.push(part.clone());
	return parts;
}	
	
	
//establece el color de una parte del cuerpo
function setPartColor(part:Object, color:Number){			
	for(var i in part.color_movies){
		var movie_mc=part.color_movies[i];
		if(part.isEyes){
			setTintColor(movie_mc.pupila_mc, color);		
		}else{
			setTintColor(movie_mc,color);
		}		
	}	
}

//establece la forma de una parte del cuerpo
function setPartFace(part,faceID){	
	for(var i in part.player_movies){
		part.player_movies[i].gotoAndStop(faceID+1);
	}	
}


///////////////// TINTS ////////

////////////////////////////////////////////////////////////////////
//////////////////////// COMUN A TODOS LOS JUEGOS /////////////////

function randomizeColor(){
    var _loc1 = 983040;
    _loc1 = _loc1 + random(15006457);
    return (_loc1);
} 


function setTintColor(clip:MovieClip, c:Number){
	//_root.debug("setTintColor clip="+clip+" c="+c);
    var _loc1 = c;
    var r = (_loc1 >> 16 & 255) / 255;
    var g = (_loc1 >> 8 & 255) / 255;
    var b = (_loc1 & 255) / 255;
    var _loc3 = new flash.geom.ColorTransform();
    _loc3.rgb = _loc1;    
    var _loc2 = new src.geom.ColorMatrix();
    _loc2.colorize(_loc1, 1);
    clip.filters = [new flash.filters.ColorMatrixFilter(_loc2.matrix)];
} 


function colorize(target:MovieClip,matrix2:Array){		
	var filter = new ColorMatrixFilter(matrix2);
	target.filters=new Array(filter);
}

