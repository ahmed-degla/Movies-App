import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/enum/profile_avatar.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/widgets/app_text.dart';

class SignUpAvatarPicker extends StatelessWidget {
  const SignUpAvatarPicker({required this.onAvatarSelected, super.key});

  final ValueChanged<int> onAvatarSelected;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CarouselSlider.builder(
        options: CarouselOptions(
          height: 160.h,
          enlargeCenterPage: true,
          enlargeFactor: 0.5,
          viewportFraction: 0.3,
          onPageChanged: (index, _) => onAvatarSelected(index),
        ),
        itemCount: Avatar.values.length,
        itemBuilder: (context, index, realIndex) =>
            Avatar.values[index].avatar.image(width: 160.w, height: 160.h),
      ),
      AppText(text: tr.avatar, fontSize: 16.sp),
    ],
  );
}
