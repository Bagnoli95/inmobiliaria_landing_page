import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String lottieAsset;
  final Color backgroundColor;
  final BorderRadius? borderRadius;

  const LoadingImage({Key? key, required this.imagePath, this.fit = BoxFit.cover, this.width, this.height, this.lottieAsset = 'assets/animations/loading_spinner.json', this.backgroundColor = Colors.white10, this.borderRadius}) : super(key: key);

  @override
  State<LoadingImage> createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  bool _isLoading = true;
  bool _hasError = false;
  String _currentImagePath = '';

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
  }

  @override
  void didUpdateWidget(LoadingImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Aquí está la clave: detectar cambios en imagePath
    if (oldWidget.imagePath != widget.imagePath) {
      setState(() {
        _currentImagePath = widget.imagePath;
        _isLoading = true;
        _hasError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // Fondo de carga o placeholder
          Container(
            width: widget.width,
            height: widget.height,
            color: widget.backgroundColor,
            child:
                _isLoading
                    ? Center(child: Lottie.asset(widget.lottieAsset, width: 100, height: 100, fit: BoxFit.contain))
                    : _hasError
                    ? Center(child: Icon(Icons.broken_image_outlined, size: 50, color: Colors.grey[400]))
                    : const SizedBox.shrink(),
          ),

          // Imagen real (invisible mientras carga)
          Opacity(
            opacity: _isLoading || _hasError ? 0.0 : 1.0,
            child: Image.asset(
              widget.imagePath,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              errorBuilder: (context, error, stackTrace) {
                // Si hay error al cargar la imagen
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _hasError = true;
                      _isLoading = false;
                    });
                  }
                });
                return const SizedBox.shrink();
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                // Cuando la imagen ha cargado completamente
                if (wasSynchronouslyLoaded) {
                  return child;
                } else {
                  if (frame != null && _isLoading) {
                    // La imagen ha cargado, actualizar estado
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    });
                  }
                  return child;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Variante para cargar imágenes de red
class LoadingNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String lottieAsset;
  final Color backgroundColor;
  final BorderRadius? borderRadius;

  const LoadingNetworkImage({Key? key, required this.imageUrl, this.fit = BoxFit.cover, this.width, this.height, this.lottieAsset = 'assets/animations/loading_spinner.json', this.backgroundColor = Colors.white10, this.borderRadius}) : super(key: key);

  @override
  State<LoadingNetworkImage> createState() => _LoadingNetworkImageState();
}

class _LoadingNetworkImageState extends State<LoadingNetworkImage> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // Fondo de carga o placeholder
          Container(
            width: widget.width,
            height: widget.height,
            color: widget.backgroundColor,
            child:
                _isLoading
                    ? Center(child: Lottie.asset(widget.lottieAsset, width: 100, height: 100, fit: BoxFit.contain))
                    : _hasError
                    ? Center(child: Icon(Icons.broken_image_outlined, size: 50, color: Colors.grey[400]))
                    : const SizedBox.shrink(),
          ),

          // Imagen real (invisible mientras carga)
          Opacity(
            opacity: _isLoading || _hasError ? 0.0 : 1.0,
            child: Image.network(
              widget.imageUrl,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  // La imagen ha cargado completamente
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && _isLoading) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  });
                  return child;
                }
                return const SizedBox.shrink();
              },
              errorBuilder: (context, error, stackTrace) {
                // Si hay error al cargar la imagen
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _hasError = true;
                      _isLoading = false;
                    });
                  }
                });
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
