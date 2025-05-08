import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart'; // Importando iconos de Cupertino
import 'report_screen.dart';
import 'map_screen.dart';
import 'stats_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Lista de problemas de infraestructura comunes con iconos de Cupertino
  final List<Map<String, dynamic>> _problemCategories = [
    {
      'icon': CupertinoIcons.drop_fill,
      'title': 'Acueducto',
      'color': Colors.blue,
    },
    {
      'icon': CupertinoIcons.lightbulb_fill,
      'title': 'Alumbrado',
      'color': Colors.amber,
    },
    {
      'icon': CupertinoIcons.hammer_fill,
      'title': 'Vías',
      'color': Colors.grey,
    },
    {
      'icon': CupertinoIcons.trash_fill,
      'title': 'Basuras',
      'color': Colors.green,
    },
    {
      'icon': CupertinoIcons.tree,
      'title': 'Parques',
      'color': Colors.lightGreen,
    },
    {
      'icon': CupertinoIcons.ellipsis_circle_fill,
      'title': 'Otros',
      'color': Colors.purple,
    },
  ];

  // Lista simulada de reportes recientes
  final List<Map<String, dynamic>> _recentReports = [
    {
      'title': 'Hueco en calle 20',
      'description': 'Hueco de gran tamaño que dificulta el tránsito',
      'date': '25 Abr, 2025',
      'status': 'Pendiente',
      'category': 'Vías',
      'icon': CupertinoIcons.hammer_fill,
      'color': Colors.grey,
    },
    {
      'title': 'Falta de agua en sector norte',
      'description': 'Sin servicio de agua por 3 días',
      'date': '24 Abr, 2025',
      'status': 'En revisión',
      'category': 'Acueducto',
      'icon': CupertinoIcons.drop_fill,
      'color': Colors.blue,
    },
    {
      'title': 'Falla en alumbrado público',
      'description': 'Sector a oscuras en la calle 15 con carrera 20',
      'date': '23 Abr, 2025',
      'status': 'Solucionado',
      'category': 'Alumbrado',
      'icon': CupertinoIcons.lightbulb_fill,
      'color': Colors.amber,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos las dimensiones de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 35,
              // Nota: Necesitarás crear este archivo de imagen
              // Usa un placeholder mientras tanto
            ),
            const SizedBox(width: 8),
            const Text(
              'Infrasol',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.bell, color: Colors.blue),
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6 : 8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 11,
              backgroundImage: AssetImage(
                'assets/avatar.png',
              ),
              // Necesitarás crear este archivo o usar un ícono
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6 : 8),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildHomeContent(context)
          : _buildPlaceholderContent(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportScreen()),
          );
        },
        backgroundColor: Colors.blue,
        icon: const Icon(
          CupertinoIcons.add_circled,
          color: Colors.white,
        ),
        label: Text(
          'Nuevo Reporte',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: isSmallScreen ? 12 : 14,
              color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: isSmallScreen ? 10 : 12,
        unselectedFontSize: isSmallScreen ? 9 : 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map),
            activeIcon: Icon(CupertinoIcons.map_fill),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            activeIcon: Icon(CupertinoIcons.chart_bar_fill),
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    // Obtenemos las dimensiones de pantalla para adaptar el contenido
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final bool isSmallScreen = screenWidth < 360;
    final bool isMediumScreen = screenWidth >= 360 && screenWidth < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner superior adaptativo
          IntrinsicHeight(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.2,
                      child: Icon(
                        CupertinoIcons.building_2_fill,
                        size: isSmallScreen ? 80 : 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize
                          .min, // Importante para que no crezca más de lo necesario
                      children: [
                        Text(
                          '¡Mejoremos Sincelejo juntos!',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Reporta problemas de infraestructura y servicios públicos para una ciudad más eficiente.',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 13,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReportScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 8 : 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(CupertinoIcons.exclamationmark_circle,
                                  size: 16),
                              SizedBox(width: isSmallScreen ? 6 : 8),
                              Text(
                                'Reportar un problema',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: isSmallScreen ? 20 : 25),

          // Categorías de problemas
          Row(
            children: [
              Icon(CupertinoIcons.square_grid_2x2_fill,
                  size: isSmallScreen ? 18 : 18, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Categorías',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          LayoutBuilder(builder: (context, constraints) {
            // Ajustar columnas basado en el ancho disponible
            final double availableWidth = constraints.maxWidth;
            final int columns = availableWidth < 300
                ? 2
                : (availableWidth < 500 ? 3 : (availableWidth < 700 ? 4 : 5));

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: isSmallScreen ? 0.9 : 1,
                crossAxisSpacing: isSmallScreen ? 10 : 12,
                mainAxisSpacing: isSmallScreen ? 10 : 12,
              ),
              itemCount: _problemCategories.length,
              itemBuilder: (context, index) {
                final category = _problemCategories[index];
                return _buildCategoryCard(
                  icon: category['icon'],
                  title: category['title'],
                  color: category['color'],
                );
              },
            );
          }),

          SizedBox(height: isSmallScreen ? 24 : 28),

          // Mapa de reportes
          Row(
            children: [
              Icon(CupertinoIcons.map_pin_ellipse,
                  size: isSmallScreen ? 18 : 20, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Mapa de reportes',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          Container(
            height: isSmallScreen ? 160 : (isMediumScreen ? 180 : 220),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
              image: const DecorationImage(
                image: AssetImage('assets/map_preview.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  );
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 8 : 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.map_fill,
                            color: Colors.blue, size: isSmallScreen ? 16 : 18),
                        SizedBox(width: isSmallScreen ? 6 : 8),
                        Text(
                          'Ver mapa completo',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: isSmallScreen ? 24 : 28),

          // Reportes recientes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.time,
                      size: isSmallScreen ? 18 : 20, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Reportes recientes',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatsScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 12,
                    vertical: isSmallScreen ? 4 : 8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ver todos',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    Icon(CupertinoIcons.chevron_right,
                        size: isSmallScreen ? 14 : 16, color: Colors.blue)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),

          // Tarjetas de reportes
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentReports.length,
            itemBuilder: (context, index) {
              final report = _recentReports[index];
              return _buildReportCard(
                title: report['title'],
                description: report['description'],
                date: report['date'],
                status: report['status'],
                category: report['category'],
                icon: report['icon'],
                color: report['color'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    // Calculamos colores derivados para efectos visuales
    final Color surfaceColor = color.withOpacity(0.1);
    final Color highlightColor = Color.lerp(color, Colors.white, 0.3)!;
    final Color shadowColor = color.withOpacity(0.4);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determinamos si la pantalla es pequeña basándonos en el ancho
        bool isSmallScreen = constraints.maxWidth < 360;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuint,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: color.withOpacity(0.15), width: 1.5),
            ),
            shadowColor: shadowColor,
            surfaceTintColor: surfaceColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  splashColor: color.withOpacity(0.15),
                  highlightColor: color.withOpacity(0.05),
                  onTap: () {
                    // Añadimos un efecto de escala al tocar
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ReportScreen(initialCategory: title),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Contenedor para el ícono con efecto de gradiente mejorado
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                color.withOpacity(0.7),
                                color,
                                highlightColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.0, 0.6, 1.0],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: highlightColor.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(-2, -2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: isSmallScreen ? 16 : 24,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 10 : 14),
                        // Título con estilo mejorado
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: isSmallScreen ? 12 : 14,
                              color: Colors.black87,
                              letterSpacing: 0.2,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 0.5,
                                  offset: const Offset(0, 0.5),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow
                                .ellipsis, // Asegura que el texto se trunque con puntos suspensivos si no cabe
                            maxLines: 1, // Limita el texto a una sola línea
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportCard({
    required String title,
    required String description,
    required String date,
    required String status,
    required String category,
    required IconData icon,
    required Color color,
  }) {
    // Colores para el degradado y sombras (similar a _buildCategoryCard)
    final Color surfaceColor = color.withOpacity(0.1);
    final Color highlightColor = Color.lerp(color, Colors.white, 0.3)!;
    final Color shadowColor = color.withOpacity(0.4);

    // Colores y ícono según el estado
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Pendiente':
        statusColor = Colors.orange;
        statusIcon = CupertinoIcons.clock_fill;
        break;
      case 'En revisión':
        statusColor = Colors.blue;
        statusIcon = CupertinoIcons.arrow_clockwise;
        break;
      case 'Solucionado':
        statusColor = Colors.green;
        statusIcon = CupertinoIcons.checkmark_circle_fill;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = CupertinoIcons.question_circle_fill;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determinamos si la pantalla es pequeña basándonos en el ancho
        bool isSmallScreen = constraints.maxWidth < 360;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuint,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: color.withOpacity(0.15), width: 1.5),
            ),
            shadowColor: shadowColor,
            surfaceTintColor: surfaceColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    // Aquí podrías añadir la navegación al detalle del reporte
                  },
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 14 : 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contenedor del ícono con degradado y sombras
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                color.withOpacity(0.7),
                                color,
                                highlightColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.0, 0.6, 1.0],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: highlightColor.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(-2, -2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: isSmallScreen ? 16 : 24,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 12 : 14),
                        // Contenido del reporte
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título con FittedBox para adaptarse
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 14 : 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(height: isSmallScreen ? 4 : 6),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 13,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: isSmallScreen ? 8 : 10),
                              // Footer con fecha y estado
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.calendar,
                                        size: isSmallScreen ? 12 : 14,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        date,
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 11 : 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 8 : 10,
                                      vertical: isSmallScreen ? 4 : 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          statusIcon,
                                          size: isSmallScreen ? 10 : 12,
                                          color: statusColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          status,
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 10 : 11,
                                            fontWeight: FontWeight.w600,
                                            color: statusColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderContent() {
    // Esta es una pantalla temporal para las otras pestañas
    Widget content;
    String message;

    switch (_selectedIndex) {
      case 1:
        content =
            const Icon(CupertinoIcons.map_fill, size: 100, color: Colors.blue);
        message = 'Mapa de reportes';
        break;
      case 2:
        content = const Icon(CupertinoIcons.chart_bar_fill,
            size: 100, color: Colors.blue);
        message = 'Estadísticas de reportes';
        break;
      case 3:
        content = const Icon(CupertinoIcons.person_fill,
            size: 100, color: Colors.blue);
        message = 'Perfil de usuario';
        break;
      default:
        content = const Icon(CupertinoIcons.house_fill,
            size: 100, color: Colors.blue);
        message = 'Página principal';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          content,
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Esta sección está en desarrollo'),
        ],
      ),
    );
  }
}
