import 'package:flutter/widgets.dart';
import '../border/widget.dart';

class WxBox extends StatelessWidget {
  const WxBox({
    Key? key,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
    this.padding,
    this.margin,
    this.color,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.borderStyle,
    this.borderSide,
    this.borderRadius,
    this.shape,
    this.shadowColor,
    this.clipBehavior,
    this.elevation,
    this.tooltip,
    this.child,
  }) : super(key: key);

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

  bool get hasCustomShape => border != null;

  BorderSide? get effectiveBorderSide {
    return BorderSide.none
        .copyWith(
          color: borderSide?.color,
          width: borderSide?.width,
          style: borderSide?.style,
        )
        .copyWith(
          color: borderColor,
          width: borderWidth,
          style: borderStyle,
        );
  }

  OutlinedBorder get borderShape {
    switch (shape) {
      case BoxShape.circle:
        return CircleBorder(
          side: effectiveBorderSide ?? BorderSide.none,
        );
      default:
        return RoundedRectangleBorder(
          side: effectiveBorderSide ?? BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.zero,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? result = child;

    final constraints = width != null || height != null
        ? this.constraints?.tighten(width: width, height: height) ??
            BoxConstraints.tightFor(width: width, height: height)
        : this.constraints;

    if (child == null && (constraints == null || !constraints.isTight)) {
      result = LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      );
    } else if (alignment != null) {
      result = Align(alignment: alignment!, child: result);
    }

    if (padding != null) {
      result = Padding(padding: padding!, child: result);
    }

    if (constraints != null) {
      result = ConstrainedBox(constraints: constraints, child: result);
    }

    final border = this.border ?? borderShape;
    final textDirection = Directionality.maybeOf(context);
    final clipper = ShapeBorderClipper(
      textDirection: textDirection,
      shape: border,
    );

    result = WxBorder(
      textDirection: textDirection,
      shape: border,
      child: result,
    );

    if (color == null) {
      result = ClipPath(
        clipper: clipper,
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        child: result,
      );
    } else {
      if (hasCustomShape) {
        result = PhysicalShape(
          color: color!,
          elevation: elevation ?? 0.0,
          shadowColor: shadowColor ?? const Color(0xFF000000),
          clipBehavior: clipBehavior ?? Clip.antiAlias,
          clipper: clipper,
          child: result,
        );
      } else {
        result = PhysicalModel(
          color: color!,
          elevation: elevation ?? 0.0,
          shadowColor: shadowColor ?? const Color(0xFF000000),
          clipBehavior: clipBehavior ?? Clip.antiAlias,
          borderRadius: borderRadius,
          shape: shape ?? BoxShape.rectangle,
          child: result,
        );
      }
    }

    if (margin != null) {
      result = Padding(padding: margin!, child: result);
    }

    return result;
  }
}
