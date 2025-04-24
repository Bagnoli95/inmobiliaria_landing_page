import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';
import 'package:inmobiliaria_app/widgets/loading_image.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({Key? key}) : super(key: key);

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  // Filtros
  String _selectedPropertyType = 'Todos';
  String _selectedBedrooms = 'Todos';
  double _minPrice = 100000;
  double _maxPrice = 500000;

  // Lista de propiedades (ejemplo)
  final List<Map<String, dynamic>> _properties = [
    {'title': 'Departamento Premium', 'location': 'Zona Centro, Ciudad', 'price': 250000, 'bedrooms': 3, 'bathrooms': 2, 'area': 120, 'type': 'Departamento', 'image': 'assets/images/apartment_1.jpg', 'isNew': true, 'isFeatured': true},
    {'title': 'Piso con Vista al Mar', 'location': 'Zona Costera, Playa del Carmen', 'price': 350000, 'bedrooms': 2, 'bathrooms': 2, 'area': 95, 'type': 'Departamento', 'image': 'assets/images/apartment_2.jpg', 'isNew': false, 'isFeatured': true},
    {'title': 'Apartamento Céntrico', 'location': 'Centro Histórico, Ciudad', 'price': 180000, 'bedrooms': 1, 'bathrooms': 1, 'area': 65, 'type': 'Departamento', 'image': 'assets/images/apartment_3.jpg', 'isNew': true, 'isFeatured': false},
    {'title': 'Casa Familiar', 'location': 'Zona Residencial, Ciudad', 'price': 450000, 'bedrooms': 4, 'bathrooms': 3, 'area': 220, 'type': 'Casa', 'image': 'assets/images/apartment_4.jpg', 'isNew': false, 'isFeatured': true},
    {'title': 'Piso en Zona Exclusiva', 'location': 'Barrio Alto, Ciudad', 'price': 320000, 'bedrooms': 3, 'bathrooms': 2, 'area': 110, 'type': 'Departamento', 'image': 'assets/images/apartment_5.jpg', 'isNew': false, 'isFeatured': false},
    {'title': 'Casa de Campo', 'location': 'Afueras, Ciudad', 'price': 280000, 'bedrooms': 3, 'bathrooms': 2, 'area': 150, 'type': 'Casa', 'image': 'assets/images/apartment_6.jpg', 'isNew': true, 'isFeatured': false},
  ];

  // Propiedades filtradas
  List<Map<String, dynamic>> get _filteredProperties {
    return _properties.where((property) {
      // Filtro por tipo
      if (_selectedPropertyType != 'Todos' && property['type'] != _selectedPropertyType) {
        return false;
      }

      // Filtro por dormitorios
      if (_selectedBedrooms != 'Todos') {
        int bedrooms = int.parse(_selectedBedrooms);
        if (property['bedrooms'] != bedrooms) {
          return false;
        }
      }

      // Filtro por precio
      if (property['price'] < _minPrice || property['price'] > _maxPrice) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Propiedades'), backgroundColor: AppColors.primary), body: Column(children: [_buildFilters(), Expanded(child: _buildPropertyGrid())]));
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filtros', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildDropdownFilter(
                label: 'Tipo',
                value: _selectedPropertyType,
                items: const ['Todos', 'Departamento', 'Casa'],
                onChanged: (value) {
                  setState(() {
                    _selectedPropertyType = value!;
                  });
                },
              ),
              _buildDropdownFilter(
                label: 'Dormitorios',
                value: _selectedBedrooms,
                items: const ['Todos', '1', '2', '3', '4+'],
                onChanged: (value) {
                  setState(() {
                    _selectedBedrooms = value!;
                  });
                },
              ),
              _buildPriceRangeFilter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter({required String label, required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
          child: DropdownButton<String>(
            value: value,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(height: 0),
            onChanged: onChanged,
            items:
                items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rango de precio', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$${_minPrice.toInt()}'),
            const SizedBox(width: 8),
            SizedBox(
              width: 200,
              child: RangeSlider(
                values: RangeValues(_minPrice, _maxPrice),
                min: 50000,
                max: 1000000,
                divisions: 19,
                labels: RangeLabels('\$${_minPrice.toInt()}', '\$${_maxPrice.toInt()}'),
                onChanged: (RangeValues values) {
                  setState(() {
                    _minPrice = values.start;
                    _maxPrice = values.end;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Text('\$${_maxPrice.toInt()}'),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyGrid() {
    if (_filteredProperties.isEmpty) {
      return const Center(child: Text('No se encontraron propiedades con los filtros seleccionados', style: AppTextStyles.body, textAlign: TextAlign.center));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1, // Ajusta este valor (aumentar para hacerlas más pequeñas)
        crossAxisSpacing: 20, // Aumenta para más espacio horizontal
        mainAxisSpacing: 25,
      ),
      itemCount: _filteredProperties.length,
      itemBuilder: (context, index) {
        final property = _filteredProperties[index];
        return _buildPropertyCard(property);
      },
    );
  }

  // Reemplaza tu método _buildPropertyCard actual por este que incluye el widget de carga
  Widget _buildPropertyCard(Map<String, dynamic> property) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de la propiedad
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSizes.cardRadius), topRight: Radius.circular(AppSizes.cardRadius)),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: LoadingImage(
                    imagePath: property['image'],
                    fit: BoxFit.cover,
                    lottieAsset: 'assets/animations/loading_spinner.json',
                    backgroundColor: Colors.grey[200]!,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSizes.cardRadius), topRight: Radius.circular(AppSizes.cardRadius)),
                  ),
                ),
              ),
              // Etiquetas (Nuevo, Destacado)
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    if (property['isNew'])
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(4)), child: const Text('NUEVO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                    const SizedBox(width: 4),
                    if (property['isFeatured'])
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
                        child: const Text('DESTACADO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
              // Precio
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSizes.cardRadius))),
                  child: Text('\$${property['price']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          // Información de la propiedad
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property['title'], style: AppTextStyles.heading3.copyWith(fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(children: [const Icon(Icons.location_on, size: 14, color: AppColors.grey), const SizedBox(width: 4), Expanded(child: Text(property['location'], style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey), maxLines: 1, overflow: TextOverflow.ellipsis))]),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildPropertyFeature(Icons.king_bed, '${property['bedrooms']}'), _buildPropertyFeature(Icons.bathtub, '${property['bathrooms']}'), _buildPropertyFeature(Icons.square_foot, '${property['area']} m²')]),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar a detalles de la propiedad
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10), textStyle: const TextStyle(fontSize: 14)),
                    child: const Text('VER DETALLES'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyFeature(IconData icon, String text) {
    return Row(children: [Icon(icon, size: 16, color: AppColors.greyDark), const SizedBox(width: 4), Text(text, style: AppTextStyles.bodySmall)]);
  }
}
