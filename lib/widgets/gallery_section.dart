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
      padding: EdgeInsets.symmetric(vertical: AppSizes.sectionSpacing, horizontal: AppSizes.contentPadding),
      color: AppColors.greyLight,
      child: Column(
        children: [
          const Text('GALERÍA', style: AppTextStyles.heading2, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          const Text('Conoce todos los espacios de nuestro exclusivo departamento', style: AppTextStyles.body, textAlign: TextAlign.center),
          const SizedBox(height: 40),

          // Imagen principal destacada
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;
              final imageHeight = isSmallScreen ? 250.0 : 400.0;

              return Column(
                children: [
                  // Imagen destacada
                  AnimatedSwitcher(
                    duration: AppAnimations.medium,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Container(
                      height: imageHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.imageRadius), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                        child: IndexedStack(
                          index: _selectedImageIndex,
                          sizing: StackFit.expand,
                          children: List.generate(_imagePaths.length, (index) {
                            return LoadingImage(key: ValueKey<String>(_imagePaths[index]), imagePath: _imagePaths[index], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.grey[200]!);
                          }),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Descripción de la imagen
                  AnimatedSwitcher(duration: AppAnimations.medium, child: Text(_imageDescriptions[_selectedImageIndex], key: ValueKey<int>(_selectedImageIndex), style: AppTextStyles.body, textAlign: TextAlign.center)),

                  const SizedBox(height: 30),

                  // Miniaturas para selección
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                              // Agrega un log para depuración
                              print("Cambiando a imagen $index: ${_imagePaths[index]}");
                            },
                            child: Container(
                              width: 120,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.imageRadius), border: Border.all(color: _selectedImageIndex == index ? AppColors.primary : Colors.transparent, width: 3)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppSizes.imageRadius - 3),
                                child: Stack(
                                  children: [
                                    // Imagen de miniatura con carga
                                    LoadingImage(imagePath: _imagePaths[index], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.grey[200]!),

                                    // Filtro para miniaturas no seleccionadas
                                    if (_selectedImageIndex != index) Positioned.fill(child: Container(color: Colors.black.withOpacity(0.4))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 50),

          // Grid de imágenes (para pantallas más grandes)
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                // En móviles no mostramos el grid adicional
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  const Text('Más imágenes', style: AppTextStyles.heading3, textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(6, (index) {
                      return Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.imageRadius), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3))]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                              onTap: () {
                                setState(() {
                                  _selectedImageIndex = index;
                                });
                              },
                              child: LoadingImage(imagePath: _imagePaths[index], fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json', backgroundColor: Colors.grey[200]!, borderRadius: BorderRadius.circular(AppSizes.imageRadius)),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
