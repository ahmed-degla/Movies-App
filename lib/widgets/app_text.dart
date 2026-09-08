import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:movies/core/theme/theme_extension.dart';

class AppText extends StatefulWidget {
  const AppText({
    required this.text,
    super.key,

    this.color,
    this.gradient,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.height,
    this.letterSpacing,
    this.textAlign,
    this.textDecoration,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.semanticsLabel,

    this.onTap,
    this.onLongPress,

    this.hoverColor,
    this.hoverGradient,
    this.hoverUnderline = false,

    this.selectable = false,
    this.padding,
  });

  final String text;


  final Color? color;
  final Gradient? gradient;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;

  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDecoration? textDecoration;

  final TextDirection? textDirection;
  final Locale? locale;
  final String? semanticsLabel;


  final VoidCallback? onTap;
  final VoidCallback? onLongPress;


  final Color? hoverColor;
  final Gradient? hoverGradient;
  final bool hoverUnderline;


  final bool selectable;

  final EdgeInsetsGeometry? padding;

  bool get _hasInteraction => onTap != null || onLongPress != null;

  bool get _hasHover =>
      kIsWeb &&
          onTap != null &&
          (hoverColor != null || hoverGradient != null || hoverUnderline);

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  bool _isHovered = false;

  void _onEnter(PointerEnterEvent event) {
    if (_isHovered) return;

    setState(() {
      _isHovered = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    if (!_isHovered) return;

    setState(() {
      _isHovered = false;
    });
  }

  TextStyle _textStyle(BuildContext context) {
    final defaultColor = colors.primaryText;

    return TextStyle(
      color: _isHovered
          ? widget.hoverColor ?? widget.color ?? defaultColor
          : widget.color ?? defaultColor,
      fontSize: widget.fontSize ?? context.sp(14),
      fontWeight: widget.fontWeight,
      height: widget.height,
      letterSpacing: widget.letterSpacing,
      decoration: _isHovered && widget.hoverUnderline
          ? TextDecoration.underline
          : widget.textDecoration,
    );
  }

  Widget _buildText(BuildContext context) {
    final textStyle = _textStyle(context);

    final Widget text;

    if (widget.selectable) {
      text = SelectableText(
        widget.text,
        style: textStyle,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        textDirection: widget.textDirection,
        semanticsLabel: widget.semanticsLabel,
      );
    } else {
      text = Text(
        widget.text,
        style: textStyle,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        softWrap: widget.softWrap,
        textDirection: widget.textDirection,
        locale: widget.locale,
        semanticsLabel: widget.semanticsLabel,
      );
    }

    final currentGradient = _isHovered
        ? widget.hoverGradient ?? widget.gradient
        : widget.gradient;

    if (currentGradient == null) {
      return text;
    }

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => currentGradient.createShader(
        Rect.fromLTWH(
          0,
          0,
          bounds.width,
          bounds.height,
        ),
      ),
      child: text,
    );
  }

  Widget _buildContent(BuildContext context) {
    final Widget text = _buildText(context);

    if (widget.padding == null) {
      return text;
    }

    return Padding(
      padding: widget.padding!,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {

    if (!widget._hasInteraction) {
      return _buildContent(context);
    }


    final Widget child = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: _buildContent(context),
    );


    if (!widget._hasHover) {
      return child;
    }


    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: child,
    );
  }
}