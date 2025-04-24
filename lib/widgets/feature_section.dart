import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({Key? key}) : super(key: key);

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
                TextSpan(text: 'CARACTERÍSTICAS ', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark)),
                TextSpan(text: 'DESTACADAS', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.accent)),
              ],
            ),
          ),

          // Separador elegante
          Container(width: 60, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),

          const SizedBox(height: 10),

          const Text('Descubre las comodidades exclusivas que elevan la experiencia de vivir en nuestro desarrollo', style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textMuted, letterSpacing: 0.5), textAlign: TextAlign.center),

          const SizedBox(height: 70),

          LayoutBuilder(
            builder: (context, constraints) {
              // Diseño responsivo
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                // Diseño para pantallas pequeñas (móviles)
                return Column(
                  children: [
                    _buildFeatureCard(icon: Icons.security, title: 'Seguridad 24/7', description: 'Vigilancia permanente y sistema de cámaras de última generación para mayor tranquilidad.'),
                    const SizedBox(height: 40),
                    _buildFeatureCard(icon: Icons.fitness_center, title: 'Gimnasio Equipado', description: 'Área de fitness con máquinas profesionales y espacio para yoga y ejercicios funcionales.'),
                    const SizedBox(height: 40),
                    _buildFeatureCard(icon: Icons.pool, title: 'Piscina Climatizada', description: 'Piscina temperada con área de descanso y sombrillas para relajación durante todo el año.'),
                    const SizedBox(height: 40),
                    _buildFeatureCard(icon: Icons.local_parking, title: 'Estacionamiento', description: 'Dos espacios de estacionamiento subterráneo incluidos con acceso directo al elevador.'),
                  ],
                );
              } else {
                // Diseño para pantallas más grandes con efecto hover
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFeatureCard(icon: Icons.security, title: 'Seguridad 24/7', description: 'Vigilancia permanente y sistema de cámaras de última generación para mayor tranquilidad.')),
                        const SizedBox(width: 30),
                        Expanded(child: _buildFeatureCard(icon: Icons.fitness_center, title: 'Gimnasio Equipado', description: 'Área de fitness con máquinas profesionales y espacio para yoga y ejercicios funcionales.')),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFeatureCard(icon: Icons.pool, title: 'Piscina Climatizada', description: 'Piscina temperada con área de descanso y sombrillas para relajación durante todo el año.')),
                        const SizedBox(width: 30),
                        Expanded(child: _buildFeatureCard(icon: Icons.local_parking, title: 'Estacionamiento', description: 'Dos espacios de estacionamiento subterráneo incluidos con acceso directo al elevador.')),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.accent.withOpacity(0.2)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono con fondo
          Container(width: 70, height: 70, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), border: Border.all(color: AppColors.primary.withOpacity(0.2))), child: Center(child: Icon(icon, size: 30, color: AppColors.primary))),
          const SizedBox(height: 25),

          // Título
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark, letterSpacing: 0.5)),

          // Pequeño separador
          Container(width: 40, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 15)),

          // Descripción
          Text(description, style: const TextStyle(fontSize: 15, height: 1.6, color: AppColors.textMuted)),

          const SizedBox(height: 20),

          // Botón "Ver más" discreto
          Row(children: [Text('Ver detalles', style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500)), const SizedBox(width: 5), Icon(Icons.arrow_forward, size: 16, color: AppColors.primary)]),
        ],
      ),
    );
  }
}
