import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_text.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,

    this.controller,
    this.focusNode,
    this.hintText,
    this.initialValue,

    this.labelText,
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
    this.labelHeight,
    this.labelLetterSpacing,
    this.labelTextAlign,
    this.labelMaxLines,
    this.labelOverflow,
    this.labelOnTap,
    this.labelHoverColor,
    this.labelHoverUnderline = false,

    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,

    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,

    this.fillColor,
    this.cursorColor,

    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,

    this.maxLines = 1,
    this.minLines,
    this.maxLength,

    this.inputFormatters,

    this.textAlign = TextAlign.start,
    this.textStyle,
    this.hintStyle,
    this.errorStyle,

    this.contentPadding,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1,
    this.focusedBorderWidth = 1,

    this.showBorder = true,

    this.showPasswordToggle = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? hintText;
  final String? initialValue;

  final String? labelText;

  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final double? labelHeight;
  final double? labelLetterSpacing;
  final TextAlign? labelTextAlign;
  final int? labelMaxLines;
  final TextOverflow? labelOverflow;

  final VoidCallback? labelOnTap;
  final Color? labelHoverColor;
  final bool labelHoverUnderline;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  final Color? fillColor;
  final Color? cursorColor;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;

  final int maxLines;
  final int? minLines;
  final int? maxLength;

  final List<TextInputFormatter>? inputFormatters;

  final TextAlign textAlign;

  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;

  final EdgeInsetsGeometry? contentPadding;

  final double? borderRadius;

  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;

  final double borderWidth;
  final double focusedBorderWidth;

  final bool showBorder;

  final bool showPasswordToggle;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();

    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.obscureText != widget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = context.w(widget.borderRadius ?? 10);

    final enabledBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: widget.borderColor ?? colors.fill,
              width: widget.borderWidth,
            ),
          )
        : InputBorder.none;
    final disabledBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: widget.borderColor ?? colors.fill.withValues(alpha: .2),
              width: widget.borderWidth,
            ),
          )
        : InputBorder.none;

    final focusedBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color:
                  widget.focusedBorderColor ??
                  colors.primary.withValues(alpha: .2),
              width: widget.focusedBorderWidth,
            ),
          )
        : InputBorder.none;

    final errorBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? colors.secondary,
              width: widget.borderWidth,
            ),
          )
        : InputBorder.none;

    final textStyle = TextStyle(
      inherit: widget.textStyle?.inherit ?? true,
      color:
          widget.textStyle?.color ??
          (widget.enabled
              ? colors.primaryText
              : colors.primaryText.withValues(alpha: .5)),
      backgroundColor: widget.textStyle?.backgroundColor,
      fontSize: widget.textStyle?.fontSize ?? context.sp(14),
      fontWeight: widget.textStyle?.fontWeight ?? FontWeight.w500,
      fontStyle: widget.textStyle?.fontStyle,
      letterSpacing: widget.textStyle?.letterSpacing,
      wordSpacing: widget.textStyle?.wordSpacing,
      textBaseline: widget.textStyle?.textBaseline,
      height: widget.textStyle?.height,
      leadingDistribution: widget.textStyle?.leadingDistribution,
      locale: widget.textStyle?.locale,
      foreground: widget.textStyle?.foreground,
      background: widget.textStyle?.background,
      shadows: widget.textStyle?.shadows,
      fontFeatures: widget.textStyle?.fontFeatures,
      fontVariations: widget.textStyle?.fontVariations,
      decoration: widget.textStyle?.decoration,
      decorationColor: widget.textStyle?.decorationColor,
      decorationStyle: widget.textStyle?.decorationStyle,
      decorationThickness: widget.textStyle?.decorationThickness,
      debugLabel: widget.textStyle?.debugLabel,
      fontFamily: widget.textStyle?.fontFamily,
      fontFamilyFallback: widget.textStyle?.fontFamilyFallback,
    );
    final hintStyle = TextStyle(
      inherit: widget.hintStyle?.inherit ?? true,
      color:
          widget.hintStyle?.color ?? colors.primaryText.withValues(alpha: .5),
      backgroundColor: widget.hintStyle?.backgroundColor,
      fontSize: widget.hintStyle?.fontSize ?? context.sp(14),
      fontWeight: widget.hintStyle?.fontWeight ?? FontWeight.w400,
      fontStyle: widget.hintStyle?.fontStyle,
      letterSpacing: widget.hintStyle?.letterSpacing,
      wordSpacing: widget.hintStyle?.wordSpacing,
      textBaseline: widget.hintStyle?.textBaseline,
      height: widget.hintStyle?.height,
      leadingDistribution: widget.hintStyle?.leadingDistribution,
      locale: widget.hintStyle?.locale,
      foreground: widget.hintStyle?.foreground,
      background: widget.hintStyle?.background,
      shadows: widget.hintStyle?.shadows,
      fontFeatures: widget.hintStyle?.fontFeatures,
      fontVariations: widget.hintStyle?.fontVariations,
      decoration: widget.hintStyle?.decoration,
      decorationColor: widget.hintStyle?.decorationColor,
      decorationStyle: widget.hintStyle?.decorationStyle,
      decorationThickness: widget.hintStyle?.decorationThickness,
      debugLabel: widget.hintStyle?.debugLabel,
      fontFamily: widget.hintStyle?.fontFamily,
      fontFamilyFallback: widget.hintStyle?.fontFamilyFallback,
    );

    final field = TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorHeight: context.h(18),

      initialValue: widget.controller == null ? widget.initialValue : null,

      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,

      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,

      obscureText: _isObscured,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,

      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,

      inputFormatters: widget.inputFormatters,

      textAlign: widget.textAlign,
      style: textStyle,

      cursorColor: widget.cursorColor ?? colors.primary,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: hintStyle,
        errorStyle: widget.errorStyle,

        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,

        suffix: widget.suffix,

        suffixIcon: widget.obscureText && widget.showPasswordToggle
            ? InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: colors.primaryText.withValues(alpha: .8),
                  size: context.w(24),
                ),
              )
            : widget.suffixIcon,

        filled: true,
        fillColor:
            widget.fillColor ??
            (widget.enabled ? colors.fill : colors.fill.withValues(alpha: .2)),

        contentPadding:
            widget.contentPadding ??
            context.edgeInsets(horizontal: 16, vertical: 4),

        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        border: enabledBorder,
        disabledBorder: disabledBorder,
      ),
    );

    if (widget.labelText == null || widget.labelText!.isEmpty) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: widget.labelText!,
          color: widget.labelColor ?? colors.primaryText.withValues(alpha: .8),
          fontSize: widget.labelFontSize,
          fontWeight: widget.labelFontWeight ?? .w500,
          height: widget.labelHeight,
          letterSpacing: widget.labelLetterSpacing,
          textAlign: widget.labelTextAlign,
          maxLines: widget.labelMaxLines,
          overflow: widget.labelOverflow,
          hoverColor: widget.labelHoverColor,
          hoverUnderline: widget.labelHoverUnderline,
          onTap: widget.labelOnTap,
        ),

        SizedBox(height: context.h(8)),

        field,
      ],
    );
  }
}
