# Instalar Nodejs

Intalar nodejs y manejador de paquetes:
```sh
sudo apt-get update
sudo apt-get install nodejs
sudo apt-get instal npm
```

# Configurando Node

Iniciar package.json, para gestionar las dependencias del proyecto, versiones, entre otras configuraciones globales. Para crear el archivo se utiliza el siguiente comando:

```sh
npm init -y
```
Agregamos la libreria express, para implementar funciones de protocolo HTTP:
```sh
npm i express
```
Agregar modulo cors, para gestionar politicas de comunicación entre dispositivos
```sh
npm i cors
```

También se incluye la librería pg, para interactuar con la postgreSQL:

```sh
npm i pg
```

