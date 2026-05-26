# SIERRAVP — Instrucciones para ejecutar la simulación

---

## Requisito previo: Java 21

Necesitas tener Java 21 instalado **en esta ruta exacta**:

```
C:\Program Files\Java\jdk-21\
```

Para verificar, abre CMD y ejecuta:

```cmd
"C:\Program Files\Java\jdk-21\bin\java.exe" -version
```

Debe mostrar: `java version "21.x.x"`

Si no tienes Java 21, descárgalo e instálalo desde:
https://www.oracle.com/java/technologies/downloads/#java21
(elige Windows x64 Installer)

---

## Paso 1 — Extraer el .rar

Extrae el .rar manteniendo la estructura de carpetas.
Copia las dos carpetas directamente en `C:\`:

```
C:\PROYECTO\        ← carpeta del cliente
C:\SERVIDOR\        ← carpeta del servidor
```

Debe quedar así:

```
C:\PROYECTO\
└── APPLICATION\
    ├── SIERRAVP.jar
    ├── SIERRAVP.bat
    ├── Send.bat
    └── nombres\
        └── codigo.txt

C:\SERVIDOR\
└── APPLICATION\
    ├── SIERRAVP.jar
    ├── Update.bat
    └── Update-now.bat
```

---

## Paso 2 — Abrir 2 ventanas CMD

Necesitas dos ventanas de CMD abiertas al mismo tiempo.

---

### Ventana 1 — Servidor (déjala abierta toda la simulación)

```cmd
cd C:\SERVIDOR\APPLICATION
Update.bat
```

Debe mostrar esto y quedarse esperando:

```
[hh/mm/aaaa hh:mm:ss] === UPDATE — Servidor de Datos iniciado ===
[hh/mm/aaaa hh:mm:ss] Monitoreando: C:/Users/TU-USUARIO/Desktop/DATOS/
[hh/mm/aaaa hh:mm:ss] Sin archivos pendientes.
[hh/mm/aaaa hh:mm:ss] Modo watch activo. Esperando archivos... (Ctrl+C para detener)
```

---

### Ventana 2 — Cliente: ingresar datos

```cmd
cd C:\PROYECTO\APPLICATION
SIERRAVP.bat
```

Verás el menú:

```
=== SIERRAVP — Sistema de Evaluación del Rendimiento Académico ===

--- MENÚ PRINCIPAL ---
1. Registrar alumno
2. Ver alumnos registrados
3. Insertar datos de prueba (demo)
4. Salir
Opción:
```

- Elige **opción 3** para insertar 3 alumnos de prueba automáticamente (más rápido para demo).
- O elige **opción 1** para registrar un alumno tú mismo.
- Cuando termines, elige **opción 4** para salir.

Los datos se guardan en `C:\PROYECTO\DATA\`.

---

### Ventana 2 — Cliente: enviar datos al servidor

En la misma ventana (o una nueva en la misma carpeta):

```cmd
cd C:\PROYECTO\APPLICATION
Send.bat
```

Verás algo como:

```
[...] === SEND — Inicio de transferencia ===
[...] OK  alumnos.dat → DESKTOP-XXXXX_alumnos.dat  (... bytes)
[...] OK  notas.dat   → DESKTOP-XXXXX_notas.dat    (... bytes)
[...] Transferidos: 6  |  Fallidos: 0
```

---

## Paso 3 — Verificar que el servidor recibió todo

Vuelve a la **Ventana 1** (la del servidor). Debe aparecer automáticamente:

```
[...] Procesando: DESKTOP-XXXXX_alumnos.dat
[...]   Alumnos → nuevos: 3  actualizados: 0
[...]   Marcado como procesado: DESKTOP-XXXXX_alumnos.dat.procesado
[...] Procesando: DESKTOP-XXXXX_notas.dat
[...]   Notas → nuevas: 3  actualizadas: 0
```

Los datos consolidados están en `C:\SERVIDOR\DATA\`.

---

## Resumen del flujo

```
SIERRAVP.bat  →  crea datos en C:\PROYECTO\DATA\
Send.bat      →  copia archivos a Desktop\DATOS\  (simula envío por red)
Update.bat    →  detecta los archivos y los procesa en C:\SERVIDOR\DATA\
```

---

## Problemas comunes

| Error | Solución |
|---|---|
| `El sistema no puede encontrar la ruta especificada` al correr el .bat | Java no está instalado en `C:\Program Files\Java\jdk-21\` |
| `Send.bat` dice "No se encontraron archivos .dat" | Primero ejecuta `SIERRAVP.bat` e inserta datos |
| `Update.bat` no detecta archivos automáticamente | Normal si los archivos llegaron antes de abrir el servidor — usa `Update-now.bat` en su lugar |
