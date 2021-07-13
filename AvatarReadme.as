/*---------------------------  AVATAR TEMPLATE ------------------------


Este documento permite generar/visualizar avatares de jugador.

Para visualizar un avatar en un clip de pel�cula avatar_mc se ha de utilizar la funci�n:
showAvatar(avatar_mc,avatardata);

Donde avatardata es un objeto que contiene los datos del avatar.
Si avatardata no est� definido se genera un avatar aleatorio de manera autom�tica.

Los objetos avatardata de los usuarios en el juego se pueden obtener en cualquier momento
de la partida. Es la extensi�n del juego la que decide en qu� momento realiza la llamada
getAvatarData(uId). Lo normal es enviarlos con el mensaje "StartGame" de manera que el juego 
los recibir� en game_client("start").

--------------------------------------------------------------------------*/