#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#ifdef _WIN32
#include <conio.h>
#include <windows.h>
#else
#include <unistd.h>
#endif
#include "tipo_elemento.c"
#include "listasArray.c"
#include "tipoRegistro.h"
#include "validaciones.c"

void menuCampo ();
void menuRegistro ();
void altaRegistro (Lista lista);
void bajaRegistro (Lista lista);
void modificacionRegistro (Lista lista);
void mostrarRegistros (Lista lista);
void mostrarCampos (Lista lista);
bool mostrarAtributos (Lista lista, int posicion);
int tamanioRegistro (Lista lista);
Lista listaCampos ();
void limpiar_pantalla();
char *validarRango(int cantidad);

int main () {
  FILE * fp = fopen("metadata.dat", "rb");
  if (!fp) {
    menuCampo();
  } else {
    menuRegistro();
  }
  return 0;
}

void menuCampo () {
  printf("Ingrese la estructura del archivo\n");
  int cantidad;
  printf("Cantidad de campos: ");
  pedirDatos(&cantidad, 11);
  int i = 0;
  struct TipoRegistro reg[20];
  char nombre[30];
  while (i < cantidad) {
    printf("\nIngrese el nombre del campo (max 30): ");
    pedirChar(nombre);
    strcpy(reg[i].nombre, nombre);
    printf("\nIngrese la cantidad de caracteres del campo (max 30): ");
    pedirDatos(&reg[i].cantidad, 11);
    i++;
  }
  FILE * fp = fopen("metadata.dat", "wb");
  fwrite(reg, sizeof(struct TipoRegistro), cantidad, fp);
  printf("Campos creados exitosamente.");
  fclose(fp);
}

void menuRegistro () {
  int opcion;

  Lista campos = listaCampos();


  do {
    //limpiar_pantalla();
    l_mostrarLista(campos);
    printf("Elija la opcion\n");
    printf("1: Agregar registro\n");
    printf("2: Eliminar registro\n");
    printf("3: Modificar registro\n");
    printf("4: Mostrar registros\n");
    printf("5: Salir\n");
    pedirDatos(&opcion, 11);
    switch (opcion){
      case 1:
        altaRegistro(campos);
        break;
      case 2:
        bajaRegistro(campos);
        break;
      case 3:
        modificacionRegistro(campos);
        break;
      case 4:
        mostrarRegistros(campos);
        break;
      case 5:
        printf("Saliste del programa");
        break;
      default:
        printf("Input invalido\n");
    }

  } while (opcion != 5);
}

Lista listaCampos() {
  FILE * fp = fopen("metadata.dat", "rb");
  Lista campos = l_crear();
  struct TipoRegistro reg[20];
  int i = 0;
  while (fread(&(reg[i]), sizeof(struct TipoRegistro), 1, fp)) {
    struct TipoRegistro * registro = malloc(sizeof(struct TipoRegistro));
    strcpy(registro->nombre, reg[i].nombre);
    registro->cantidad = reg[i].cantidad;
    l_agregar(campos, te_crear_con_valor(0, registro));
    i++;
  }
  return campos;
}

void altaRegistro (Lista lista) {
  Iterador ite = iterador(lista);
  TipoElemento elemento;
  int i = 0;
  int size = 0;

  while (hay_siguiente(ite)) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro *)(elemento->valor);
    size += registro->cantidad;
  }
  char ** campos = malloc(sizeof(char *) * size);
  ite = iterador(lista);

  while (hay_siguiente(ite)) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
    printf("Ingrese el %s: ", registro->nombre);
    campos[i] = malloc(sizeof(char) * (registro->cantidad + 1));
    //scanf("%s", campos[i]);
    campos[i] = validarRango(registro->cantidad);
    printf("valor: %s\n", campos[i]);
    i++;
  }
  FILE * fp = fopen("registros.dat", "ab");
  ite = iterador(lista);
  for (int j = 0; j < i; j++) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro *)(elemento->valor);
    fwrite(campos[j], sizeof(char) * registro->cantidad, 1, fp);
    free(campos[j]); // Liberar memoria de cada campo
  }
  fclose(fp);
}

void mostrarRegistros (Lista lista) {
  FILE * fp = fopen("registros.dat", "rb");
  if (fp) {
    TipoElemento elemento;
    int size = tamanioRegistro(lista);
    fseek(fp, 0, SEEK_END);
    long sizeFile = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    int cantidad = sizeFile / (size * sizeof(char));
    Iterador ite = iterador(lista);
    char * campo;
    for (int i = 0;i < cantidad;i++) {
      while (hay_siguiente(ite)) {
        elemento = siguiente(ite);
        struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
        //campo = malloc(sizeof(char) * registro->cantidad + 1);
        campo = calloc(registro->cantidad + 1, sizeof(char));
        fread(campo, sizeof(char) * registro->cantidad, 1, fp);
        printf("    |--------------------------------|--------------------------------|\n");
        printf("%d_  | %-30s | %-30s |\n", i, registro->nombre, campo);
        //printf("%s: %s\n", registro->nombre, campo);
        free(campo);
      }
      ite = iterador(lista);
    }
    printf("    |--------------------------------|--------------------------------|\n");
    fclose(fp);
  }
}

void modificacionRegistro (Lista lista) {
  int posicion;
  do {
    printf("Ingrese la posicion del registro a modificar: ");
    scanf("%d", &posicion);
    if (posicion >= 0) {
      bool posValida = mostrarAtributos(lista, posicion);
      if (!posValida) {
        printf("La posicion es invalida\n");
        posicion = -1;
      } else {
        char si;
        do {
          printf("Este es el registro a modificar, esta seguro que lo quiere modificar?(s/n): ");
          scanf(" %c", &si);
          if (si != 's' && si != 'n') {
            printf("La opcion es invalida\n");
          }
        } while (si != 's' && si != 'n');
        if (si == 'n') {
          posicion = -1;
        }
      }
    }
  } while (posicion < 0);

  int campo;
  do {
    printf("Ingrese el atributo que quiere modificar:\n");
    mostrarCampos(lista);
    scanf("%d", &campo);
    if (campo < 0 || campo >= l_longitud(lista)) {
      printf("Opcion invalida\n");
    }
  } while (campo < 0 || campo >= l_longitud(lista));
  FILE * fp = fopen("registros.dat", "rb+");
  int sizeCampo = 0;
  int sizeAtributo;
  Iterador ite = iterador(lista);
  TipoElemento elemento;
  int i;
  for (i = 0;i <= campo;i++) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
    if (i != campo) {
      sizeCampo += (sizeof(char) * registro->cantidad);
    } else {
      sizeAtributo = (sizeof(char) * registro->cantidad);
    }
  }
  char * atributo = malloc(sizeAtributo);
  printf("Ingrese el valor: ");
  scanf("%s", atributo);
  fseek(fp, (tamanioRegistro(lista) * posicion) + sizeCampo, SEEK_SET);
  fwrite(atributo, sizeAtributo, 1, fp);
  fclose(fp);
}

void mostrarCampos (Lista lista) {
  Iterador ite = iterador(lista);
  TipoElemento elemento;
  int i = 0;
  while (hay_siguiente(ite)) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
    printf("%d_ %s\n", i, registro->nombre);
    i++;
  }
}

bool mostrarAtributos (Lista lista, int posicion) {
  TipoElemento elemento;
  Iterador ite = iterador(lista);
  FILE * fp = fopen("registros.dat", "rb");
  int size = tamanioRegistro(lista);
  fseek(fp, 0, SEEK_END);
  long sizeFile = ftell(fp);
  fseek(fp, 0, SEEK_SET);
  int cantidad = sizeFile / (size * sizeof(char));

  if (cantidad <= posicion) {
    fclose(fp);
    return false;
  }
  
  fseek(fp, size * posicion, SEEK_SET);
  ite = iterador(lista);
  char * campo;
  while (hay_siguiente(ite)) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
    campo = malloc(sizeof(char) * registro->cantidad + 1);
    fread(campo, sizeof(char) * registro->cantidad, 1, fp);
    printf("%s: %s\n", registro->nombre, campo);
    free(campo);
  }
  fclose(fp);
  return true;
}

int tamanioRegistro (Lista lista) {
  Iterador ite = iterador(lista);
  TipoElemento elemento;
  int size = 0;
  while (hay_siguiente(ite)) {
    elemento = siguiente(ite);
    struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
    size += (registro->cantidad * sizeof(char));
  }
  return size;
}

void bajaRegistro (Lista lista) {
  int posicion;
  do {
    printf("Ingrese la posicion del registro a eliminar: ");
    scanf("%d", &posicion);
    if (posicion >= 0) {
      bool posValida = mostrarAtributos(lista, posicion);
      if (!posValida) {
        printf("La posicion es invalida\n");
        posicion = -1;
      } else {
        char si;
        do {
          printf("Este es el registro a eliminar, esta seguro que lo quiere eliminar?(s/n): ");
          scanf(" %c", &si);
          if (si != 's' && si != 'n') {
            printf("La opcion es invalida\n");
          }
        } while (si != 's' && si != 'n');
        if (si == 'n') {
          posicion = -1;
        }
      }
    }
  } while (posicion < 0);

  FILE * original = fopen("registros.dat", "rb");
  FILE * temp = fopen("temp.dat", "ab");

  TipoElemento elemento;
  int size = tamanioRegistro(lista);
  fseek(original, 0, SEEK_END);
  long sizeFile = ftell(original);
  fseek(original, 0, SEEK_SET);
  int cantidad = sizeFile / (size * sizeof(char));
  Iterador ite = iterador(lista);
  char * campo;
  //int i = 0;
  for (int i = 0;i < cantidad;i++) {
    while (hay_siguiente(ite)) {
      elemento = siguiente(ite);
      struct TipoRegistro *registro = (struct TipoRegistro*)(elemento->valor);
      campo = malloc(sizeof(char) * registro->cantidad + 1);
      fread(campo, sizeof(char) * registro->cantidad, 1, original);
      if (i != posicion) {
        fwrite(campo, sizeof(char) * registro->cantidad, 1, temp);
      }
      free(campo);
    }
    ite = iterador(lista);
  }
  fclose(original);
  fclose(temp);
  
  remove("registros.dat");
  
  rename("temp.dat", "registros.dat");
}

char *validarRango(int cantidad) {
  char *str = (char *)calloc(cantidad, sizeof(char));
  int longitud = 0;
  do {
    scanf("%s", str);
    longitud = strlen(str);
    if (longitud > cantidad)
      printf("La cantidad de caracteres supera a la maxima (%d)", cantidad);
  } while (longitud < 0 || longitud > cantidad);
  return str;
}