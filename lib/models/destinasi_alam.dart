import 'package:flutter/material.dart';

/// Kelas data untuk merepresentasikan destinasi wisata.
class Destination {
  final String name;
  final String location;
  final String description;
  final String image; // Properti untuk jalur gambar
  double _rating;
  final String icon;

  // Getter eksplisit untuk _rating
  double get rating => _rating;

  // Setter eksplisit untuk _rating
  set rating(double newRating) {
    if (newRating >= 0.0 && newRating <= 5.0) {
      _rating = newRating;
    } else {
      debugPrint("Rating harus antara 0 dan 5");
    }
  }

  Destination({
    required this.name,
    required this.location,
    required this.description,
    required double rating,
    required this.image, // Parameter baru di konstruktor
    required this.icon,
  }) : _rating = rating;

  @override
  String toString() {
    return 'Destination(name: $name, location: $location, rating: $_rating)';
  }
}

/// Data dummy untuk destinasi wisata.
List<Destination> destinations = [
  Destination(
    name: 'Gunung Bromo',
    location: 'Jawa Timur',
    description: 'Destinasi populer untuk melihat sunrise yang memukau.',
    rating: 4.8,
    image: 'bromo.jpg', // Menggunakan jalur aset lokal
    icon: 'mountain',
  ),
  Destination(
    name: 'Hutan Pinus Cikole',
    location: 'Lembang, Bandung',
    description: 'Tempat ideal untuk bersantai di alam yang sejuk dan asri.',
    rating: 4.5,
    image: 'assets/images/hutan_pinus.jpg', // Menggunakan jalur aset lokal
    icon: 'tree',
  ),
  Destination(
    name: 'Jembatan Gantung Situ Gunung',
    location: 'Sukabumi',
    description:
        'Jembatan gantung terpanjang di Asia Tenggara, cocok untuk uji adrenalin.',
    rating: 4.7,
    image: 'assets/images/jembatan_gantung.jpg', // Menggunakan jalur aset lokal
    icon: 'bridge',
  ),
  Destination(
    name: 'Raja Ampat',
    location: 'Papua Barat Daya',
    description: 'Gugusan pulau dengan keindahan bawah laut yang tiada duanya.',
    rating: 5.0,
    image: 'assets/images/raja_ampat.jpg', // Menggunakan jalur aset lokal
    icon: 'ocean',
  ),
  Destination(
    name: 'Masjid Raya Sheikh Zayed',
    location: 'Solo',
    description:
        'Replika Masjid Sheikh Zayed di Abu Dhabi, menjadi salah satu ikon kota Solo.',
    rating: 4.9,
    image: 'assets/images/masjid_solo.jpg', // Menggunakan jalur aset lokal
    icon: 'mosque',
  ),
  Destination(
    name: 'Taman Nasional Komodo',
    location: 'Nusa Tenggara Timur',
    description:
        'Rumah bagi komodo, kadal terbesar di dunia, dengan pemandangan alam savana yang unik.',
    rating: 4.9,
    image: 'assets/images/komodo.jpg', // Menggunakan jalur aset lokal
    icon: 'lizard',
  ),
  Destination(
    name: 'Candi Borobudur',
    location: 'Magelang, Jawa Tengah',
    description:
        'Candi Buddha terbesar di dunia yang penuh dengan sejarah dan seni.',
    rating: 4.8,
    image: 'assets/images/borobudur.jpg', // Menggunakan jalur aset lokal
    icon: 'temple',
  ),
  Destination(
    name: 'Danau Toba',
    location: 'Sumatera Utara',
    description:
        'Danau vulkanik terbesar di dunia, dengan Pulau Samosir di tengahnya.',
    rating: 4.7,
    image: 'assets/images/danau_toba.jpg', // Menggunakan jalur aset lokal
    icon: 'lake',
  ),
  Destination(
    name: 'Kepulauan Derawan',
    location: 'Kalimantan Timur',
    description:
        'Surga tersembunyi dengan keindahan bawah laut, termasuk ubur-ubur tidak menyengat.',
    rating: 4.8,
    image: 'assets/images/derawan.jpg', // Menggunakan jalur aset lokal
    icon: 'island',
  ),
];

/// Map untuk menghubungkan nama ikon dengan ikon material yang sesuai.
final Map<String, IconData> iconMap = {
  'mountain': Icons.terrain,
  'tree': Icons.forest,
  'bridge': Icons.architecture,
  'ocean': Icons.waves,
  'mosque': Icons.mosque,
  'lizard': Icons.bug_report,
  'temple': Icons.account_balance,
  'lake': Icons.opacity,
  'island': Icons.beach_access,
};

/// Enum untuk kriteria pengurutan.
enum SortCriteria { none, nameAsc, nameDesc, ratingDesc, ratingAsc }
