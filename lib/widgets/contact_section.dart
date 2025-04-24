import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/utils/constants.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // Controladores para los campos de texto
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  // Claves para validación de formulario
  final _formKey = GlobalKey<FormState>();

  // Estado para el botón de envío
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Función para enviar el formulario (simulada)
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulamos una petición a un servidor
      await Future.delayed(const Duration(seconds: 2));

      // Si estamos en un contexto montado
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        // Mostrar confirmación
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Mensaje enviado con éxito! Te contactaremos pronto.'), backgroundColor: AppColors.secondary, duration: Duration(seconds: 4)));

        // Limpiar formulario
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.sectionSpacing, horizontal: AppSizes.contentPadding),
      color: Colors.white,
      child: Column(
        children: [
          const Text('CONTÁCTANOS', style: AppTextStyles.heading2, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          const Text('Estamos aquí para resolver todas tus dudas', style: AppTextStyles.body, textAlign: TextAlign.center),
          const SizedBox(height: 60),

          // Contenido principal
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 800;

              if (isSmallScreen) {
                // Diseño para móviles
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildContactInfo(), const SizedBox(height: 40), _buildContactForm()]);
              } else {
                // Diseño para pantallas más grandes
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Formulario
                    Expanded(child: _buildContactForm()),
                    const SizedBox(width: 60),
                    // Información de contacto
                    Expanded(child: _buildContactInfo()),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Envíanos un mensaje', style: AppTextStyles.heading3),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo', hintText: 'Ingresa tu nombre completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Correo electrónico', hintText: 'ejemplo@correo.com'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }

                  // Validación básica de email
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Por favor ingresa un correo electrónico válido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono', hintText: '+1 234 567 890'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu número de teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Mensaje', hintText: 'Escribe tu mensaje aquí...', alignLabelWithHint: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu mensaje';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), disabledBackgroundColor: AppColors.grey),
                  child: _isSubmitting ? const Row(mainAxisSize: MainAxisSize.min, children: [SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)), SizedBox(width: 10), Text('ENVIANDO...')]) : const Text('ENVIAR MENSAJE'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Información de contacto', style: AppTextStyles.heading3),
        const SizedBox(height: 20),
        _contactInfoItem(Icons.location_on, 'Av. Principal 123, Ciudad'),
        _contactInfoItem(Icons.phone, '+1 234 567 890'),
        _contactInfoItem(Icons.email, 'info@inmobiliaria.com'),
        const SizedBox(height: 30),
        const Text('Horario de atención', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _contactInfoItem(Icons.access_time, 'Lunes a Viernes: 9:00 - 18:00'),
        _contactInfoItem(Icons.access_time, 'Sábados: 10:00 - 14:00'),

        const SizedBox(height: 40),

        // Mapa (simulado)
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.imageRadius), color: AppColors.greyLight, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3))]),
          child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.map, size: 50, color: AppColors.grey), const SizedBox(height: 10), Text('Mapa de ubicación', style: AppTextStyles.body.copyWith(color: AppColors.greyDark))])),
        ),
      ],
    );
  }

  Widget _contactInfoItem(IconData icon, String text) {
    return Padding(padding: const EdgeInsets.only(bottom: 15), child: Row(children: [Icon(icon, color: AppColors.primary, size: 20), const SizedBox(width: 15), Expanded(child: Text(text, style: AppTextStyles.body))]));
  }
}
