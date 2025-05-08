import 'package:flutter/material.dart';
import 'package:infrareportes/screen/home_screen.dart';

// Punto de entrada de la aplicación
void main() {
  // Inicializar el adaptador de tamaño antes de ejecutar la app
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const InfrasolApp());
}

// Clase principal de la aplicación
class InfrasolApp extends StatelessWidget {
  const InfrasolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeScaleAware(
      // Configuramos un diseño base de 375x812 (iPhone X)
      designSize: const Size(375, 812),
      child: MaterialApp(
        title: 'Infrasol',
        builder: (context, child) {
          // Aplicamos la escala consistente a toda la aplicación
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  1.0, // Forzamos un factor de escala de texto consistente
            ),
            child: child!,
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          // Definimos tamaños de texto consistentes
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            headlineMedium:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12),
          ),
          // Iconos con tamaño consistente
          iconTheme: const IconThemeData(
            size: 24,
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Widget que proporciona un contexto de escala consistente
class SizeScaleAware extends StatelessWidget {
  final Size designSize;
  final Widget child;

  const SizeScaleAware({
    Key? key,
    required this.designSize,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Inicializamos nuestro servicio de adaptación con el tamaño actual
        SizeAdapter.init(
          designWidth: designSize.width,
          designHeight: designSize.height,
          screenWidth: constraints.maxWidth > 0
              ? constraints.maxWidth
              : designSize.width,
          screenHeight: constraints.maxHeight > 0
              ? constraints.maxHeight
              : designSize.height,
        );
        return child;
      },
    );
  }
}

// Servicio para adaptar tamaños de manera consistente
class SizeAdapter {
  static double _scaleWidth = 1;
  static double _scaleHeight = 1;
  static double _scaleText = 1;

  // Inicializa el adaptador con las dimensiones de diseño y pantalla
  static void init({
    required double designWidth,
    required double designHeight,
    required double screenWidth,
    required double screenHeight,
  }) {
    _scaleWidth = screenWidth / designWidth;
    _scaleHeight = screenHeight / designHeight;

    // Tomamos el factor más pequeño para evitar desbordamientos
    _scaleText = _scaleWidth < _scaleHeight ? _scaleWidth : _scaleHeight;

    // Limitamos el factor de escala para textos para que no sean demasiado grandes
    if (_scaleText > 1.2) {
      _scaleText = 1.2;
    }
  }

  // Adapta un valor de ancho según la escala
  static double width(double width) {
    return width * _scaleWidth;
  }

  // Adapta un valor de alto según la escala
  static double height(double height) {
    return height * _scaleHeight;
  }

  // Adapta un valor de radio según la escala (útil para bordes y bordes redondeados)
  static double radius(double r) {
    return r * _scaleText;
  }

  // Adapta un valor de texto según la escala
  static double sp(double fontSize) {
    return fontSize * _scaleText;
  }

  // Obtiene el factor de escala actual (útil para widgets personalizados)
  static double get textScaleFactor => _scaleText;
}

// Extensiones útiles para usar nuestro adaptador con sintaxis más limpia
extension SizeExtension on num {
  // Para adaptación de ancho: 20.w
  double get w => SizeAdapter.width(toDouble());

  // Para adaptación de alto: 20.h
  double get h => SizeAdapter.height(toDouble());

  // Para adaptación de radio: 20.r
  double get r => SizeAdapter.radius(toDouble());

  // Para adaptación de texto: 20.sp
  double get sp => SizeAdapter.sp(toDouble());
}
