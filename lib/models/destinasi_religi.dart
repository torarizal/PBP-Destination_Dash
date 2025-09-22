import 'package:flutter/material.dart';

/// Kelas data untuk merepresentasikan destinasi wisata.
class Destination {
  final String name;
  final String location;
  final String description;
  final double rating;
  final String icon;

  Destination({
    required this.name,
    required this.location,
    required this.description,
    required this.rating,
    required this.icon,
  });
}

/// Data dummy untuk destinasi wisata.
List<Destination> destinations = [
    Destination(
    name: 'Masjid Raya Sheikh Zayed',
    location: 'Solo',
    description:
        'Replika Masjid Sheikh Zayed di Abu Dhabi, menjadi salah satu ikon kota Solo.',
    rating: 4.9,
    icon: 'mosque',
  ),
];
final Map<String, IconData> iconMap = {
  'mosque': Icons.mosque,
};

enum SortCriteria { none, nameAsc, nameDesc, ratingDesc, ratingAsc }
