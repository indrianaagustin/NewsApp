import 'package:flutter/material.dart';

class KategoriPage extends StatelessWidget {
  final Color pinkSoft = const Color(0xFFFFC0CB);

  // Daftar kategori yang akan ditampilkan
  final List<Map<String, String>> categories = [
    {'name': 'Umum', 'code': 'general'},
    {'name': 'Bisnis', 'code': 'business'},
    {'name': 'Hiburan', 'code': 'entertainment'},
    {'name': 'Kesehatan', 'code': 'health'},
    {'name': 'Sains', 'code': 'science'},
    {'name': 'Olahraga', 'code': 'sports'},
    {'name': 'Teknologi', 'code': 'technology'},
  ];

  final void Function(String categoryCode, String categoryName) onCategoryTap;

  KategoriPage({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: pinkSoft,
          padding: const EdgeInsets.fromLTRB(16, 16 + 24, 16, 12),
          child: const Text(
            'Kategori',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3, // agak memanjang ke kanan
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    onCategoryTap(category['code']!, category['name']!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: pinkSoft,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
