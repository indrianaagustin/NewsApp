import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // warna background lembut
      appBar: AppBar(
        title: const Text(
          'Berita Terkini',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNewsCard(
            title: 'Flutter 3.22 Resmi Dirilis!',
            summary: 'Versi terbaru Flutter hadir dengan banyak fitur menarik untuk pengembangan multiplatform.',
          ),
          const SizedBox(height: 12),
          _buildNewsCard(
            title: 'AI Semakin Canggih di 2025',
            summary: 'Penggunaan kecerdasan buatan meningkat drastis dalam bidang pendidikan dan kesehatan.',
          ),
          const SizedBox(height: 12),
          _buildNewsCard(
            title: 'Indonesia Tuan Rumah SEA Games 2025',
            summary: 'Persiapan besar-besaran dilakukan di berbagai kota sebagai tuan rumah event olahraga Asia Tenggara.',
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard({required String title, required String summary}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            Text(summary,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}