import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class CustomSwitch extends StatefulWidget {
  final bool initialIsEnglish;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    this.initialIsEnglish = true,
    this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _isEnglish;

  @override
  void initState() {
    super.initState();
    _isEnglish = widget.initialIsEnglish;
  }

  @override
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIsEnglish != widget.initialIsEnglish) {
      _isEnglish = widget.initialIsEnglish;
    }
  }

  void _toggle() {
    final nextIsEnglish = !_isEnglish;
    setState(() {
      _isEnglish = nextIsEnglish;
    });
    GeneralCubit.instance.changeLanguage(nextIsEnglish ? 'en' : 'ar');
    widget.onChanged?.call(nextIsEnglish);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 96.12.w,
        height: 42.06.h,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: appColors.background,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: appColors.primary,
            width: 2.r,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment:
                _isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 38.06.h,
                  height: 38.06.h,
                  decoration: BoxDecoration(
                    color: appColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 38.06.h,
                    height: 38.06.h,
                    child: Center(
                      child: ClipOval(
                        child: Assets.images.svg.enFlag.svg(
                          width: 26.86.w,
                          height: 26.86.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 38.06.h,
                    height: 38.06.h,
                    child: Center(
                      child: ClipOval(
                        child: Assets.images.svg.arFlag.svg(
                          width: 26.86.w,
                          height: 26.86.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}