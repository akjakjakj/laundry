import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart'; // For loading asset files
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'dart:io';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.r),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                        color: Color.fromARGB(255, 224, 224, 224),
                        spreadRadius: 0.5)
                  ],
                ),
                child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18.r,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
        title: Text(
          'Privacy Policy',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: assetPDFPath.isNotEmpty
          ? PDFView(
              filePath: assetPDFPath,
            )
          : const CustomLinearProgress(), // Show a loader until PDF is loaded
    );
  }
}
