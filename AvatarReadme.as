/*---------------------------  AVATAR TEMPLATE ------------------------


Este documento permite generar/visualizar avatares de jugador.

Para visualizar un avatar en un clip de película avatar_mc se ha de utilizar la función:
showAvatar(avatar_mc,avatardata);

Donde avatardata es un objeto que contiene los datos del avatar.
Si avatardata no está definido se genera un avatar aleatorio de manera automática.

Los objetos avatardata de los usuarios en el juego se pueden obtener en cualquier momento
de la partida. Es la extensión del juego la que decide en qué momento realiza la llamada
getAvatarData(uId). Lo normal es enviarlos con el mensaje "StartGame" de manera que el juego 
los recibirá en game_client("start").

--------------------------------------------------------------------------*/