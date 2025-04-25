import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({Key? key}) : super(key: key);

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'Carlos Rodríguez',
      'position': 'Inversionista',
      'image': 'assets/images/testimonial_1.jpg',
      'text': 'La experiencia con esta inmobiliaria ha sido excepcional. Encontré la propiedad perfecta para mi inversión y el proceso fue completamente transparente. El equipo me acompañó durante cada etapa y se aseguró de que todos los detalles estuvieran cubiertos.',
      'rating': 5,
    },
    {
      'name': 'Marta Jiménez',
      'position': 'Propietaria',
      'image': 'assets/images/testimonial_2.jpg',
      'text': 'Vendí mi apartamento a través de ellos y lograron un precio muy por encima de mis expectativas. Su estrategia de marketing y su conocimiento del mercado fueron clave para alcanzar este resultado tan positivo.',
      'rating': 5,
    },
    {
      'name': 'Alejandro Torres',
      'position': 'Comprador',
      'image': 'assets/images/testimonial_3.jpg',
      'text': 'Como extranjero buscando invertir en propiedades locales, necesitaba un equipo de confianza que me guiara a través del proceso. Encontré exactamente eso aquí. Su asesoramiento profesional y atención personalizada hicieron toda la diferencia.',
      'rating': 4,
    },
  ];

  @override
  void initState() {
    super.initState();

    // Auto-avance del carrusel
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        _autoAdvanceCarousel();
      }
    });
  }

  void _autoAdvanceCarousel() {
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        if (_currentPage < _testimonials.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);

        _autoAdvanceCarousel();
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
      padding: EdgeInsets.symmetric(vertical: AppSizes.sectionSpacing, horizontal: 0),
      color: const Color(0xFFF9F9F9),
      child: Column(
        children: [
          // Título elegante con acento dorado
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: 'LO QUE DICEN ', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark)),
                TextSpan(text: 'NUESTROS CLIENTES', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.accent)),
              ],
            ),
          ),

          // Separador elegante
          Container(width: 60, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),

          const SizedBox(height: 10),

          // Subtítulo descriptivo
          const Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: Text('Más de 200 clientes satisfechos nos avalan. Conoce sus experiencias.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textMuted, letterSpacing: 0.5))),

          const SizedBox(height: 50),

          // Carrusel de testimonios
          SizedBox(
            height: 350,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                return _buildTestimonialCard(_testimonials[index]);
              },
            ),
          ),

          const SizedBox(height: 30),

          // Indicadores de página
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_testimonials.length, (index) {
              return Container(width: 10, height: 10, margin: const EdgeInsets.symmetric(horizontal: 5), decoration: BoxDecoration(shape: BoxShape.circle, color: _currentPage == index ? AppColors.accent : AppColors.grey.withOpacity(0.3)));
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Stack(
        children: [
          // Comillas decorativas
          Positioned(top: 30, left: 30, child: Icon(Icons.format_quote, size: 60, color: AppColors.primary.withOpacity(0.1))),

          // Contenido del testimonio
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Texto del testimonio
                Text(testimonial['text'], style: const TextStyle(fontSize: 16, height: 1.7, color: AppColors.textDark, fontStyle: FontStyle.italic)),

                const SizedBox(height: 30),

                // Separador
                Container(width: 50, height: 1, color: AppColors.primary.withOpacity(0.2)),

                const SizedBox(height: 30),

                // Información del cliente
                Row(
                  children: [
                    // Foto de perfil
                    Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2), image: DecorationImage(image: AssetImage(testimonial['image']), fit: BoxFit.cover))),

                    const SizedBox(width: 20),

                    // Nombre y posición
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(testimonial['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)), const SizedBox(height: 5), Text(testimonial['position'], style: const TextStyle(fontSize: 14, color: AppColors.textMuted))],
                    ),

                    const Spacer(),

                    // Estrellas de valoración
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(index < testimonial['rating'] ? Icons.star : Icons.star_border, color: AppColors.accent, size: 18);
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
