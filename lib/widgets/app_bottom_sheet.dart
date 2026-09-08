import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';

class AppBottomSheet {
  const AppBottomSheet._();

  static Future<T?> show<T>({
    required WidgetBuilder builder,
    BuildContext? context,

    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,

    Color? barrierColor,
    String? barrierLabel,

    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    bool requestFocus = true,

    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
  }) => showModalBottomSheet<T>(
    context: context ?? AppUtils.context,

    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: elevation ?? 14,
    shape: shape,
    clipBehavior: clipBehavior,
    constraints:
        constraints ??
        BoxConstraints(
          maxHeight:
              MediaQuery.of(context ?? AppUtils.context).size.height * .85,
        ),

    barrierColor: barrierColor ?? Colors.black45,
    barrierLabel: barrierLabel,

    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    showDragHandle: showDragHandle,
    useSafeArea: useSafeArea,
    requestFocus: requestFocus,

    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    anchorPoint: anchorPoint,
    sheetAnimationStyle:
        sheetAnimationStyle ??
        const AnimationStyle(
          duration: Duration(milliseconds: 350),
          reverseDuration: Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        ),

    builder: (sheetContext) => _KeyboardAware(child: builder(sheetContext)),
  );
}

class _KeyboardAware extends StatelessWidget {
  const _KeyboardAware({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: bottomInset),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.r(16)),
          ),
          color: appColors.background,
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
