import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:inmobiliaria_app/utils/constants.dart';

class ApartmentViewV2 extends StatefulWidget {
  final Function(String) onRoomSelected;

  const ApartmentViewV2({Key? key, required this.onRoomSelected}) : super(key: key);

  @override
  State<ApartmentViewV2> createState() => _ApartmentViewV2State();
}

class _ApartmentViewV2State extends State<ApartmentViewV2> {
  // Controlador para la animación de Rive
  StateMachineController? _riveController;

  // Inputs para controlar las animaciones
  SMIInput<bool>? _hoverInputHoverPuerta;
  SMIInput<bool>? _hoverInputHoverVentArriba;
  SMIInput<bool>? _hoverInputHoverVentAbajo;
  SMIInput<bool>? _hoverInputHoverBalcony;
  SMIInput<bool>? _hoverInputClouds;

  // Para mantener el estado de la habitación seleccionada
  String _selectedRoom = '';

  @override
  void dispose() {
    _riveController?.dispose();
    super.dispose();
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'ApartmentInteraction', // Nombre de la máquina de estados en Rive
    );

    if (controller != null) {
      artboard.addController(controller);
      _riveController = controller;

      // Conectar con las entradas definidas en Rive
      _hoverInputHoverPuerta = controller.findInput<bool>('HoverPuerta');
      _hoverInputHoverVentArriba = controller.findInput<bool>('HoverVentArriba');
      _hoverInputHoverVentAbajo = controller.findInput<bool>('HoverVentAbajo');
      _hoverInputHoverBalcony = controller.findInput<bool>('HoverBalcony');
      _hoverInputClouds = controller.findInput<bool>('HoverClouds');
    }
  }

  void _updateRoomInfo(String room) {
    if (_selectedRoom != room) {
      setState(() {
        _selectedRoom = room;
      });

      // Notificar al padre sobre el cambio de habitación
      widget.onRoomSelected(room);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Ajustar el tamaño según el espacio disponible
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // Animación Rive
            RepaintBoundary(child: RiveAnimation.asset('assets/apartment_interactive_2.riv', fit: BoxFit.contain, onInit: _onRiveInit)),

            // // Áreas transparentes para la interacción
            // Positioned(
            //   top: height * 0.1,
            //   left: width * 0.1,
            //   width: width * 0.3,
            //   height: height * 0.25,
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       if (_hoverInputHoverPuerta != null) _hoverInputHoverPuerta!.value = true;
            //       _updateRoomInfo('living');
            //     },
            //     onExit: (_) {
            //       if (_hoverInputHoverPuerta != null) _hoverInputHoverPuerta!.value = false;
            //     },
            //     child: Container(color: Colors.blue.withOpacity(0.3), child: Center(child: Text('Área 1 - Ventana Arriba', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
            //   ),
            // ),

            // Positioned(
            //   top: height * 0.1,
            //   right: width * 0.1,
            //   width: width * 0.3,
            //   height: height * 0.25,
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       if (_hoverInputHoverVentArriba != null) _hoverInputHoverVentArriba!.value = true;
            //       _updateRoomInfo('kitchen');
            //     },
            //     onExit: (_) {
            //       if (_hoverInputHoverVentArriba != null) _hoverInputHoverVentArriba!.value = false;
            //     },
            //     child: Container(color: Colors.blue.withOpacity(0.3), child: Center(child: Text('Área 2 - Ventana Arriba', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
            //   ),
            // ),

            // Positioned(
            //   bottom: height * 0.15,
            //   left: width * 0.15,
            //   width: width * 0.25,
            //   height: height * 0.25,
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       if (_hoverInputHoverVentAbajo != null) _hoverInputHoverVentAbajo!.value = true;
            //       _updateRoomInfo('bedroom');
            //     },
            //     onExit: (_) {
            //       if (_hoverInputHoverVentAbajo != null) _hoverInputHoverVentAbajo!.value = false;
            //     },
            //     child: Container(color: Colors.blue.withOpacity(0.3), child: Center(child: Text('Área 3 - Ventana Arriba', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
            //   ),
            // ),

            // Positioned(
            //   bottom: height * 0.15,
            //   right: width * 0.15,
            //   width: width * 0.2,
            //   height: height * 0.2,
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       if (_hoverInputHoverBalcony != null) _hoverInputHoverBalcony!.value = true;
            //       _updateRoomInfo('bathroom');
            //     },
            //     onExit: (_) {
            //       if (_hoverInputHoverBalcony != null) _hoverInputHoverBalcony!.value = false;
            //     },
            //     child: Container(color: Colors.blue.withOpacity(0.3), child: Center(child: Text('Área 4 - Ventana Arriba', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
            //   ),
            // ),

            // Positioned(
            //   bottom: height * 0.15,
            //   right: width * 0.15,
            //   width: width * 0.2,
            //   height: height * 0.2,
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       if (_hoverInputClouds != null) _hoverInputClouds!.value = true;
            //       _updateRoomInfo('bathroom');
            //     },
            //     onExit: (_) {
            //       if (_hoverInputClouds != null) _hoverInputClouds!.value = false;
            //     },
            //     child: Container(color: Colors.blue.withOpacity(0.3), child: Center(child: Text('Área 4 - Ventana Arriba', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
            //   ),
            // ),

            // Instrucciones para el usuario (desaparece después de la primera interacción)
            // if (_selectedRoom.isEmpty)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                  child: const Text('Pasa el cursor sobre las habitaciones para explorar', style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Widget adaptativo para diferentes plataformas
class AdaptiveApartmentViewV2 extends StatelessWidget {
  final Function(String) onRoomSelected;

  const AdaptiveApartmentViewV2({Key? key, required this.onRoomSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detectar si estamos en dispositivo móvil
    final isMobile = MediaQuery.of(context).size.width < 600;

    return isMobile ? MobileApartmentView(onRoomSelected: onRoomSelected) : ApartmentViewV2(onRoomSelected: onRoomSelected);
  }
}

// Versión específica para móviles
class MobileApartmentView extends StatefulWidget {
  final Function(String) onRoomSelected;

  const MobileApartmentView({Key? key, required this.onRoomSelected}) : super(key: key);

  @override
  State<MobileApartmentView> createState() => _MobileApartmentViewState();
}

class _MobileApartmentViewState extends State<MobileApartmentView> {
  StateMachineController? _riveController;
  SMIInput<bool>? _tapInputLivingRoom;
  SMIInput<bool>? _tapInputKitchen;
  SMIInput<bool>? _tapInputBedroom;
  SMIInput<bool>? _tapInputBathroom;

  String _selectedRoom = '';

  @override
  void dispose() {
    _riveController?.dispose();
    super.dispose();
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'ApartmentInteraction');

    if (controller != null) {
      artboard.addController(controller);
      _riveController = controller;

      // En móvil usamos los mismos inputs pero activados con tap en lugar de hover
      _tapInputLivingRoom = controller.findInput<bool>('HoverLivingRoom');
      _tapInputKitchen = controller.findInput<bool>('HoverKitchen');
      _tapInputBedroom = controller.findInput<bool>('HoverBedroom');
      _tapInputBathroom = controller.findInput<bool>('HoverBathroom');
    }
  }

  void _handleRoomTap(String room) {
    // Si ya está seleccionada, deseleccionar
    if (_selectedRoom == room) {
      _resetAllRooms();
      _selectedRoom = '';
      widget.onRoomSelected('');
      return;
    }

    // Resetear todas las habitaciones
    _resetAllRooms();

    // Activar la nueva habitación seleccionada
    setState(() {
      _selectedRoom = room;

      switch (room) {
        case 'living':
          if (_tapInputLivingRoom != null) _tapInputLivingRoom!.value = true;
          break;
        case 'kitchen':
          if (_tapInputKitchen != null) _tapInputKitchen!.value = true;
          break;
        case 'bedroom':
          if (_tapInputBedroom != null) _tapInputBedroom!.value = true;
          break;
        case 'bathroom':
          if (_tapInputBathroom != null) _tapInputBathroom!.value = true;
          break;
      }

      widget.onRoomSelected(room);
    });
  }

  void _resetAllRooms() {
    if (_tapInputLivingRoom != null) _tapInputLivingRoom!.value = false;
    if (_tapInputKitchen != null) _tapInputKitchen!.value = false;
    if (_tapInputBedroom != null) _tapInputBedroom!.value = false;
    if (_tapInputBathroom != null) _tapInputBathroom!.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // Animación Rive
            RepaintBoundary(child: RiveAnimation.asset('assets/apartment_interactive.riv', fit: BoxFit.contain, onInit: _onRiveInit)),

            // Áreas para tap en móvil
            Positioned(top: height * 0.1, left: width * 0.1, width: width * 0.3, height: height * 0.25, child: GestureDetector(onTap: () => _handleRoomTap('living'), child: Container(color: Colors.transparent, child: _roomIndicator(_selectedRoom == 'living')))),

            Positioned(top: height * 0.1, right: width * 0.1, width: width * 0.3, height: height * 0.25, child: GestureDetector(onTap: () => _handleRoomTap('kitchen'), child: Container(color: Colors.transparent, child: _roomIndicator(_selectedRoom == 'kitchen')))),

            Positioned(bottom: height * 0.15, left: width * 0.15, width: width * 0.25, height: height * 0.25, child: GestureDetector(onTap: () => _handleRoomTap('bedroom'), child: Container(color: Colors.transparent, child: _roomIndicator(_selectedRoom == 'bedroom')))),

            Positioned(bottom: height * 0.15, right: width * 0.15, width: width * 0.2, height: height * 0.2, child: GestureDetector(onTap: () => _handleRoomTap('bathroom'), child: Container(color: Colors.transparent, child: _roomIndicator(_selectedRoom == 'bathroom')))),

            // Instrucciones para el usuario
            if (_selectedRoom.isEmpty)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                    child: const Text('Toca en las habitaciones para explorar', style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // Indicador visual para la habitación seleccionada en móvil
  Widget _roomIndicator(bool isSelected) {
    if (!isSelected) return const SizedBox.shrink();

    return Center(child: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2)), child: const Icon(Icons.touch_app, color: AppColors.primary, size: 20)));
  }
}
