import 'package:flutter/material.dart';

// Mengimpor halaman destinasi alam yang baru
import 'list_alam.dart';
// Mengimpor halaman login
import 'Login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // State untuk melacak item navigasi yang sedang aktif
  String _activePage = 'Beranda';
  // Nama pengguna yang akan ditampilkan
  String _userName = 'atmint gantenk';

  // State untuk melacak item dropdown yang dipilih (opsional, bisa digunakan jika ingin menampilkan pilihan yang sudah dipilih)

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Selamat pagi';
    } else if (hour >= 12 && hour < 15) {
      return 'Selamat siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat sore';
    } else {
      return 'Selamat malam';
    }
  }

  // Fungsi navigasi yang disatukan untuk menu selain "List Destinasi"
  void _navigateToPage(String pageName) {
    setState(() {
      _activePage = pageName;
    });

    // Gunakan switch-case untuk navigasi ke halaman yang berbeda
    switch (pageName) {
      case 'Beranda':
      case 'Data & Informasi':
      case 'Konfigurasi':
        // Jika kembali ke Beranda, pastikan drawer ditutup (jika ada)
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.pop(context);
        }
        break;
      default:
        // Untuk menu lainnya yang belum dibuat halamannya
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.pop(context);
        }
        break;
    }
  }

  // Mengatur navigasi ke halaman login.
  void _handleLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(
        0xFF1A1F36,
      ), // Warna latar belakang yang lebih gelap dengan nuansa biru
      appBar: isMobile ? _buildMobileAppBar(context) : null,
      drawer: isMobile ? _buildMobileDrawer(context) : null,
      body: Column(
        children: [
          // Navigasi horizontal untuk desktop
          if (!isMobile) _buildDesktopNavbar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Portal Destination Dash',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFFE0E0E0,
                      ), // Warna teks terang yang konsisten
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ), // Sedikit ruang antara judul dan pesan
                  Text(
                    '${getGreeting()}, $_userName', // Pesan selamat datang yang dinamis
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFDCDCDC), // Warna teks yang lebih halus
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bagian kartu ringkasan
                  _buildSummaryCards(),
                  const SizedBox(height: 32),
                  // Bagian pembaruan destinasi
                  _buildLatestDestinations(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Membangun bilah navigasi horizontal untuk tampilan desktop.
  Widget _buildDesktopNavbar() {
    return Container(
      color: const Color(0xFF2A2E46), // Warna navbar yang lebih gelap
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.bar_chart,
                color: Color(0xFFFFA500),
                size: 36,
              ), // Warna aksen emas
              SizedBox(width: 8),
              Text(
                'Destination Dash',
                style: TextStyle(
                  color: Color(0xFFE0E0E0), // Warna teks terang yang konsisten
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildNavLink('Beranda', 'Beranda'),
              // MODIFIKASI: Menggunakan PopupMenuButton untuk menggantikan showDialog
              PopupMenuButton<String>(
                onSelected: (String result) {
                  // Tambahkan fungsionalitas navigasi di sini
                  if (result == 'alam') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListDestinasiPage()),
                    );
                  }
                  setState(() {
                    _activePage =
                        'List Destinasi'; // Hapus status aktif dari menu lain
                  });
                },
                offset: const Offset(0, 40), // Posisi dropdown di bawah tombol
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'alam',
                    child: Row(
                      children: const [
                        Icon(Icons.location_on, color: Color(0xFFFFA500)),
                        SizedBox(width: 8),
                        Text(
                          'Destinasi Alam',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'religi',
                    child: Row(
                      children: const [
                        Icon(Icons.mosque, color: Color(0xFFFFA500)),
                        SizedBox(width: 8),
                        Text(
                          'Destinasi Religi',
                          style: TextStyle(color: Color.fromARGB(255, 4, 4, 4)),
                        ),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.transparent, width: 2.0),
                    ),
                  ),
                  child: const Text(
                    'List Destinasi',
                    style: TextStyle(
                      color: Color(0xFFDCDCDC),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              _buildNavLink('Data & Informasi', 'Data & Informasi'),
              _buildNavLink('Konfigurasi', 'Konfigurasi'),
              const SizedBox(width: 24),
              IconButton(
                icon: const Icon(Icons.logout, color: Color(0xFFE0E0E0)),
                onPressed: _handleLogout,
                tooltip: 'Keluar',
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Membangun item tautan navigasi
  Widget _buildNavLink(String title, String page) {
    final isActive = _activePage == page;
    return InkWell(
      onTap: () {
        _navigateToPage(page);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive
                  ? const Color(0xFFFFA500)
                  : Colors.transparent, // Warna aksen emas
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive
                ? const Color(0xFFE0E0E0)
                : const Color(0xFFDCDCDC), // Warna teks yang lebih halus
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Membangun grid kartu ringkasan.
  Widget _buildSummaryCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 1024 ? 3 : 1,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2,
      children: [
        _buildCyberCard(
          title: 'Wisata Populer',
          subtitle: 'Bali',
          description: 'Pantai Kuta, Ubud, Seminyak',
          icon: Icons.map,
        ),
        _buildCyberCard(
          title: 'Wisata Alam Terbaik',
          subtitle: 'Gunung Bromo',
          description: 'Sunrise di Penanjakan',
          icon: Icons.forest,
        ),
        _buildCyberCard(
          title: 'Destinasi Urban Unik',
          subtitle: 'Kota Tua Jakarta',
          description: 'Museum Fatahillah',
          icon: Icons.location_city,
        ),
      ],
    );
  }

  /// Membangun kartu dengan gaya cyber.
  Widget _buildCyberCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2E46), // Warna kartu yang lebih gelap
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4C5170),
        ), // Warna batas yang lebih halus
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFFFA500),
                size: 36,
              ), // Warna aksen emas
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE0E0E0), // Warna teks terang
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE0E0E0), // Warna teks terang
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFDCDCDC),
            ), // Warna teks subtitel yang lebih halus
          ),
        ],
      ),
    );
  }

  /// Membangun bagian daftar destinasi terbaru.
  Widget _buildLatestDestinations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pembaruan Destinasi Terkini',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE0E0E0), // Warna teks terang
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 1024 ? 4 : 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3.5,
          children: [
            _buildDestinationCard(
              'Hutan Pinus Cikole',
              'Lembang, Bandung',
              Icons.forest,
            ),
            _buildDestinationCard(
              'Jembatan Gantung Situ Gunung',
              'Sukabumi',
              Icons.location_on,
            ),
            _buildDestinationCard(
              'Raja Ampat',
              'Papua Barat Daya',
              Icons.beach_access,
            ),
            _buildDestinationCard(
              'Masjid Raya Sheikh Zayed',
              'Solo',
              Icons.mosque,
            ),
          ],
        ),
      ],
    );
  }

  /// Membangun kartu destinasi.
  Widget _buildDestinationCard(String name, String location, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2E46), // Warna kartu yang lebih gelap
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4C5170),
        ), // Warna batas yang lebih halus
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFFA500), // Warna aksen emas
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 36, color: const Color(0xFFE0E0E0)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE0E0E0),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFDCDCDC),
                ), // Warna teks yang lebih halus
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Membangun AppBar untuk tampilan mobile.
  AppBar _buildMobileAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF2A2E46), // Warna AppBar yang lebih gelap
      title: Row(
        children: const [
          Icon(
            Icons.bar_chart,
            color: Color(0xFFFFA500),
            size: 28,
          ), // Warna aksen emas
          SizedBox(width: 8),
          Text(
            'Destination Dash',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFE0E0E0)),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Color(0xFFE0E0E0)),
        ),
        IconButton(
          onPressed: _handleLogout,
          icon: const Icon(Icons.logout, color: Color(0xFFE0E0E0)),
          tooltip: 'Keluar',
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  /// Membangun laci menu untuk tampilan mobile.
  Drawer _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(
        0xFF1A1F36,
      ), // Warna latar belakang yang lebih gelap
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF2A2E46),
            ), // Warna header yang lebih gelap
            child: Text(
              'Menu',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem('Beranda', 'Beranda', Icons.home),
          // Perilaku untuk menu laci dipertahankan menggunakan showDialog,
          // karena ini adalah pola UX yang umum untuk perangkat seluler.
          ListTile(
            title: const Text(
              'List Destinasi',
              style: TextStyle(color: Color(0xFFE0E0E0)),
            ),
            leading: const Icon(Icons.list, color: Color(0xFFDCDCDC)),
            onTap: () {
              Navigator.pop(context);
              _showDestinationOptions();
            },
          ),
          _buildDrawerItem(
            'Data & Informasi',
            'Data & Informasi',
            Icons.analytics,
          ),
          _buildDrawerItem('Konfigurasi', 'Konfigurasi', Icons.settings),
          const Divider(
            color: Color(0xFF4C5170),
          ), // Warna pembatas yang lebih halus
          ListTile(
            title: const Text(
              'Keluar',
              style: TextStyle(color: Color(0xFFDCDCDC)),
            ),
            leading: const Icon(Icons.logout, color: Color(0xFFDCDCDC)),
            onTap: _handleLogout,
          ),
        ],
      ),
    );
  }

  /// Membangun item menu laci.
  Widget _buildDrawerItem(String title, String page, IconData icon) {
    final isActive = _activePage == page;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? const Color(0xFFFFA500) : const Color(0xFFE0E0E0),
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Icon(
        icon,
        color: isActive ? const Color(0xFFFFA500) : const Color(0xFFDCDCDC),
      ),
      onTap: () {
        _navigateToPage(page);
      },
    );
  }

  // Fungsi yang sebelumnya digunakan untuk menampilkan dialog.
  // Sekarang tidak lagi digunakan pada navigasi desktop, namun masih dipertahankan untuk navigasi mobile.
  void _showDestinationOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2E46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Pilih Destinasi',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Destinasi Alam',
                  style: TextStyle(color: Color(0xFFDCDCDC)),
                ),
                leading: const Icon(
                  Icons.location_on,
                  color: Color(0xFFFFA500),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListDestinasiPage()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Destinasi Religi',
                  style: TextStyle(color: Color(0xFFDCDCDC)),
                ),
                leading: const Icon(Icons.mosque, color: Color(0xFFFFA500)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
