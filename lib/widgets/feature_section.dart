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
          const Text('CARACTERÍSTICAS DESTACADAS', style: AppTextStyles.heading2, textAlign: TextAlign.center),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              // Diseño responsivo
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                // Diseño para pantallas pequeñas (móviles)
                return Column(
                  children: [
                    _buildFeatureCard(icon: Icons.security, title: 'Seguridad 24/7', description: 'Vigilancia permanente y sistema de cámaras de última generación'),
                    const SizedBox(height: 30),
                    _buildFeatureCard(icon: Icons.fitness_center, title: 'Gimnasio Equipado', description: 'Área de fitness con máquinas profesionales y espacio para yoga'),
                    const SizedBox(height: 30),
                    _buildFeatureCard(icon: Icons.pool, title: 'Piscina Climatizada', description: 'Piscina temperada con área de descanso y sombrillas'),
                    const SizedBox(height: 30),
                    _buildFeatureCard(icon: Icons.local_parking, title: 'Estacionamiento', description: 'Dos espacios de estacionamiento subterráneo incluidos'),
                  ],
                );
              } else {
                // Diseño para pantallas más grandes
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureCard(icon: Icons.security, title: 'Seguridad 24/7', description: 'Vigilancia permanente y sistema de cámaras de última generación'),
                    _buildFeatureCard(icon: Icons.fitness_center, title: 'Gimnasio Equipado', description: 'Área de fitness con máquinas profesionales y espacio para yoga'),
                    _buildFeatureCard(icon: Icons.pool, title: 'Piscina Climatizada', description: 'Piscina temperada con área de descanso y sombrillas'),
                    _buildFeatureCard(icon: Icons.local_parking, title: 'Estacionamiento', description: 'Dos espacios de estacionamiento subterráneo incluidos'),
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
    return SizedBox(
      width: 230,
      child: Column(
        children: [
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(100)), child: Icon(icon, size: 40, color: AppColors.primary)),
          const SizedBox(height: 20),
          Text(title, style: AppTextStyles.heading3, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(description, textAlign: TextAlign.center, style: AppTextStyles.body.copyWith(color: AppColors.greyDark)),
        ],
      ),
    );
  }
}
