import '../models/destination.dart';

class DummyData {
  static const List<Destination> destinations = [
    Destination(
      id: 'd1',
      name: 'Wae Rebo',
      location: 'Manggarai, Nusa Tenggara Timur',
      image: 'lib/assets/images/destinations/wae_rebo.jpg',
      category: 'Budaya',
      description:
          'Desa adat terpencil di Kabupaten Manggarai, terletak di ketinggian 1.200 meter di atas permukaan laut. Terkenal dengan rumah adat Mbaru Niang yang unik berkerecut melingkar.',
      rating: 4.9,
      price: 'Rp1.500.000',
      reviewsCount: 320,
      highlights: [
        'Rumah Adat Mbaru Niang',
        'Tradisi Minum Kopi Asli',
        'Pemandangan Pegunungan Asri',
      ],
      facilities: ['Homestay Adat', 'Guide Lokal', 'Makan Tradisional', 'Upacara Sambutan'],
      packageOptions: ['Homestay & Guide Lokal', 'Pengalaman Budaya', 'Paket Trekking'],
    ),
    Destination(
      id: 'd2',
      name: 'Raja Ampat',
      location: 'Papua Barat Daya',
      image: 'lib/assets/images/destinations/raja_ampat.jpg',
      category: 'Alam',
      description:
          'Surga bawah laut kelas dunia dengan gugusan pulau karang ikonik, keanekaragaman hayati laut tertinggi, dan pantai pasir putih yang murni.',
      rating: 5.0,
      price: 'Rp4.500.000',
      reviewsCount: 512,
      highlights: [
        'Wayag & Pianemo Peak',
        'Diving Bawah Laut',
        'Keanekaragaman Terumbu Karang',
      ],
      facilities: ['Resort Terapung', 'Perahu Speedboat', 'Alat Snorkeling', 'Instruktur Diving'],
      packageOptions: ['Island Hopping', 'Snorkeling & Diving', 'Eksplor Puncak Wayag'],
    ),
    Destination(
      id: 'd3',
      name: 'Gunung Bromo',
      location: 'Pasuruan, Jawa Timur',
      image: 'lib/assets/images/destinations/bromo.jpg',
      category: 'Alam',
      description:
          'Gunung berapi aktif legendaris yang menawarkan pemandangan matahari terbit spektakuler di atas lautan pasir dan kawah bromo yang magis.',
      rating: 4.8,
      price: 'Rp750.000',
      reviewsCount: 840,
      highlights: [
        'Sunrise Penanjakan 1',
        'Kawah Bromo Active',
        'Lautan Pasir Berbisik',
      ],
      facilities: ['Jeep 4x4', 'Sewa Kuda', 'Penginapan Bromo', 'Masker & Sarung Tangan'],
      packageOptions: ['Midnight Sunrise Tour', 'Jeep Lautan Pasir', 'Trekking Kawah'],
    ),
    Destination(
      id: 'd4',
      name: 'Candi Borobudur',
      location: 'Magelang, Jawa Tengah',
      image: 'lib/assets/images/destinations/borobudur.jpg',
      category: 'Sejarah',
      description:
          'Candi Buddha terbesar di dunia abad ke-9, keajaiban arsitektur megah berhias 2.672 panel relief dan 504 patung Buddha.',
      rating: 4.9,
      price: 'Rp500.000',
      reviewsCount: 1250,
      highlights: [
        'Relief Relief Bersejarah',
        'Sunrise Borobudur',
        'Stupa Utama Megah',
      ],
      facilities: ['Pemandu Wisata Sejarah', 'Sepeda Keliling Desa', 'Batik Workshop', 'Restoran Lokal'],
      packageOptions: ['Tur Candi Berpandu', 'Borobudur Sunrise', 'Keliling Desa Balkondes'],
    ),
    Destination(
      id: 'd5',
      name: 'Labuan Bajo',
      location: 'Nusa Tenggara Timur',
      image: 'lib/assets/images/destinations/labuan_bajo.jpg',
      category: 'Alam',
      description:
          'Gerbang utama menuju Taman Nasional Komodo, menyajikan pemandangan pulau Padar spektakuler, Pantai Merah (Pink Beach), dan habitat Komodo asli.',
      rating: 4.9,
      price: 'Rp3.200.000',
      reviewsCount: 630,
      highlights: [
        'Pulau Padar Viewpoint',
        'Pink Beach Unique',
        'Taman Nasional Komodo',
      ],
      facilities: ['Kapal Liveaboard', 'Ranger Komodo', 'Makan di Atas Kapal', 'Dokumentasi Drone'],
      packageOptions: ['Sailing Komodo 3D2N', 'One Day Speedboat', 'Sunset Cruise'],
    ),
    Destination(
      id: 'd6',
      name: 'Danau Toba',
      location: 'Sumatera Utara',
      image: 'lib/assets/images/destinations/danau_toba.jpg',
      category: 'Budaya',
      description:
          'Danau vulkanik terbesar di dunia dengan Pulau Samosir di tengahnya, menyimpan kekayaan budaya suku Batak dan pesona alam spektakuler.',
      rating: 4.7,
      price: 'Rp850.000',
      reviewsCount: 410,
      highlights: [
        'Pulau Samosir Center',
        'Desa Adat Tomok',
        'Air Terjun Sipiso-piso',
      ],
      facilities: ['Kapal Feri Samosir', 'Hotel Tepi Danau', 'Pertunjukan Sigale-gale', 'Sewa Motor'],
      packageOptions: ['Samosir Culture Trip', 'Danau Toba Scenic Tour', 'Batak Heritage Package'],
    ),
  ];

  static const List<Map<String, dynamic>> categories = [
    {'name': 'Alam', 'icon': 'nature.png'},
    {'name': 'Budaya', 'icon': 'culture.png'},
    {'name': 'Sejarah', 'icon': 'history.png'},
    {'name': 'Religi', 'icon': 'religion.png'},
  ];

  static const List<Map<String, String>> banners = [
    {
      'title': 'Jelajahi Surga Indonesia',
      'subtitle': 'Diskon 25% untuk Trip Budaya minggu ini!',
      'image': 'lib/assets/images/banners/banner_1.jpg',
    },
    {
      'title': 'Eksplor Wae Rebo & Bromo',
      'subtitle': 'Pengalaman autentik bersama NusaTrip',
      'image': 'lib/assets/images/banners/banner_2.jpg',
    },
  ];
}
