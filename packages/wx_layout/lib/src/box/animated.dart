import 'package:flutter/material.dart';
import 'widget.dart';

class WxAnimatedBox extends ImplicitlyAnimatedWidget {
  const WxAnimatedBox({
    super.key,
    super.duration = const Duration(milliseconds: 200),
    super.curve = Curves.linear,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.alignment,
    this.color,
    this.shadowColor,
    this.elevation,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.borderStyle,
    this.borderSide,
    this.borderRadius,
    this.clipBehavior,
    this.shape,
    this.tooltip,
    required this.child,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? shadowColor;
  final double? elevation;
  final OutlinedBorder? border;
  final Color? borderColor;
  final double? borderWidth;
  final BorderStyle? borderStyle;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final BoxShape? shape;
  final Clip? clipBehavior;
  final String? tooltip;

  @override
  AnimatedBoxState createState() => AnimatedBoxState();
}

class AnimatedBoxState extends AnimatedWidgetBaseState<WxAnimatedBox> {
  BorderSide get borderSide {
    return BorderSide.none
        .copyWith(
          color: widget.borderSide?.color,
          width: widget.borderSide?.width,
          style: widget.borderSide?.style,
        )
        .copyWith(
          color: widget.borderColor,
          width: widget.borderWidth,
          style: widget.borderStyle,
        );
  }

  ShapeBorder get borderShape {
    switch (widget.shape) {
      case BoxShape.circle:
        return CircleBorder(side: borderSide);
      default:
        return RoundedRectangleBorder(
          side: borderSide,
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
        );
    }
  }

  ShapeBorder get border => widget.border ?? borderShape;

  AlignmentGeometryTween? alignmentTween;
  EdgeInsetsGeometryTween? paddingTween;
  EdgeInsetsGeometryTween? marginTween;
  ColorTween? colorTween;
  ColorTween? shadowColorTween;
  Tween<double?>? elevationTween;
  ShapeBorderTween? borderTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    alignmentTween = visitor(
      alignmentTween,
      widget.alignment,
      (dynamic value) => AlignmentGeometryTween(begin: value as AlignmentGeometry?),
    ) as AlignmentGeometryTween?;

    paddingTween = visitor(
      paddingTween,
      widget.padding,
      (dynamic value) => EdgeInsetsGeometryTween(begin: value as EdgeInsetsGeometry?),
    ) as EdgeInsetsGeometryTween?;

    marginTween = visitor(
      marginTween,
      widget.margin,
      (dynamic value) => EdgeInsetsGeometryTween(begin: value as EdgeInsetsGeometry?),
    ) as EdgeInsetsGeometryTween?;

    colorTween = visitor(
      colorTween,
      widget.color,
      (dynamic value) => ColorTween(begin: value as Color?),
    ) as ColorTween?;

    shadowColorTween = visitor(
      shadowColorTween,
      widget.shadowColor,
      (dynamic value) => ColorTween(begin: value as Color?),
    ) as ColorTween?;

    elevationTween = visitor(
      elevationTween,
      widget.elevation ?? 0.0,
      (dynamic value) => Tween<double?>(begin: value as double?),
    ) as Tween<double?>?;

    borderTween = visitor(
      borderTween,
      border,
      (dynamic value) => ShapeBorderTween(begin: value as ShapeBorder?),
    ) as ShapeBorderTween?;
  }

  @override
  Widget build(BuildContext context) {
    return WxBox(
      width: widget.width,
      height: widget.height,
      constraints: widget.constraints,
      alignment: alignmentTween?.evaluate(animation),
      padding: paddingTween?.evaluate(animation),
      margin: marginTween?.evaluate(animation),
      color: colorTween?.evaluate(animation),
      shadowColor: shadowColorTween?.evaluate(animation),
      elevation: elevationTween?.evaluate(animation),
      border: borderTween?.evaluate(animation) as OutlinedBorder,
      clipBehavior: widget.clipBehavior,
      tooltip: widget.tooltip,
      child: widget.child,
    );
  }
}
