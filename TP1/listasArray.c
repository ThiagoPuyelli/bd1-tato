#include <stdio.h>
#include <stdlib.h>
#include "listas.h"
#include "tipoRegistro.h"

static const int TAMANIO_MAXIMO = 100;

struct ListaRep{
    TipoElemento *valores; //Arreglo de “TipoElemento”
    int cantidad;
};

struct IteradorRep{
    Lista lista;
    int posicionActual; //Mantiene la posición de cada iteración
};

//Objetivo: Crea la lista vacía. Retorna el puntero a la misma.
Lista l_crear(){
    Lista new_list = (Lista) malloc(sizeof(struct ListaRep));
    new_list -> valores = calloc(TAMANIO_MAXIMO,sizeof(TipoElemento));
    new_list -> cantidad = 0;
    return new_list;
}

//Objetivo: determinar si la lista esta vacía. Retorna “true” cuando esto sucede, caso contrario retorna “False”. 
bool l_es_vacia (Lista lista){
    return (lista -> cantidad == 0);
}

//Objetivo: determinar si la lista esta llena. Retorna “true” cuando esto sucede, caso contrario retorna “False”. 
bool l_es_llena(Lista lista){
    return (lista -> cantidad == TAMANIO_MAXIMO);
}

//Objetivo: determinar la cantidad de elementos de la lista.
int l_longitud(Lista lista){
    return (lista -> cantidad);
}

//Objetivo: Agrega un elemento al final de la lista, incrementando la cantidad de elementos de la misma.
void l_agregar(Lista lista, TipoElemento elemento){
    if (!l_es_llena(lista)){
        lista -> valores[lista -> cantidad] = elemento; //Elemento es ubicado en la posicion cantidad del vector, que es la primera luego del ultimo espacio lleno.
        lista -> cantidad++; //Se indica que hay un elemento mas en la lista.
    }
}

//Objetivo: Borra un elemento de lista. Recibe como parámetro la lista y la clave a borrar. 
//En caso de tener claves repetidas borrará todas las ocurrencias.
void l_borrar(Lista lista, int clave){
    if (!l_es_vacia(lista)){
        int pos = 0;
        while (pos < l_longitud(lista)){
            if (lista -> valores[pos] -> clave == clave){
                for (int i = pos; i < l_longitud(lista) - 1; i++){
                    lista -> valores[i] = lista -> valores[i + 1];
                }
                lista -> cantidad--;
            }
            else{
                pos++;
            }
        }
    }
}

//Objetivo: Busca un elemento en la lista recorriéndola. Si hay repetidos retorna la primer ocurrencia.
//Si la clave a buscar no existe retorna la constante “NULL”.
TipoElemento l_buscar(Lista lista, int clave){
    int i = 0;
    while (i < l_longitud(lista)){
        if (lista -> valores[i] -> clave == clave){
            return (lista -> valores[i]);
        }
        i++;
    }
    return NULL;
}

//Objetivo: Inserta un elemento en las posición “pos” dentro de la lista. Incrementa la cantidad.
void l_insertar(Lista lista, TipoElemento elemento, int pos){
    if (!l_es_llena(lista)){
        if (pos < l_longitud(lista)){
            for (int i = lista -> cantidad; i >= pos && i > 0; i--){
                lista -> valores[i] = lista -> valores[i - 1];
            }
            lista -> valores[pos - 1] = elemento;
            lista -> cantidad++;
        }
        else{
            l_agregar(lista, elemento); //Si la posicion ordinal no se halla entre valores no vacios, se agrega el elemento
        }
    }
}

//Objetivo: Elimina una posición de la lista sin importar el dato que esta en esa posición.
//Se diferencia de la función borrar porque el “borrar” elimina a partir de una clave y borra todas las ocurrencias.
void l_eliminar(Lista lista, int pos){
    if (!l_es_vacia(lista)){
        if (pos <= l_longitud(lista)){
            while (pos < lista -> cantidad){
                lista -> valores[pos - 1] = lista -> valores[pos];
                pos++;
            }
            lista -> cantidad--;
        }
    }
}

//Objetivo: retorna el elemento (dato) de la posición “pos” recibida como parámetro.
TipoElemento l_recuperar(Lista lista, int pos){
    return (lista -> valores[pos - 1]);
}

//Objetivo: Muestra las claves de lista en la pantalla.
void l_mostrarLista(Lista lista){
    printf("Campos de archivo:\n");
    for (int i = 0; i < l_longitud(lista); i++){
        struct TipoRegistro registro = *(struct TipoRegistro*)(lista->valores[i]->valor);
        printf("\n%d_\nNombre: %s\nCantidad de caracteres: %d\n", i + 1, (registro).nombre, (registro).cantidad);
    }
    printf("\n");
}

//Objetivo: Inicializa el iterador para poder hacer un recorrido de la lista.
Iterador iterador(Lista lista){
    Iterador iterador = malloc(sizeof(struct IteradorRep));
    iterador -> lista = lista;
    iterador -> posicionActual = 0;
    return iterador;
}

//Objetivo: Retorna “true” mientras existen mas elementos por recorrer de la lista. Caso contrario retorna “false”.
bool hay_siguiente(Iterador iterador){
    return (iterador -> posicionActual < iterador -> lista -> cantidad);
}

//Objetivo: Retorna el próximo elemento de la lista a recorrer.
TipoElemento siguiente(Iterador iterador){
    return (iterador -> lista -> valores[iterador -> posicionActual++]);
}