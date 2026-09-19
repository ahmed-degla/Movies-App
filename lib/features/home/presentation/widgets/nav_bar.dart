import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/enum/home_taps.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: BlocSelector<HomeCubit, HomeStates, int>(
      selector: (HomeStates state) => state.selectedTapIndex,
      builder: (context, state) => Container(
        height: context.h(64),
        margin: EdgeInsets.symmetric(horizontal: context.w(8)),
        decoration: BoxDecoration(
          color: appColors.fill,
          borderRadius: BorderRadius.circular(context.r(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: HomeTaps.values.map((e) {
            final index = HomeTaps.values.indexOf(e);
            final isSelected = index == state;

            return Expanded(
              child: InkWell(
                onTap: () {
                  context.read<HomeCubit>().changeNavIndex(index);
                },
                borderRadius: BorderRadius.circular(context.r(16)),
                child: Center(
                  child: SvgPicture.asset(
                    e.icon,
                    height: context.h(24),
                    width: context.w(24),
                    colorFilter: ColorFilter.mode(
                      isSelected ? appColors.primary : appColors.primaryText,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
