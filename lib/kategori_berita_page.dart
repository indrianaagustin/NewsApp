import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KategoriBeritaPage extends StatefulWidget {
  final String categoryCode;
  final String categoryName;
  final String apiKey;

  const KategoriBeritaPage({
    super.key,
    required this.categoryCode,
    required this.categoryName,
    required this.apiKey,
  });

  @override
  State<KategoriBeritaPage> createState() => _KategoriBeritaPageState();
}

class _KategoriBeritaPageState extends State<KategoriBeritaPage> {
  List<dynamic> _berita = [];
  bool _loading = true;
  String _error = '';

  Future<void> fetchBeritaKategori() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=id&category=${widget.categoryCode}&apiKey=${widget.apiKey}',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
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
    fetchBeritaKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: const Color(0xFFFFC0CB), // pink soft
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : _berita.isEmpty
                  ? const Center(child: Text('Berita tidak ditemukan.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _berita.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final berita = _berita[index];
                        final imageUrl = berita['urlToImage'] ??
                            'https://via.placeholder.com/150';

                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
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
                                    child:
                                        const Icon(Icons.broken_image, size: 40),
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              berita['title'] ?? 'Judul kosong',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(berita['description'] ?? ''),
                          ),
                        );
                      },
                    ),
    );
  }
}
