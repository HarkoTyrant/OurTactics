// mostramos los cuatro avatares

for(var i=0;i<4;i++){
	showAvatar(this["avatar"+i+"_mc"],this["avatardata"+i]); 
	//como this["avatardata"+i] no está definido se muestra un avatar aleatorio
}