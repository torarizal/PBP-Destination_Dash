import 'package:flutter/material.dart';
import 'models/destinasi_alam.dart'; // Memanggil data dari file model.

// Halaman daftar destinasi.
class ListDestinasiPage extends StatelessWidget {
  const ListDestinasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF1A1C2C,
      ), // Ubah warna latar belakang utama
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          64,
          66,
          76,
        ), // Ubah warna latar belakang AppBar
        title: const Text(
          'Daftar Destinasi Wisata',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return Card(
            color: const Color(0xFF2B2F4A), // Ubah warna latar belakang Card
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(color: Color(0xFF4C5170)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Icon(
                iconMap[destination.icon] ?? Icons.place,
                color: const Color(0xFFFFA500),
                size: 40.0,
              ),
              title: Text(
                destination.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Text(
                    destination.location,
                    style: const TextStyle(color: Color(0xFFDCDCDC)),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFA500),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${destination.rating}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailDestinasiPage(destination: destination),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman detail destinasi.
class DetailDestinasiPage extends StatelessWidget {
  final Destination destination;

  const DetailDestinasiPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF1A1C2C,
      ), // Ubah warna latar belakang utama
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF1A1C2C,
        ), // Ubah warna latar belakang AppBar
        title: Text(
          destination.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA500)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  destination.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Gagal memuat gambar',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                destination.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFDCDCDC),
                    size: 20,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    destination.location,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFDCDCDC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFA500), size: 20),
                  const SizedBox(width: 4.0),
                  Text(
                    '${destination.rating}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Divider(color: Color(0xFF4C5170), height: 32.0),
              Text(
                destination.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
