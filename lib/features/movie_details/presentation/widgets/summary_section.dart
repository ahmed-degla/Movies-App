import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/widgets/app_text.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({required this.summary, super.key});

  final String summary;

  @override
  Widget build(BuildContext context) {
    if (summary.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Summary',
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(10)),
          AppText(
            text: summary,
            fontSize: context.sp(14),
            color: Colors.white70,
            height: 1.5,
          ),
        ],
      ),
    );
  }
}
