# Flutter
Docker - Flutter

Crear un espacio de trabajo (workspace) con docker para poder crear proyectos usando flutter.

El archivo docker-compose.yml es para equipos con sistema operativo Linux, en el caso se use en otro sistema operativo retirar el siguiente volumen:
 
```bash
type: bind
source: /dev/bus/usb 
target: /dev/bus/usb
```

## Docker

- Para la primera vez que se levanta el espacio de trabajo para flutter con docker o se cambie los archivos de docker, ejecutar:
 
```bash
sudo docker-compose up --build -d
```

- En las siguientes oportunidades ejecutar:

Para levantar:
```bash
sudo docker-compose start
```
Para detener:
```bash
sudo docker-compose stop
```
- Para ingresar al contenedor ejecutar:
```bash
sudo docker-compose exec server bash
```
## Crear proyecto con Flutter:
- Para verificar flutter, dentro del contenedor ejecutar:
```bash
flutter doctor
```
- Para crear un proyecto con flutter, hacerlo dentro del contenedor en la carpeta workspace, para ello ejecutar:
 ```bash
flutter create nombre_proyecto
```

### Ver proyecto en web:
- Para generar el proyecto para web, dentro de la carpera nombre_proyecto (nombre de la carpeta del proyecto), ejecutar:
```bash
flutter pub get && flutter run -d web-server --web-port 5000 --web-hostname 0.0.0.0
```

- Para ver el proyecto generado para web, en un navegador colocar la siguiente url:
```bash
http://localhost:8014
```

### Ver proyecto en dispositivo android:
- Habilitar depuración usb, conectar por usb y configurar estableciendo el modo de conexión en PTP en el dispositivo android. Nota: Tener cerrado el navegador chrome en el equipo host, para poder usar el dispositivo android en el contenedor.

- Para verificar que el dispositivo android fue reconocido, ejecutar:
```bash
flutter doctor
```
- Para generar el proyecto para android, dentro de la carpera nombre_proyecto (nombre de la carpeta del proyecto), ejecutar:
```bash
flutter pub get && flutter run
```