#include <stdlib.h>
#include "tipo_elemento.h"

TipoElemento te_crear(int clave){
    TipoElemento te = (TipoElemento) malloc(sizeof(struct TipoElementoRep)); //Creo un struct TipoElemento
    te -> clave = clave; //Asigno al campo clave del struct el parametro clave
    te -> valor = NULL; //Asigno al campo valor la constante NULL
    return te;
}

//Realiza la misma tarea que la funcion anterior con la particularidad de asignar al campo valor del struct 
//el void * que se recibe por paramtero
TipoElemento te_crear_con_valor(int clave, void* valor){
    TipoElemento te = (TipoElemento) malloc(sizeof(struct TipoElementoRep));
    te -> clave = clave;
    te -> valor = valor;
    return te;
}