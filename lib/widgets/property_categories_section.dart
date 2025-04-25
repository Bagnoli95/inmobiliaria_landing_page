import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';
import 'package:inmobiliaria_app/widgets/loading_image.dart';

class PropertyCategoriesSection extends StatelessWidget {
  final Function(String) onCategorySelected;

  const PropertyCategoriesSection({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.sectionSpacing, horizontal: AppSizes.contentPadding),
      color: Colors.white,
      child: Column(
        children: [
          // Título elegante con acento dorado
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: 'EXPLORA ', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark)),
                TextSpan(text: 'POR CATEGORÍA', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.accent)),
              ],
            ),
          ),

          // Separador elegante
          Container(width: 60, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),

          const SizedBox(height: 10),

          // Subtítulo descriptivo
          const Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: Text('Encuentra la propiedad perfecta para tus necesidades', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textMuted, letterSpacing: 0.5))),

          const SizedBox(height: 60),

          // Grid de categorías
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                // Vista de lista para móviles
                return Column(
                  children:
                      _buildCategoryItems().map((item) {
                        return Padding(padding: const EdgeInsets.only(bottom: 20), child: item);
                      }).toList(),
                );
              } else {
                // Vista de grid para pantallas grandes
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      _buildCategoryItems().map((item) {
                        return Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: item));
                      }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryItems() {
    final categories = [
      {'title': 'VENTA', 'image': 'assets/images/category_sale.jpg', 'count': '120 propiedades', 'id': 'sale'},
      {'title': 'ALQUILER', 'image': 'assets/images/category_rent.jpg', 'count': '85 propiedades', 'id': 'rent'},
      {'title': 'INVERSIÓN', 'image': 'assets/images/category_investment.jpg', 'count': '47 propiedades', 'id': 'investment'},
      {'title': 'PREMIUM', 'image': 'assets/images/category_premium.jpg', 'count': '32 propiedades', 'id': 'premium'},
    ];

    return categories.map((category) => _buildCategoryCard(title: category['title'] as String, image: category['image'] as String, count: category['count'] as String, id: category['id'] as String)).toList();
  }

  Widget _buildCategoryCard({required String title, required String image, required String count, required String id}) {
    return InkWell(
      onTap: () => onCategorySelected(id),
      child: Container(
        height: 300,
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo
            LoadingImage(imagePath: image, fit: BoxFit.cover, lottieAsset: 'assets/animations/loading_spinner.json'),

            // Overlay con gradiente
            Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]))),

            // Contenido
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0)),
                  const SizedBox(height: 5),
                  Text(count, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(border: Border.all(color: AppColors.accent), color: Colors.transparent),
                    child: const Text('EXPLORAR', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
