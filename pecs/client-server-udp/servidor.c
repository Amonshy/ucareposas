#include  <sys/types.h>
#include  <sys/socket.h>
#include  <netinet/in.h>
#include  <netdb.h>
#include  <stdio.h>
#include  <stdlib.h>

#define DATA "Ella se arrebata, bata bata bata (8)"

/*
  * In the included file <netinet/in.h> a sockaddr_in is defined as follows:
  * struct sockaddr_in {
  *    short sin_family;
  *    u_short      sin_port;
  *    struct in_addr sin_addr;
  *    char sin_zero[8];
  * };
  *
  * This program creates a datagram socket, binds a name to it, then reads
  * from the socket.
  */
int main()
{

       int sock, length;
       struct sockaddr_in name;
       char buf[1024];
	//Para enviar el mensaje
	struct hostent *hp, *gethostbyname();
	char *ip_envio;
	u_short puerto_envio;


       /* Creamos el socket desde el que vamosa a leer */
       sock = socket(AF_INET, SOCK_DGRAM, 0);
       if (sock < 0) {
             perror("Abriendo el socket");
             exit(1);
       }
       /* Creando el nombre del socket */
       name.sin_family = AF_INET;
       name.sin_addr.s_addr = INADDR_ANY;
       name.sin_port = 0;
       if (bind(sock, &name, sizeof(name))) {
             perror("Enlazanda el socket (BIND)");
             exit(1);
       }
       /* Buscando un puerto e impresión de este */
       length = sizeof(name);
       if (getsockname(sock, &name, &length)) {
             perror("Obteniendo el nombre del socket");
             exit(1);
       }
       printf("El puerto del socket abierto es #%d\n", ntohs(name.sin_port));
       /* Leer del socket */
       if (read(sock, buf, 1024) < 0)
             perror("Reciviendo el datagrama");

	/* Obtención de los datos ¿Cómo? Solo falta eso para que se haga en función de lo recivido*/
	ip_envio = "127.0.0.1";
	puerto_envio = 65535;

	printf("-->El mensaje del cliente es: %s\n", buf);
	printf("-->La ip del cliente es: %d\n", ip_envio);
	printf("-->El puerto del cliente es: %u\n", puerto_envio);
	printf("-->El tamaño del mensaje del cliente es: %d\n", sizeof(buf));

	/* Respondemos al cliente */
	printf("-->Estoy contestando\n");
	hp = gethostbyname(ip_envio);  
	if (hp == 0) {
		fprintf(stderr, "%s: Host desconocido",ip_envio);
		exit(2);
	}
	bcopy(hp->h_addr, &name.sin_addr, hp->h_length);
	name.sin_family = AF_INET;
	name.sin_port = htons(puerto_envio);
	/* Send message. */
	if (sendto(sock, DATA, sizeof(DATA), 0, &name, sizeof(name)) < 0)
		perror("Enviando respuesta");
	printf("-->Ya he contestado\n");
       close(sock);
}

