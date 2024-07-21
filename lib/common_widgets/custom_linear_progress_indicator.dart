import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 2.h, child: const LinearProgressIndicator());
  }
}