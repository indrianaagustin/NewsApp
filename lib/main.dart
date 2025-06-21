import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'kategori_page.dart';
import 'kategori_berita_page.dart';
import 'favorit_page.dart';
import 'detail_berita_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Indonesia',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final Color pinkSoft = const Color(0xFFFFC0CB);

  List<dynamic> _berita = [];
  bool _loading = true;
  String _error = '';

  static const String apiKey = '5d6eb96ad4794ccbabbe0904a98f2255';

  Future<void> fetchBerita() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=indonesia&language=id&sortBy=publishedAt&apiKey=$apiKey',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          _berita = jsonData['articles'];
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Gagal memuat berita: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Terjadi kesalahan: $e';
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBerita();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToKategoriBerita(BuildContext context, String categoryCode, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KategoriBeritaPage(
          categoryCode: categoryCode,
          categoryName: categoryName,
          apiKey: apiKey,
        ),
      ),
    );
  }

  Widget _buildBeritaList() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error.isNotEmpty) {
      return Center(child: Text(_error));
    }
    if (_berita.isEmpty) {
      return const Center(child: Text('Berita tidak ditemukan.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _berita.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final berita = _berita[index];
        final imageUrl = berita['urlToImage'] ?? 'https://via.placeholder.com/150';

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            onTap: () {
              final url = berita['url'];
              final title = berita['title'] ?? 'Detail Berita';
              if (url != null && url.toString().startsWith('http')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailBeritaPage(url: url, title: title),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link tidak tersedia')),
                );
              }
            },
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 70,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  );
                },
              ),
            ),
            title: Text(
              berita['title'] ?? 'Judul kosong',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(berita['description'] ?? ''),
          ),
        );
      },
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: pinkSoft,
              padding: const EdgeInsets.fromLTRB(16, 16 + 24, 16, 12),
              child: const Text(
                'Berita Terkini',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: _buildBeritaList()),
          ],
        );
      case 1:
        return KategoriPage(
          onCategoryTap: (code, name) {
            _goToKategoriBerita(context, code, name);
          },
        );
      case 2:
        return const FavoritPage();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pinkSoft = const Color(0xFFFFC0CB);
    return Scaffold(
      backgroundColor: pinkSoft,
      extendBodyBehindAppBar: true,
      body: SafeArea(child: _buildPage()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: pinkSoft,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Kategori'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
        ],
      ),
    );
  }
}
