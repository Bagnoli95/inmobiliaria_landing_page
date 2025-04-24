# Inmobiliaria App

Aplicación inmobiliaria con departamento interactivo creada con Flutter y Rive.

## 📋 Características

- Landing page moderna y responsive
- Visualización interactiva de departamento con Rive
- Galería de imágenes
- Formulario de contacto
- Diseño adaptable para móvil y web

## 🚀 Instalación

### Prerrequisitos

- Flutter SDK (versión 2.10.0 o superior)
- Dart SDK (versión 2.16.0 o superior)
- Editor de código (VS Code, Android Studio, etc.)
- Git

### Pasos para la instalación

1. Clona el repositorio:

```bash
git clone https://github.com/tu-usuario/inmobiliaria_app.git
cd inmobiliaria_app
```

2. Instala las dependencias:

```bash
flutter pub get
```

3. Ejecuta la aplicación:

```bash
flutter run -d chrome  # Para versión web
flutter run            # Para versión móvil
```

## 🛠️ Estructura del Proyecto

```
inmobiliaria_app/
│
├── lib/
│   ├── main.dart             # Punto de entrada de la aplicación
│   ├── pages/
│   │   ├── landing_page.dart # La página principal con todas las secciones
│   │   └── properties_page.dart
│   │
│   ├── widgets/
│   │   ├── apartment_view.dart      # Widget específico para la visualización del departamento
│   │   ├── feature_section.dart     # Widget para la sección de características
│   │   ├── gallery_section.dart     # Widget para la galería
│   │   └── contact_section.dart     # Widget para la sección de contacto
│   │
│   └── utils/
│       └── constants.dart     # Constantes, colores, estilos
│
├── assets/
│   ├── apartment_interactive.riv  # Archivo de animación Rive
│   ├── apartment_floorplan.svg    # Versión SVG como alternativa
│   ├── fonts/                     # Fuentes personalizadas
│   └── images/                    # Imágenes de departamentos
│
└── pubspec.yaml                   # Dependencias y configuración
```

## 📱 Compatibilidad

- Web (Chrome, Firefox, Safari)
- Android
- iOS

## 🔧 Creación de la Animación Rive

Para crear el archivo de animación Rive:

1. Registrarse en [rive.app](https://rive.app/)
2. Crear un nuevo archivo
3. Diseñar el plano del departamento con habitaciones separadas
4. Configurar la máquina de estados "ApartmentInteraction" con estos inputs:
   - `HoverLivingRoom` (bool)
   - `HoverKitchen` (bool)
   - `HoverBedroom` (bool)
   - `HoverBathroom` (bool)
5. Crear estados para cada habitación (normal y hover)
6. Exportar el archivo .riv y colocarlo en la carpeta assets/

## 🔍 Implementación en detalle

### Visualización interactiva

El componente principal es el widget `ApartmentView` que:

- Carga la animación Rive
- Configura áreas interactivas para cada habitación
- Maneja eventos de hover/tap dependiendo de la plataforma
- Comunica la habitación seleccionada al componente padre

### Diseño responsive

La aplicación se adapta automáticamente a diferentes tamaños de pantalla:

- En pantallas grandes: Layout horizontal con navegación superior
- En pantallas pequeñas: Layout vertical con menú hamburguesa
- Ajuste dinámico de tamaño de fuentes e imágenes

## 📚 Dependencias principales

- `flutter`: SDK base
- `rive: ^0.9.1`: Para animaciones interactivas
- `flutter_svg: ^1.1.6`: Para renderizar SVG
- `url_launcher: ^6.1.5`: Para manejar enlaces externos
- `google_fonts: ^3.0.1`: Para tipografía personalizada

## 🤝 Contribución

1. Haz un Fork del proyecto
2. Crea tu rama de características (`git checkout -b feature/AmazingFeature`)
3. Haz commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT - mira el archivo LICENSE.md para detalles

## ✨ Próximas mejoras

- Integración con backend para formulario de contacto real
- Implementación de autenticación de usuarios
- Sistema de favoritos para guardar propiedades
- Implementación de filtros avanzados
- Integración con Google Maps para visualizar ubicación