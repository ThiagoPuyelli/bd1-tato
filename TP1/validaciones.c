#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#define MAXIMA 30

bool conversionCharPunto4(char *);


void pedirChar(char *string) {
    bool conversionCorrecta = true;
    do{
        fgets(string, MAXIMA, stdin);
        conversionCorrecta = conversionCharPunto4(string);
        fflush(stdin);
        if (!conversionCorrecta){
            printf("Dato invalido, intente nuevamente.\n");
            printf("Ingrese nuevamente: ");
        }
    } while (!conversionCorrecta);
}

bool conversionEntero(char *string, int *nro, int len) {
    int i = 0;
    // Contar la cantidad de espacios.
    while(isspace(string[i]))
        i++;
    // Controlar cadena vacia.
    if (len == i) return false;

    char * buffer = malloc(sizeof(char)*len);
    int indiceEntero = 0;

    // Controlar si es un numero negativo.
    if (string[i] == '-'){
        buffer[indiceEntero] = '-';
        indiceEntero++;
        i++;

        if (!isdigit(string[i])) return false;
    }

    // Leer los digitos.
    while (i < len && !isspace(string[i])){
        if (!isdigit(string[i])) return false;
        buffer[indiceEntero] = string[i];
        indiceEntero++;
        i++;
    }
    
    // Agregar el caracter nulo al final del string.
    buffer[indiceEntero] = '\0';

    // Termino de recorrer el string.
    while (isspace(string[i]))
        i++;
    
    // Si hay mas para recorrer y no son blancos, el string contiene otros caracteres.
    if (string[i] != '\0') return false;
    
    // Convierto el string a un entero.
    *nro = atoi(buffer);
    
    return true;
}

// Se pide un entero al usuario y se valida que sea correcto.
void pedirDatos(int *nro, int tamanio) {
    bool conversionCorrecta = true;
    do{
        char * bufferNro = malloc(sizeof(char) * tamanio);
        fgets(bufferNro, tamanio, stdin);
        conversionCorrecta = conversionEntero(bufferNro, nro, tamanio);
        if (!conversionCorrecta){
            printf("El numero es invalido, revisa los requerimientos\n");
            printf("Ingrese otro numero: ");
            fflush(stdin);
        }
    } while (!conversionCorrecta);
}

// Recibe un entero y valida que se encuentre en el rango especificado.
void rango(int *nro, int rango) {
    while (abs(*nro) > rango){
        printf("El numero ingresado debe estar comprendido en [-9999;9999], intente nuevamente.\n");
        pedirDatos(nro, 11);
    }
}

void strtrim(char *cadena) {
    char *comienzoDeCadena = cadena;
    char *finalDeCadena = cadena + strlen(cadena) - 1;
    while (isspace(*comienzoDeCadena)) {
        comienzoDeCadena++;
    }
    while (isspace(*finalDeCadena) && finalDeCadena >= comienzoDeCadena) {
        finalDeCadena--;
    }
    *(finalDeCadena + 1) = '\0';
    memmove(cadena, comienzoDeCadena,   finalDeCadena - comienzoDeCadena + 2);
}

bool conversionCharPunto4(char *string) {
    int tamanio=strlen(string)-1;   //consigo el tamanio del array para usarlo en el for y saber si está vacia o no
    if(tamanio>=MAXIMA){
        return false;
    }
    int i=0;

    string[tamanio]='\0'; //quito el \n puesto por el fgets en la ultima linea
    if(strlen(string)==0){
        return false;
    }

    for(i; i<tamanio; i++) {
        if (!((string[i]>=65) && (string[i]<=90)) && !((string[i]>=97) && (string[i]<=122))){ //Si no esta entre los digitos ascii de 0 a 9 tira mensaje de error
            return false;
        }
    }
    return true;
}