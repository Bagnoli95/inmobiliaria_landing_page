import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';
import 'package:inmobiliaria_app/widgets/loading_image.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({Key? key}) : super(key: key);

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  // Índice de la imagen destacada
  int _selectedImageIndex = 0;

  // Lista de imágenes
  final List<String> _imagePaths = ['assets/images/apartment_1.jpg', 'assets/images/apartment_2.jpg', 'assets/images/apartment_3.jpg', 'assets/images/apartment_4.jpg', 'assets/images/apartment_5.jpg', 'assets/images/apartment_6.jpg'];

  // Descripciones de las imágenes
  final List<String> _imageDescriptions = ['Amplia sala de estar con vista panorámica', 'Cocina moderna con acabados de primera', 'Dormitorio principal con baño en suite', 'Segundo dormitorio con espacio de trabajo', 'Tercer dormitorio ideal para invitados', 'Terraza con área de parrilla'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.sectionSpacing,
        horizontal: 0, // Sin padding horizontal para imágenes a ancho completo
      ),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.contentPadding),
            child: Column(
              children: [
                // Título elegante con acento dorado
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'GALERÍA ', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark)),
                      TextSpan(text: 'DE ESPACIOS', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.accent)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // Separador elegante
                Container(width: 60, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),
                const SizedBox(height: 5),
                const Text('Conoce todos los espacios de nuestro exclusivo departamento', style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textMuted, letterSpacing: 0.5), textAlign: TextAlign.center),
                const SizedBox(height: 50),
              ],
            ),
          ),

          // Imagen principal destacada
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;
              final imageHeight = isSmallScreen ? 350.0 : 500.0;

              return Column(
                children: [
                  // Imagen destacada
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      children: [
                        // Imagen principal
                        Positioned.fill(
                          child: IndexedStack(
                            index: _selectedImageIndex,
                            sizing: StackFit.expand,
                            children: List.generate(_imagePaths.length, (index) {
                              return LoadingImage(key: ValueKey<String>(_imagePaths[index]), imagePath: _imagePaths[index], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.grey[200]!);
                            }),
                          ),
                        ),

                        // Overlay con gradiente
                        Positioned(bottom: 0, left: 0, right: 0, height: 200, child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)])))),

                        // Descripción de la imagen
                        Positioned(
                          bottom: 40,
                          left: 50,
                          right: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Indicador numérico elegante
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(border: Border.all(color: AppColors.accent, width: 1)),
                                child: Text('${_selectedImageIndex + 1}/${_imagePaths.length}', style: const TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 10),
                              // Texto de descripción
                              AnimatedSwitcher(duration: AppAnimations.medium, child: Text(_imageDescriptions[_selectedImageIndex], key: ValueKey<int>(_selectedImageIndex), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white, height: 1.4, letterSpacing: 0.5))),
                            ],
                          ),
                        ),

                        // Botones de navegación
                        if (!isSmallScreen) ...[
                          // Botón anterior
                          Positioned(
                            left: 20,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _buildNavButton(
                                icon: Icons.arrow_back_ios,
                                onTap: () {
                                  setState(() {
                                    _selectedImageIndex = (_selectedImageIndex - 1 + _imagePaths.length) % _imagePaths.length;
                                  });
                                },
                              ),
                            ),
                          ),
                          // Botón siguiente
                          Positioned(
                            right: 20,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _buildNavButton(
                                icon: Icons.arrow_forward_ios,
                                onTap: () {
                                  setState(() {
                                    _selectedImageIndex = (_selectedImageIndex + 1) % _imagePaths.length;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Miniaturas elegantes para selección
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imagePaths.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedImageIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImageIndex = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: AppAnimations.fast,
                                width: 120,
                                decoration: BoxDecoration(borderRadius: BorderRadius.zero, border: Border.all(color: isSelected ? AppColors.accent : Colors.transparent, width: 2)),
                                child: Stack(
                                  children: [
                                    // Imagen de miniatura
                                    Positioned.fill(child: LoadingImage(imagePath: _imagePaths[index], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.grey[200]!)),

                                    // Filtro para miniaturas no seleccionadas
                                    if (!isSelected) Positioned.fill(child: Container(color: Colors.black.withOpacity(0.5))),

                                    // Número de imagen
                                    if (isSelected) Positioned(bottom: 5, right: 5, child: Container(padding: const EdgeInsets.all(4), color: AppColors.accent, child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 70),

          // Grid de imágenes (para pantallas más grandes) con estilo elegante
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                // En móviles no mostramos el grid adicional
                return const SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.contentPadding),
                child: Column(
                  children: [
                    Row(children: [Container(width: 40, height: 1, color: AppColors.accent), const SizedBox(width: 15), const Text('ESPACIOS DESTACADOS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark))]),
                    const SizedBox(height: 30),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.2, // Más ancho que alto
                      children: List.generate(6, (index) {
                        return _buildElegantGridItem(index);
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(onTap: onTap, child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), border: Border.all(color: Colors.white.withOpacity(0.3))), child: Icon(icon, color: Colors.white, size: 16)));
  }

  Widget _buildElegantGridItem(int index) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3))]),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen
          LoadingImage(imagePath: _imagePaths[index], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.grey[200]!),

          // Overlay con gradiente
          Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)])))),

          // Texto
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_imageDescriptions[index].split(' ').take(2).join(' '), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3)),
                Text(_imageDescriptions[index].split(' ').length > 2 ? _imageDescriptions[index].split(' ').skip(2).join(' ') : '', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8), height: 1.4), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),

          // Botón ver
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedImageIndex = index;
                });
              },
              child: Container(padding: const EdgeInsets.all(6), color: AppColors.accent, child: const Icon(Icons.visibility, color: Colors.white, size: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
