import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, this.initialIsEnglish = true, this.onChanged});

  final bool initialIsEnglish;
  final ValueChanged<bool>? onChanged;

  void _toggle(BuildContext context, bool isEnglish) {
    final nextIsEnglish = !isEnglish;
    unawaited(
      context.read<GeneralCubit>().changeLanguage(nextIsEnglish ? 'en' : 'ar'),
    );
    onChanged?.call(nextIsEnglish);
  }

  @override
  Widget build(BuildContext context) =>
      BlocSelector<GeneralCubit, GeneralState, bool>(
        selector: (state) => state.locale.languageCode == 'en',
        builder: (context, isEnglish) {
          final selectedLanguage = isEnglish ? 'English' : 'Arabic';

          return Semantics(
            button: true,
            label: 'Language switch',
            value: selectedLanguage,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _toggle(context, isEnglish),
                borderRadius: BorderRadius.circular(100.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  width: 96.12.w,
                  height: 42.06.h,
                  padding: EdgeInsets.all(1.5.r),
                  decoration: BoxDecoration(
                    color: appColors.background,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: appColors.primary, width: 2.r),
                    boxShadow: [
                      BoxShadow(
                        color: appColors.primary.withValues(alpha: 0.18),
                        blurRadius: 8.r,
                        offset: Offset(0, 3.h),
                      ),
                    ],
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 450),
                          curve: Curves.easeOutBack,
                          alignment: isEnglish
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: appColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: appColors.primary.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 6.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: context.w(38),
                              height: context.h(38),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _LanguageIcon(
                              asset: Assets.images.svg.enFlag,
                              isSelected: isEnglish,
                            ),
                            _LanguageIcon(
                              asset: Assets.images.svg.arFlag,
                              isSelected: !isEnglish,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class _LanguageIcon extends StatelessWidget {
  const _LanguageIcon({required this.asset, required this.isSelected});

  final SvgGenImage asset;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => AnimatedScale(
    scale: isSelected ? 0.82 : 1,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutBack,
    child: SizedBox(
      width: 38.h,
      height: 38.h,
      child: Center(
        child: ClipOval(
          child: asset.svg(width: 26.w, height: 26.h, fit: BoxFit.cover),
        ),
      ),
    ),
  );
}
