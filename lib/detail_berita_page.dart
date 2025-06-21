import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailBeritaPage extends StatelessWidget {
  final String url;
  final String title;

  const DetailBeritaPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFFFFC0CB),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
