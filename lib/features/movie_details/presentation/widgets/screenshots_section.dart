import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class ScreenshotsSection extends StatelessWidget {
  const ScreenshotsSection({required this.screenshots, super.key});

  final List<String> screenshots;

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Screen Shots',
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: screenshots.length,
            separatorBuilder: (_, _) => SizedBox(height: context.h(12)),
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(context.r(16)),
              child: SizedBox(
                width: double.infinity,
                height: context.h(170),
                child: AppNetWorkImage(
                  imageUrl: screenshots[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
