import 'package:flutter/material.dart';

class FavoritPage extends StatelessWidget {
  final Color pinkSoft = const Color(0xFFFFC0CB);

  const FavoritPage({super.key});

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
            'Favorit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Belum ada berita favorit.',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
