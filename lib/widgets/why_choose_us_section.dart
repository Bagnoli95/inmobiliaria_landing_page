import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({Key? key}) : super(key: key);

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
                TextSpan(text: 'POR QUÉ ', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark)),
                TextSpan(text: 'ELEGIRNOS', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.accent)),
              ],
            ),
          ),

          // Separador elegante
          Container(width: 60, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),

          const SizedBox(height: 10),

          // Subtítulo descriptivo
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text('Nos destacamos por ofrecer un servicio integral y personalizado en cada etapa del proceso inmobiliario', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textMuted, letterSpacing: 0.5)),
          ),

          const SizedBox(height: 60),

          // Ventajas competitivas en grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                return Column(children: _buildAdvantageItems());
              } else {
                return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 3, crossAxisSpacing: 30, mainAxisSpacing: 30, childAspectRatio: 0.85, children: _buildAdvantageItems());
              }
            },
          ),

          const SizedBox(height: 70),

          // Estadísticas de la empresa
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                return Column(
                  children: [
                    _buildStatItem('15+', 'Años de experiencia'),
                    const SizedBox(height: 30),
                    _buildStatItem('500+', 'Propiedades vendidas'),
                    const SizedBox(height: 30),
                    _buildStatItem('98%', 'Clientes satisfechos'),
                    const SizedBox(height: 30),
                    _buildStatItem('24/7', 'Atención personalizada'),
                  ],
                );
              } else {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.02), border: Border.all(color: AppColors.primary.withOpacity(0.1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('15+', 'Años de experiencia'),
                      Container(height: 70, width: 1, color: AppColors.primary.withOpacity(0.2)),
                      _buildStatItem('500+', 'Propiedades vendidas'),
                      Container(height: 70, width: 1, color: AppColors.primary.withOpacity(0.2)),
                      _buildStatItem('98%', 'Clientes satisfechos'),
                      Container(height: 70, width: 1, color: AppColors.primary.withOpacity(0.2)),
                      _buildStatItem('24/7', 'Atención personalizada'),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAdvantageItems() {
    final advantages = [
      {'icon': Icons.verified, 'title': 'Propiedades Verificadas', 'description': 'Todas nuestras propiedades pasan por un riguroso proceso de verificación legal y técnica.'},
      {'icon': Icons.location_city, 'title': 'Ubicaciones Exclusivas', 'description': 'Seleccionamos las mejores ubicaciones con alto potencial de valorización.'},
      {'icon': Icons.star, 'title': 'Servicio Premium', 'description': 'Acompañamiento personalizado durante todo el proceso de compra o venta.'},
      {'icon': Icons.attach_money, 'title': 'Inversiones Rentables', 'description': 'Propiedades con alto retorno de inversión y apreciación garantizada.'},
      {'icon': Icons.handshake, 'title': 'Asesoría Integral', 'description': 'Equipo de profesionales especializados en el mercado inmobiliario.'},
      {'icon': Icons.security, 'title': 'Seguridad Jurídica', 'description': 'Garantizamos la seguridad legal de todas nuestras operaciones inmobiliarias.'},
    ];

    return advantages.map((item) => _buildAdvantageItem(icon: item['icon'] as IconData, title: item['title'] as String, description: item['description'] as String)).toList();
  }

  Widget _buildAdvantageItem({required IconData icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.greyLight), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icono con fondo
          Container(width: 70, height: 70, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle), child: Center(child: Icon(icon, size: 30, color: AppColors.primary))),
          const SizedBox(height: 20),

          // Título
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark, letterSpacing: 0.5, height: 1.3)),

          // Pequeño separador
          Container(width: 30, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 15)),

          // Descripción
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, height: 1.6, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(children: [Text(value, style: TextStyle(fontFamily: 'Playfair Display', fontSize: 42, fontWeight: FontWeight.bold, color: AppColors.accent)), const SizedBox(height: 8), Text(label, style: TextStyle(fontSize: 14, letterSpacing: 0.5, color: AppColors.textDark))]);
  }
}
