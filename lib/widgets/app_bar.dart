import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/widgets/app_back_button.dart';
import 'package:movies/widgets/app_text.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.bottomBorder = true,
    this.borderColor,
    this.borderWidth = 1,
    this.elevation = 0,
    this.centerTitle,
    this.toolbarHeight,
    this.bottom,
  });

  final String? title;
  final Widget? titleWidget;

  final Widget? leading;
  final List<Widget>? actions;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final bool bottomBorder;
  final Color? borderColor;
  final double borderWidth;

  final double elevation;
  final bool? centerTitle;
  final double? toolbarHeight;

  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) => AppBar(
    title:
        titleWidget ??
        (title != null
            ? AppText(
                text: title!,
                fontSize: context.sp(14),
                fontWeight: FontWeight.w700,
              )
            : null),

    leading:
        leading ??
        (context.router.canPop()
            ? InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: () => context.router.maybePop(),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: context.w(8)),
                  child: const AppBackButton(),
                ),
              )
            : null),

    actions: actions,
    actionsPadding: EdgeInsetsDirectional.only(end: context.w(24)),
    centerTitle: centerTitle ?? true,
    toolbarHeight: toolbarHeight,
    elevation: elevation,
    backgroundColor: backgroundColor ?? Colors.transparent,
    foregroundColor: foregroundColor,
    scrolledUnderElevation: 0,
    bottom: bottom,
  );
}
