import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // Lista de problemas de infraestructura comunes
  final List<Map<String, dynamic>> _problemCategories = [
    {
      'icon': Icons.water_damage,
      'title': 'Acueducto',
      'color': Colors.blue,
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Alumbrado',
      'color': Colors.amber,
    },
    {
      'icon': Icons.build_circle_outlined,
      'title': 'Vías',
      'color': Colors.grey,
    },
    {
      'icon': Icons.delete_outline,
      'title': 'Basuras',
      'color': Colors.green,
    },
    {
      'icon': Icons.park_outlined,
      'title': 'Parques',
      'color': Colors.lightGreen,
    },
    {
      'icon': Icons.more_horiz,
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
    },
    {
      'title': 'Falta de agua en sector norte',
      'description': 'Sin servicio de agua por 3 días',
      'date': '24 Abr, 2025',
      'status': 'En revisión',
      'category': 'Acueducto',
    },
    {
      'title': 'Falla en alumbrado público',
      'description': 'Sector a oscuras en la calle 15 con carrera 20',
      'date': '23 Abr, 2025',
      'status': 'Solucionado',
      'category': 'Alumbrado',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
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
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.blue),
            onPressed: () {},
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
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildHomeContent()
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
          Icons.add_circle_outline,
          color: Colors.white,
        ),
        label: const Text(
          'Nuevo Reporte',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner superior
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Opacity(
                    opacity: 0.2,
                    child: Icon(
                      Icons.location_city,
                      size: 120,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '¡Mejoremos Sincelejo juntos!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Reporta problemas de infraestructura y servicios públicos para una ciudad más eficiente.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                        ),
                        child: const Text('Reportar un problema'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Categorías de problemas
          const Text(
            'Categorías',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
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
          ),

          const SizedBox(height: 24),

          // Mapa de reportes
          const Text(
            'Mapa de reportes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
              image: const DecorationImage(
                image: AssetImage('assets/map_preview.png'),
                // Necesitarás crear este archivo o usar un color de fondo
                fit: BoxFit.cover,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  );
                },
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.map, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Ver mapa completo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Reportes recientes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reportes recientes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatsScreen()),
                  );
                },
                child: const Text('Ver todos'),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportScreen(initialCategory: title),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String description,
    required String date,
    required String status,
    required String category,
  }) {
    Color statusColor;
    switch (status) {
      case 'Pendiente':
        statusColor = Colors.orange;
        break;
      case 'En revisión':
        statusColor = Colors.blue;
        break;
      case 'Solucionado':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.category,
                  size: 12,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // Navegar a la pantalla de detalles del reporte
        },
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    // Esta es una pantalla temporal para las otras pestañas
    // Deberás implementar las pantallas reales: MapScreen, StatsScreen, ProfileScreen
    Widget content;
    String message;

    switch (_selectedIndex) {
      case 1:
        content = const Icon(Icons.map, size: 100, color: Colors.blue);
        message = 'Mapa de reportes';
        break;
      case 2:
        content = const Icon(Icons.bar_chart, size: 100, color: Colors.blue);
        message = 'Estadísticas de reportes';
        break;
      case 3:
        content = const Icon(Icons.person, size: 100, color: Colors.blue);
        message = 'Perfil de usuario';
        break;
      default:
        content = const Icon(Icons.home, size: 100, color: Colors.blue);
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
