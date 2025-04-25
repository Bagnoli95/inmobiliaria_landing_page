import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';
import 'package:inmobiliaria_app/widgets/loading_image.dart';

class HomeBannerSection extends StatefulWidget {
  final VoidCallback onExploreProperties;

  const HomeBannerSection({Key? key, required this.onExploreProperties}) : super(key: key);

  @override
  State<HomeBannerSection> createState() => _HomeBannerSectionState();
}

class _HomeBannerSectionState extends State<HomeBannerSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Datos de banner basados en Proinvest
  final List<Map<String, dynamic>> _bannerData = [
    {'image': 'assets/images/banner_1.jpg', 'title': 'Inversiones Inmobiliarias de Alto Valor', 'subtitle': 'Propiedades exclusivas para inversores exigentes'},
    {'image': 'assets/images/banner_2.jpg', 'title': 'Edificios de Lujo en las Mejores Zonas', 'subtitle': 'Arquitectura moderna y acabados premium'},
    {'image': 'assets/images/banner_3.jpg', 'title': 'Casas Unifamiliares con Diseño Exclusivo', 'subtitle': 'Espacios diseñados para experiencias únicas'},
  ];

  @override
  void initState() {
    super.initState();
    // Auto-avance del carrusel
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _setupPageController();
      }
    });
  }

  void _setupPageController() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        if (_currentPage < _bannerData.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);

        _setupPageController();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.black,
      child: Stack(
        children: [
          // Carrusel principal
          PageView.builder(
            controller: _pageController,
            itemCount: _bannerData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildBannerItem(_bannerData[index]);
            },
          ),

          // Overlay con gradiente para mejorar la legibilidad
          Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.6)])))),

          // Indicadores de página
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_bannerData.length, (index) {
                return Container(width: 10, height: 10, margin: const EdgeInsets.symmetric(horizontal: 5), decoration: BoxDecoration(shape: BoxShape.circle, color: _currentPage == index ? AppColors.accent : Colors.white.withOpacity(0.5)));
              }),
            ),
          ),

          // Botones de navegación
          Positioned(
            top: 0,
            bottom: 0,
            left: 20,
            child: Center(
              child: _buildNavButton(
                icon: Icons.arrow_back_ios,
                onTap: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 20,
            child: Center(
              child: _buildNavButton(
                icon: Icons.arrow_forward_ios,
                onTap: () {
                  if (_currentPage < _bannerData.length - 1) {
                    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerItem(Map<String, dynamic> data) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        LoadingImage(imagePath: data['image'], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.black),

        // Contenido centrado
        Center(
          child: Container(
            width: 800,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['title'], style: const TextStyle(fontFamily: 'Playfair Display', fontSize: 46, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2, letterSpacing: 0.5, shadows: [Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 2))])),
                const SizedBox(height: 20),
                Text(data['subtitle'], style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.9), height: 1.5, letterSpacing: 0.5, shadows: const [Shadow(color: Colors.black45, blurRadius: 5, offset: Offset(0, 2))])),
                const SizedBox(height: 40),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: widget.onExploreProperties,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16), elevation: 0),
                      child: const Text('EXPLORAR PROPIEDADES', style: TextStyle(fontSize: 14, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white, width: 1), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16)),
                      child: const Text('CONTÁCTANOS', style: TextStyle(fontSize: 14, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(onTap: onTap, child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), border: Border.all(color: Colors.white.withOpacity(0.3))), child: Icon(icon, color: Colors.white, size: 16)));
  }
}
