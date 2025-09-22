import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Statis',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121417),
        // Menggunakan Inter font (jika tersedia), bisa diganti sesuai kebutuhan
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C20),
        elevation: 0,
        title: const Text(
          'Destination Dash',
          style: TextStyle(
            color: Color(0xFFFACC15), // Warna kuning dari desain
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Sapaan
              const Text(
                'Portal Destination Dash',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2F2F2),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Selamat pagi, atmiint gantengk',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 32),

              // Bagian Grid Destinasi Populer
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 800 ? 3 : 1;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1.6,
                    children: const [
                      _DestinationCard(
                        title: 'Wisata Populer',
                        destination: 'Bali',
                        location: 'Pantai Kuta, Ubud, Seminyak',
                        icon: Icons.star,
                      ),
                      _DestinationCard(
                        title: 'Wisata Alam Terbaik',
                        destination: 'Gunung Bromo',
                        location: 'Sunrise di Penanjakan',
                        icon: Icons.terrain,
                      ),
                      _DestinationCard(
                        title: 'Destinasi Urban Unik',
                        destination: 'Kota Tua Jakarta',
                        location: 'Museum Fatahillah',
                        icon: Icons.location_city,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Bagian Grid Pembaruan Destinasi Terkini
              const Text(
                'Pembaruan Destinasi Terkini',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2F2F2),
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: const [
                      _UpdateCard(
                        title: 'Hutan Pinus Cikole',
                        location: 'Lembang, Bandung',
                        icon: Icons.forest,
                      ),
                      _UpdateCard(
                        title: 'Jembatan Gantung Situ Gunung',
                        location: 'Sukabumi',
                        icon: Icons.park,
                      ),
                      _UpdateCard(
                        title: 'Raja Ampat',
                        location: 'Papua Barat Daya',
                        icon: Icons.anchor,
                      ),
                      _UpdateCard(
                        title: 'Masjid Raya Sheikh Zayed',
                        location: 'Solo',
                        icon: Icons.mosque,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String title;
  final String destination;
  final String location;
  final IconData icon;

  const _DestinationCard({
    required this.title,
    required this.destination,
    required this.location,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1C20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF282B30), width: 1),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFACC15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.black, size: 28),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                destination,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  final String title;
  final String location;
  final IconData icon;

  const _UpdateCard({
    required this.title,
    required this.location,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1C20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF282B30), width: 1),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFACC15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.black, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                location,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
