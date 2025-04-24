import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/pages/properties_page.dart';
import 'package:inmobiliaria_app/utils/constants.dart';
import 'package:inmobiliaria_app/widgets/apartment_view.dart';
import 'package:inmobiliaria_app/widgets/feature_section.dart';
import 'package:inmobiliaria_app/widgets/contact_section.dart';
import 'package:inmobiliaria_app/widgets/gallery_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Para mantener el estado de la habitación seleccionada
  String _selectedRoom = '';
  String _roomDescription = 'Experimenta el lujo en cada rincón de este exclusivo departamento. Explora las habitaciones para más detalles.';

  // Controlador para el desplazamiento
  final ScrollController _scrollController = ScrollController();

  // Claves para las secciones (para navegación)
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Para el índice del BottomNavigationBar
  int _selectedIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateRoomInfo(String room) {
    setState(() {
      _selectedRoom = room;
      switch (room) {
        case 'living':
          _roomDescription = 'Amplia sala de estar con iluminación natural y vista panorámica. Diseñada para maximizar el confort y la convivencia familiar.';
          break;
        case 'kitchen':
          _roomDescription = 'Cocina moderna con acabados de primera y electrodomésticos incluidos. Espaciosa y funcional, ideal para los amantes de la gastronomía.';
          break;
        case 'bedroom':
          _roomDescription = 'Dormitorio principal con closet empotrado y baño en suite. Ambiente tranquilo y acogedor para un descanso perfecto.';
          break;
        case 'bathroom':
          _roomDescription = 'Baño completo con acabados en mármol y ducha española. Detalles de lujo y funcionalidad en cada elemento.';
          break;
        default:
          _roomDescription = 'Experimenta el lujo en cada rincón de este exclusivo departamento. Explora las habitaciones para más detalles.';
      }
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: AppAnimations.medium, curve: AppAnimations.emphasized);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detectar si estamos en pantalla pequeña
    final isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      key: _scaffoldKey,
      // drawer: isSmallScreen ? _buildDrawer() : null,
      body: Stack(
        children: [
          // Contenido principal con scroll
          SingleChildScrollView(controller: _scrollController, child: Column(children: [_buildNavBar(isSmallScreen), _buildHeroSection(isSmallScreen, key: _heroKey), FeatureSection(key: _featuresKey), GallerySection(key: _galleryKey), ContactSection(key: _contactKey), _buildFooter()])),

          // Botón flotante para volver arriba (solo visible después de scroll)
          _buildScrollToTopButton(),
        ],
      ),
      // Agregar BottomNavigationBar solo para pantallas pequeñas
      bottomNavigationBar: isSmallScreen ? _buildBottomNavigationBar() : null,
    );
  }

  Widget _buildNavBar(bool isSmallScreen) {
    return Container(padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : AppSizes.contentPadding, vertical: 20), color: Colors.white, child: isSmallScreen ? _buildMobileNavBar() : _buildDesktopNavBar());
  }

  Widget _buildDesktopNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('INMOBILIARIA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
        Row(
          children: [
            _navButton('Inicio', () => _scrollToTopButton()),
            // Añade nuevo botón para Propiedades
            _navButton('Propiedades', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertiesPage()));
            }),
            _navButton('Características', () => _scrollToSection(_featuresKey)),
            _navButton('Galería', () => _scrollToSection(_galleryKey)),
            _navButton('Contacto', () => _scrollToSection(_contactKey)),
            const SizedBox(width: 20),
            ElevatedButton(onPressed: () => _scrollToSection(_contactKey), style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), backgroundColor: AppColors.primary), child: const Text('Agendar Visita')),
          ],
        ),
      ],
    );
  }

  Widget _navButton(String text, VoidCallback onPressed) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: TextButton(onPressed: onPressed, child: Text(text, style: TextStyle(fontSize: 16, color: AppColors.greyDark))));
  }

  Widget _buildHeroSection(bool isSmallScreen, {Key? key}) {
    return Container(
      key: key,
      height: isSmallScreen ? 900 : 700,
      color: AppColors.greyLight,
      child:
          isSmallScreen
              ? Column(children: [_buildHeroInfo(), Expanded(child: AdaptiveApartmentView(onRoomSelected: _updateRoomInfo))])
              : Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/hero_background.jpg'),
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), // Oscurece la imagen para mejorar la legibilidad del texto
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // Lado izquierdo - Información del departamento
                    Expanded(flex: 2, child: _buildHeroInfo()),

                    // Lado derecho - Animación interactiva del departamento
                    Expanded(flex: 3, child: ApartmentView(onRoomSelected: _updateRoomInfo)),
                  ],
                ),
              ),
    );
  }

  Widget _buildHeroInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Departamento Premium',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            height: 1.2,
            color: Colors.white, // Cambia el color del texto para que sea visible sobre la imagen
          ),
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: AppAnimations.medium,
          child: Text(
            _roomDescription,
            key: ValueKey<String>(_selectedRoom),
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.white.withOpacity(0.9), // Texto blanco con ligera transparencia
            ),
          ),
        ),
        const SizedBox(height: 40),
        Wrap(spacing: 15, runSpacing: 15, children: [_featureBox(Icons.king_bed, '3 Dormitorios'), _featureBox(Icons.bathtub, '2 Baños'), _featureBox(Icons.square_foot, '120 m²')]),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: () => _scrollToSection(_contactKey), style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), backgroundColor: AppColors.primary), child: const Text('AGENDAR UNA VISITA', style: TextStyle(fontSize: 16))),
      ],
    );
  }

  // También deberías modificar el _featureBox para que sea visible sobre la imagen de fondo
  Widget _featureBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Fondo semi-transparente
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: Colors.white), const SizedBox(width: 8), Text(text, style: TextStyle(color: Colors.white))]),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: AppSizes.contentPadding),
      color: AppColors.primaryDark,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('INMOBILIARIA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              Row(children: [_socialButton(Icons.facebook), _socialButton(Icons.insert_link), _socialButton(Icons.camera_alt)]),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('© ${DateTime.now().year} Inmobiliaria. Todos los derechos reservados.', style: TextStyle(color: Colors.white.withOpacity(0.7)), textAlign: TextAlign.center),
                    const SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [_footerLink('Términos y Condiciones'), _footerLink('Política de Privacidad'), _footerLink('Cookies')]),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('© ${DateTime.now().year} Inmobiliaria. Todos los derechos reservados.', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                    Row(children: [_footerLink('Términos y Condiciones'), _footerLink('Política de Privacidad'), _footerLink('Cookies')]),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _socialButton(IconData icon) {
    return Padding(padding: const EdgeInsets.only(left: 15), child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Icon(icon, color: Colors.white, size: 20)));
  }

  Widget _footerLink(String text) {
    return Padding(padding: const EdgeInsets.only(left: 20), child: Text(text, style: TextStyle(color: Colors.white.withOpacity(0.7))));
  }

  Widget _buildScrollToTopButton() {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final shouldShow = _scrollController.hasClients && _scrollController.offset > MediaQuery.of(context).size.height * 0.5;

        return AnimatedOpacity(
          opacity: shouldShow ? 1.0 : 0.0,
          duration: AppAnimations.fast,
          child: Align(alignment: Alignment.bottomRight, child: Padding(padding: const EdgeInsets.all(20), child: FloatingActionButton(backgroundColor: AppColors.primary, onPressed: shouldShow ? _scrollToTopButton : null, child: const Icon(Icons.arrow_upward)))),
        );
      },
    );
  }

  void _scrollToTopButton() {
    _scrollController.animateTo(0, duration: AppAnimations.medium, curve: AppAnimations.emphasized);
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(decoration: BoxDecoration(color: AppColors.primary), child: const Text('INMOBILIARIA', style: TextStyle(color: Colors.white, fontSize: 24))),
          ListTile(
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              _scrollToTopButton();
            },
          ),
          ListTile(
            title: const Text('Propiedades'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertiesPage()));
            },
          ),
          // Añade más opciones de menú según sea necesario
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onBottomNavTapped,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed, // Importante para mostrar más de 3 items
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Propiedades'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Características'),
        BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Galería'),
        BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Contacto'),
      ],
    );
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Inicio
        _scrollToTopButton();
        break;
      case 1: // Propiedades
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertiesPage()));
        break;
      case 2: // Características
        _scrollToSection(_featuresKey);
        break;
      case 3: // Galería
        _scrollToSection(_galleryKey);
        break;
      case 4: // Contacto
        _scrollToSection(_contactKey);
        break;
    }
  }

  Widget _buildMobileNavBar() {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('INMOBILIARIA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary))]));
  }
}
