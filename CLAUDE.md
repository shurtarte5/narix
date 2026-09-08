# Narix

## Qué es

Narix es una app de identificación y seguridad de mascotas mediante reconocimiento biométrico del hocico (nose print). Si una mascota se extravía, cualquier veterinaria puede escanear su hocico y obtener de inmediato los datos de contacto del dueño.

La app debe funcionar internacionalmente desde el inicio: formatos de teléfono internacionales (libphonenumber), soporte multi-idioma (ARB/Flutter intl), y no asumir moneda ni región específica.

## Alcance del MVP

**Rol dueño:**
- Registrar mascota (nombre, especie, foto de hocico)
- Registrar datos de contacto (nombre, teléfono internacional, correo)
- Ver y editar sus mascotas registradas

**Rol veterinaria ("lector"):**
- Escanear el hocico de una mascota desconocida
- Si hay match confirmado por el backend, ver únicamente los datos de contacto del dueño (nombre + teléfono), nada más
- No puede ver la ficha completa del dueño ni acceder a otras mascotas

## Arquitectura

**Principio fundamental:** el reconocimiento vive siempre en el backend. Flutter es un cliente delgado.

- Flutter captura la foto y la sube al backend vía API
- El backend extrae embeddings, busca en la base vectorial y devuelve el resultado
- Flutter nunca procesa imágenes localmente, nunca almacena embeddings

**Stack:**
- Frontend: Flutter (iOS + Android)
- Backend: Python / FastAPI
- Base de datos: PostgreSQL con pgvector para matching de embeddings
- Storage: privado (S3 o equivalente), con URLs firmadas de corta duración

## Seguridad (no negociable)

- Toda comunicación pasa por API con JWT; no hay endpoints públicos sin auth
- Roles separados desde el día uno: `owner` y `vet`; el backend los valida en cada request
- La veterinaria nunca recibe la ficha completa del dueño sin match confirmado
- HTTPS obligatorio en todos los entornos (staging y producción)
- Fotos almacenadas en storage privado; nunca en URLs públicas
- Las fotos originales no se retienen más tiempo del necesario tras generar el embedding
- Rate limiting en el endpoint de escaneo (`POST /scan`) para evitar abusos

## Nota de producto

La calidad de la foto del hocico es crítica para la precisión del matching. Cuando se implemente la captura, la app debe guiar al usuario con una silueta-guía superpuesta en la vista de cámara y validar calidad antes de subir.

## Estructura de carpetas (`lib/`)

```
lib/
  screens/    # Pantallas de la app (una por feature)
  widgets/    # Componentes reutilizables
  models/     # Data classes / entidades
  services/   # Comunicación con el backend (HTTP, auth, storage)
  main.dart
```
