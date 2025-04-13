import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart'; // For loading asset files
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:laundry/utils/font_palette.dart'; // For handling file

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String assetPDFPath = "";

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    final file = await loadAssetPDF();
    if (file != null) {
      setState(() {
        assetPDFPath = file.path;
      });
    }
  }

  Future<File?> loadAssetPDF() async {
    try {
      var data = await rootBundle
          .load(Assets.pdf.privacyPolicy1); // Load the PDF from assets
      var bytes = data.buffer.asUint8List();
      var dir = await Directory.systemTemp.createTemp();
      File tempFile = File('${dir.path}/sample.pdf');
      return await tempFile.writeAsBytes(bytes,
          flush: true); // Write bytes to a temporary file
    } catch (e) {
      debugPrint("Error loading PDF: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://ledegraissage.com/privacy-policy/'));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: FontPalette.poppinsBold
              .copyWith(fontSize: 17.sp, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
