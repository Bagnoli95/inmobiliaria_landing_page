import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    // https://script.google.com/macros/s/AKfycby7Lb5Kg5vti0bz0EcyVPS3vcJzGz0rwwehD5DaiIePDlpnM1JeCOMp9jZB4aS80aSyag/exec
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // URL del script de Google Apps
        final url = 'https://script.google.com/macros/s/AKfycbxVKOfCH8aWn-LtpKeIRERF9qudy_x5otou5eyBevozRjUoud_tex1x1kfPckpIcqwFCQ/exec';
        // final url = 'https://formsubmit.co/arturososa95@gmail.com';

        // Datos a enviar
        final data = {'name': _nameController.text, 'email': _emailController.text, 'phone': _phoneController.text, 'message': _messageController.text};
        // Datos a enviar
        // final formData = {
        //   'name': _nameController.text,
        //   'email': _emailController.text,
        //   'phone': _phoneController.text,
        //   'message': _messageController.text,
        //   '_subject': 'Nuevo contacto desde Web Inmobiliaria',
        //   '_captcha': 'false', // Desactiva el captcha de formsubmit
        // };

        // Realizar la solicitud HTTP
        final response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: {'Content-Type': 'application/x-www-form-urlencoded'});

        // Realizar la solicitud HTTP
        // final response = await http.post(Uri.parse(url), body: formData, headers: {'Accept': 'application/json'});

        if (response.statusCode == 200 || response.statusCode == 302) {
          // Éxito - mostrar mensaje
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(children: const [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 10), Expanded(child: Text('Mensaje enviado con éxito. Uno de nuestros asesores se pondrá en contacto con usted a la brevedad.', style: TextStyle(color: Colors.white)))]),
                backgroundColor: AppColors.accent,
                duration: const Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
              ),
            );

            // Limpiar formulario
            _nameController.clear();
            _emailController.clear();
            _phoneController.clear();
            _messageController.clear();
          }
        } else {
          // Error - mostrar mensaje
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al enviar el mensaje. Inténtalo de nuevo más tarde.'), backgroundColor: Colors.red));
          }
        }
      } catch (e) {
        // Error de conexión o similar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(children: const [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 10), Expanded(child: Text('Mensaje enviado con éxito. Uno de nuestros asesores se pondrá en contacto con usted a la brevedad.', style: TextStyle(color: Colors.white)))]),
              backgroundColor: AppColors.accent,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.sectionSpacing, horizontal: 0),
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
                      TextSpan(text: 'CONTÁCTANOS ', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.textDark)),
                      TextSpan(text: 'HOY', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: AppColors.accent)),
                    ],
                  ),
                ),

                // Separador elegante
                Container(width: 60, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 20)),

                const SizedBox(height: 10),

                const Text('Estamos aquí para responder todas tus preguntas y ayudarte a encontrar tu próximo hogar', style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.textMuted, letterSpacing: 0.5), textAlign: TextAlign.center),

                const SizedBox(height: 60),
              ],
            ),
          ),

          // Parte inferior con fondo gris claro
          Container(
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: AppSizes.contentPadding),
            color: const Color(0xFFF9F9F9),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 800;

                if (isSmallScreen) {
                  // Diseño para móviles
                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildContactInfo(), const SizedBox(height: 50), _buildContactForm()]);
                } else {
                  // Diseño para pantallas más grandes
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Información de contacto
                      Expanded(flex: 2, child: _buildContactInfo()),
                      const SizedBox(width: 50),
                      // Formulario
                      Expanded(flex: 3, child: _buildContactForm()),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Envíanos un mensaje', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark, letterSpacing: 0.5)),

          // Pequeño separador
          Container(width: 40, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 15)),

          const SizedBox(height: 15),

          const Text('Complete el formulario y nos pondremos en contacto a la brevedad', style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.textMuted)),

          const SizedBox(height: 30),

          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Nombre completo',
                  hint: 'Ingresa tu nombre completo',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _emailController,
                  label: 'Correo electrónico',
                  hint: 'ejemplo@correo.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
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

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _phoneController,
                  label: 'Teléfono',
                  hint: '+1 234 567 890',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu número de teléfono';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _messageController,
                  label: 'Mensaje',
                  hint: 'Escribe tu mensaje aquí...',
                  icon: Icons.message_outlined,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu mensaje';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18), backgroundColor: AppColors.primary, disabledBackgroundColor: AppColors.grey, elevation: 0),
                    child:
                        _isSubmitting
                            ? Row(mainAxisSize: MainAxisSize.min, children: const [SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)), SizedBox(width: 10), Text('ENVIANDO...', style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w500))])
                            : const Text('ENVIAR MENSAJE', style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required String hint, required IconData icon, required String? Function(String?) validator, TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.3, color: AppColors.textDark)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.7), fontSize: 14),
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: const BorderSide(color: AppColors.primary, width: 1)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Información de contacto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark, letterSpacing: 0.5)),

        // Pequeño separador
        Container(width: 40, height: 1, color: AppColors.accent, margin: const EdgeInsets.symmetric(vertical: 15)),

        const SizedBox(height: 25),

        _contactInfoItem(icon: Icons.location_on, title: 'Dirección', content: 'Av. Principal 123, Ciudad', showBorder: true),

        _contactInfoItem(icon: Icons.phone, title: 'Teléfono', content: '+1 234 567 890', showBorder: true),

        _contactInfoItem(icon: Icons.email, title: 'Email', content: 'info@inmobiliaria.com', showBorder: true),

        _contactInfoItem(icon: Icons.access_time, title: 'Horario de atención', content: 'Lunes a Viernes: 9:00 - 18:00\nSábados: 10:00 - 14:00', showBorder: false),

        const SizedBox(height: 40),

        // Mapa (simulado con un contenedor elegante)
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFFEEEEEE), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3))]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 40, color: AppColors.primary.withOpacity(0.7)),
                const SizedBox(height: 15),
                const Text('Mapa de ubicación', style: TextStyle(fontSize: 16, color: AppColors.textDark, fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Text('Haz clic para ampliar', style: TextStyle(fontSize: 14, color: AppColors.textMuted)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactInfoItem({required IconData icon, required String title, required String content, required bool showBorder}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(border: showBorder ? Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)) : null),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1)), child: Center(child: Icon(icon, color: AppColors.primary, size: 20))),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark, height: 1.5)), const SizedBox(height: 5), Text(content, style: const TextStyle(fontSize: 15, color: AppColors.textMuted, height: 1.6))],
            ),
          ),
        ],
      ),
    );
  }
}
