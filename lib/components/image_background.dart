import 'package:flutter/material.dart';
import 'package:inmobiliaria_app/widgets/loading_image.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/hero_background.jpg'), fit: BoxFit.fitWidth, colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken))));
  }
}

// Este es un widget separado para la imagen de fondo
class BackgroundImageWithLoading extends StatelessWidget {
  const BackgroundImageWithLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.7)]).createShader(rect);
      },
      blendMode: BlendMode.darken,
      child: SizedBox.expand(child: LoadingImage(imagePath: 'assets/images/hero_background.jpg', fit: BoxFit.cover, backgroundColor: Colors.grey[800]!, lottieAsset: 'assets/animations/loading_spinner.json')),
    );
  }
}
