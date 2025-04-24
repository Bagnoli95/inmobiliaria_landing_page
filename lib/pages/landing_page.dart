import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/pages/properties_page.dart';
import 'package:inmobiliaria_app/utils/constants.dart';
import 'package:inmobiliaria_app/widgets/apartment_view_2.dart';
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
          SingleChildScrollView(controller: _scrollController, child: Column(children: [_buildNavBar(isSmallScreen), _buildHeroSection(isSmallScreen, key: _heroKey), FeatureSection(key: _featuresKey), GallerySection(key: _galleryKey), ContactSection(key: _contactKey), _buildFooter(isSmallScreen)])),

          // Botón flotante para volver arriba (solo visible después de scroll)
          _buildScrollToTopButton(),
        ],
      ),
      // Agregar BottomNavigationBar solo para pantallas pequeñas
      bottomNavigationBar: isSmallScreen ? _buildBottomNavigationBar() : null,
    );
  }

  Widget _buildNavBar(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : AppSizes.contentPadding, vertical: 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))]),
      child: isSmallScreen ? _buildMobileNavBar() : _buildDesktopNavBar(),
    );
  }

  Widget _buildDesktopNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('INMOBILIARIA', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 2.0)),
        Row(
          children: [
            _navButton('Inicio', () => _scrollToTopButton()),
            _navButton('Propiedades', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertiesPage()));
            }),
            _navButton('Características', () => _scrollToSection(_featuresKey)),
            _navButton('Galería', () => _scrollToSection(_galleryKey)),
            _navButton('Contacto', () => _scrollToSection(_contactKey)),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => _scrollToSection(_contactKey),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius))),
              child: const Text('Agendar Visita'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _navButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(foregroundColor: AppColors.textDark, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.5)),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: AppAnimations.fast,
              width: 0, // Cambia a width: 20 en hover
              height: 1,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }

  // Reemplaza el método _buildHeroSection actual por este más elegante
  Widget _buildHeroSection(bool isSmallScreen, {Key? key}) {
    return Container(
      key: key,
      height: isSmallScreen ? 900 : 700,
      decoration: AppDecorations.elegantGradient,
      child: Stack(
        children: [
          // Pattern de fondo
          Positioned.fill(child: Opacity(opacity: 0.05, child: Image.asset('assets/images/pattern_bg.jpg', fit: BoxFit.cover))),

          // Contenido principal
          if (isSmallScreen)
            Column(children: [_buildHeroInfo(), Expanded(child: AdaptiveApartmentViewV2(onRoomSelected: _updateRoomInfo))])
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  // Lado izquierdo - Información del departamento
                  Expanded(flex: 2, child: _buildHeroInfo()),

                  // Lado derecho - Animación interactiva del departamento
                  Expanded(flex: 3, child: ApartmentViewV2(onRoomSelected: _updateRoomInfo)),
                ],
              ),
            ),

          // Etiqueta de premium
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.2), border: Border.all(color: AppColors.accent, width: 1)),
              child: const Text('EXCLUSIVO', style: TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Departamento Premium', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: Colors.white, shadows: [Shadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))])),

          // Separador elegante
          Container(width: 80, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),

          AnimatedSwitcher(duration: AppAnimations.medium, child: Text(_roomDescription, key: ValueKey<String>(_selectedRoom), style: TextStyle(fontSize: 18, height: 1.6, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w300, letterSpacing: 0.5))),

          const SizedBox(height: 40),

          Wrap(spacing: 15, runSpacing: 15, children: [_featureBox(Icons.king_bed, '3 Dormitorios'), _featureBox(Icons.bathtub, '2 Baños'), _featureBox(Icons.square_foot, '120 m²')]),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () => _scrollToSection(_contactKey),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.accent,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: BorderSide(color: AppColors.accent, width: 1.5)),
            ),
            child: const Text('AGENDAR UNA VISITA', style: TextStyle(fontSize: 14, letterSpacing: 2.0, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _featureBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: AppColors.accent.withOpacity(0.7), width: 1)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: AppColors.accent, size: 18), const SizedBox(width: 12), Text(text, style: const TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.5))]),
    );
  }

  Widget _buildFooter(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 30 : 40, horizontal: isSmallScreen ? 20 : AppSizes.contentPadding),
      color: AppColors.primary,
      child:
          isSmallScreen
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('INMOBILIARIA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
                  const SizedBox(height: 20),
                  Padding(padding: EdgeInsets.only(top: isSmallScreen ? 20 : 30), child: Text('© ${DateTime.now().year} Inmobiliaria. Todos los derechos reservados.', textAlign: TextAlign.center, style: TextStyle(fontSize: isSmallScreen ? 12 : 14, color: Colors.white.withOpacity(0.6)))),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centrado para móvi
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo y descripción
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('INMOBILIARIA', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2.0)),
                          const SizedBox(height: 20),
                          SizedBox(width: 300, child: Text('Propiedades exclusivas para clientes exigentes. Ofrecemos las mejores opciones inmobiliarias en las zonas más privilegiadas.', style: TextStyle(color: Colors.white.withOpacity(0.7), height: 1.6))),
                          const SizedBox(height: 30),
                          Row(children: [_socialFooterButton(Icons.facebook), _socialFooterButton(Icons.insert_link), _socialFooterButton(Icons.camera_alt)]),
                        ],
                      ),

                      // Enlaces rápidos
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ENLACES', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
                          const SizedBox(height: 20),
                          _footerLink('Inicio'),
                          const SizedBox(height: 10),
                          _footerLink('Propiedades'),
                          const SizedBox(height: 10),
                          _footerLink('Características'),
                          const SizedBox(height: 10),
                          _footerLink('Galería'),
                          const SizedBox(height: 10),
                          _footerLink('Contacto'),
                        ],
                      ),

                      // Información de contacto
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CONTACTO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
                          const SizedBox(height: 20),
                          _contactInfo(Icons.location_on, 'Av. Principal 123, Ciudad'),
                          const SizedBox(height: 15),
                          _contactInfo(Icons.phone, '+1 234 567 890'),
                          const SizedBox(height: 15),
                          _contactInfo(Icons.email, 'info@inmobiliaria.com'),
                          const SizedBox(height: 15),
                          _contactInfo(Icons.access_time, 'Lun - Vie: 9:00 - 18:00'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(height: 1, color: Colors.white.withOpacity(0.1), margin: const EdgeInsets.only(bottom: 30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('© ${DateTime.now().year} Inmobiliaria. Todos los derechos reservados.', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
                      Row(children: [_footerLinkSmall('Términos y Condiciones'), _footerLinkSmall('Política de Privacidad'), _footerLinkSmall('Cookies')]),
                    ],
                  ),

                  // Copyright al final, adaptado para móvil
                  Padding(padding: EdgeInsets.only(top: isSmallScreen ? 20 : 30), child: Text('© ${DateTime.now().year} Inmobiliaria. Todos los derechos reservados.', textAlign: TextAlign.center, style: TextStyle(fontSize: isSmallScreen ? 12 : 14, color: Colors.white.withOpacity(0.6)))),
                ],
              ),
    );
  }

  Widget _socialFooterButton(IconData icon) {
    return Container(margin: const EdgeInsets.only(right: 15), width: 36, height: 36, decoration: BoxDecoration(border: Border.all(color: AppColors.accent, width: 1), shape: BoxShape.circle), child: Center(child: Icon(icon, color: AppColors.accent, size: 18)));
  }

  Widget _footerLink(String text) {
    return Text(text, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15));
  }

  Widget _footerLinkSmall(String text) {
    return Padding(padding: const EdgeInsets.only(left: 20), child: Text(text, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)));
  }

  Widget _contactInfo(IconData icon, String text) {
    return Row(children: [Icon(icon, color: AppColors.accent, size: 16), const SizedBox(width: 15), Text(text, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15))]);
  }

  Widget _socialButton(IconData icon) {
    return Padding(padding: const EdgeInsets.only(left: 15), child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Icon(icon, color: Colors.white, size: 20)));
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
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, AppColors.primaryLight])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('INMOBILIARIA', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2.0)), SizedBox(height: 8), Text('Propiedades exclusivas', style: TextStyle(color: Colors.white70, fontSize: 14))],
              ),
            ),
            _buildDrawerItem('Inicio', Icons.home_outlined, () {
              Navigator.pop(context);
              _scrollToTopButton();
            }),
            _buildDrawerItem('Propiedades', Icons.apartment_outlined, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertiesPage()));
            }),
            _buildDrawerItem('Características', Icons.star_outline, () {
              Navigator.pop(context);
              _scrollToSection(_featuresKey);
            }),
            _buildDrawerItem('Galería', Icons.photo_library_outlined, () {
              Navigator.pop(context);
              _scrollToSection(_galleryKey);
            }),
            _buildDrawerItem('Contacto', Icons.mail_outline, () {
              Navigator.pop(context);
              _scrollToSection(_contactKey);
            }),
            const Divider(),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('Síguenos en redes', style: TextStyle(fontSize: 12, color: AppColors.grey))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: const Icon(Icons.facebook, color: AppColors.primary), onPressed: () {}),
                IconButton(icon: const Icon(Icons.insert_link, color: AppColors.primary), onPressed: () {}),
                IconButton(icon: const Icon(Icons.camera_alt_outlined, color: AppColors.primary), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(leading: Icon(icon, color: AppColors.primary), title: Text(title, style: const TextStyle(fontSize: 16, color: AppColors.textDark)), onTap: onTap);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('INMOBILIARIA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 1.5)),
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.primary),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ],
    );
  }
}
