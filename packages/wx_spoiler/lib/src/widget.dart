import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:wx_text/wx_text.dart';
import 'controller.dart';

/// Function signature for building a custom spoiler widget.
typedef WxSpoilerBuilder = Widget Function(
  BuildContext context,
  Widget content,
  VoidCallback toggle,
);

/// A general-purpose spoiler widget that conceals any child widget
/// (such as images, containers, or rich content) until revealed by tapping or via controller.
class WxSpoiler extends StatefulWidget {
  /// Creates a spoiler widget around any [child].
  const WxSpoiler({
    super.key,
    required this.child,
    this.placeholder,
    this.overlay,
    this.controller,
    this.expanded = false,
    this.onExpanded,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
    this.blurred = true,
    this.blurSigma = 10.0,
    this.wrapper = WxSpoiler.defaultWrapper,
  });

  /// The child widget to be concealed/revealed.
  final Widget child;

  /// Optional widget displayed when collapsed. If null, the [child] is blurred according to [blurred].
  final Widget? placeholder;

  /// Optional overlay widget displayed on top of the concealed content.
  final Widget? overlay;

  /// An optional controller to manage the spoiler state externally.
  final WxSpoilerController? controller;

  /// Initial visibility state. When `false`, content is concealed.
  final bool expanded;

  /// Callback invoked when expanded state changes.
  final ValueChanged<bool>? onExpanded;

  /// Duration of blur or crossfade transitions.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Whether to blur the [child] when collapsed. Defaults to `true`.
  final bool blurred;

  /// Sigma value for Gaussian blur when concealed. Defaults to `10.0`.
  final double blurSigma;

  /// Wrapper builder that handles user interactions. Defaults to tap-to-toggle.
  final WxSpoilerBuilder wrapper;

  /// Default builder using MouseRegion and GestureDetector.
  static Widget defaultWrapper(
    BuildContext context,
    Widget content,
    VoidCallback toggle,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: toggle,
        child: content,
      ),
    );
  }

  @override
  State<WxSpoiler> createState() => _WxSpoilerState();
}

class _WxSpoilerState extends State<WxSpoiler> {
  WxSpoilerController? _internalController;
  WxSpoilerController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = WxSpoilerController(
        expanded: widget.expanded,
        onExpanded: widget.onExpanded,
      );
    }
  }

  @override
  void didUpdateWidget(covariant WxSpoiler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _internalController = WxSpoilerController(
        expanded: widget.expanded,
        onExpanded: widget.onExpanded,
      );
    } else if (widget.controller != null && oldWidget.controller == null) {
      _internalController?.dispose();
      _internalController = null;
    }

    if (widget.controller == null) {
      if (oldWidget.onExpanded != widget.onExpanded) {
        _internalController?.onExpanded = widget.onExpanded;
      }
      if (oldWidget.expanded != widget.expanded &&
          widget.expanded != _internalController?.expanded) {
        _internalController?.expanded = widget.expanded;
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WxSpoilerProvider(
      controller: _effectiveController,
      child: ListenableBuilder(
        listenable: _effectiveController,
        builder: (context, _) {
          final isExpanded = _effectiveController.expanded;

          Widget content;
          if (widget.placeholder != null) {
            content = AnimatedCrossFade(
              duration: widget.duration,
              firstCurve: widget.curve,
              secondCurve: widget.curve,
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: widget.placeholder!,
              secondChild: widget.child,
            );
          } else if (widget.blurred) {
            content = TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: isExpanded ? 0.0 : widget.blurSigma,
                end: isExpanded ? 0.0 : widget.blurSigma,
              ),
              duration: widget.duration,
              curve: widget.curve,
              builder: (context, sigma, child) {
                Widget blurredWidget = sigma > 0.1
                    ? ImageFiltered(
                        imageFilter: ui.ImageFilter.blur(
                          sigmaX: sigma,
                          sigmaY: sigma,
                          tileMode: ui.TileMode.clamp,
                        ),
                        child: child,
                      )
                    : child!;

                if (widget.overlay != null && !isExpanded) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      blurredWidget,
                      widget.overlay!,
                    ],
                  );
                }
                return blurredWidget;
              },
              child: widget.child,
            );
          } else {
            content = AnimatedOpacity(
              duration: widget.duration,
              curve: widget.curve,
              opacity: isExpanded ? 1.0 : 0.0,
              child: widget.child,
            );
          }

          return widget.wrapper(context, content, _effectiveController.toggle);
        },
      ),
    );
  }
}

/// A widget that extends [WxText] to provide dynamic text expansion/collapse functionality.
///
/// This widget allows users to reveal or hide text content through a tap interaction.
/// It's ideal for displaying sensitive information or lengthy text snippets that
/// can be gradually revealed upon user request.
class WxSpoilerText extends WxText {
  /// Creates a collapsible text widget.
  const WxSpoilerText(
    super.text, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.textScaler,
    super.locale,
    super.softWrap,
    super.overflow,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.highlight,
    super.highlightStyle,
    super.highlightOnTap,
    super.filter,
    super.filterDisabled,
    super.filterCaseSensitive,
    super.filterMultiLine,
    super.filterUnicode,
    super.filterDotAll,
    super.outlineColor,
    super.outlineWidth,
    super.outlineOffset,
    super.outlineBehind,
    super.gradient,
    super.variant,
    super.color,
    super.backgroundColor,
    super.shadows,
    super.fontFamily,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    this.controller,
    this.expanded = false,
    this.onExpanded,
    this.filterDisabledOnCollapsed = false,
    this.duration = const Duration(milliseconds: 200),
    this.wrapper = WxSpoiler.defaultWrapper,
  });

  /// An optional controller to manage the spoiler state externally.
  final WxSpoilerController? controller;

  /// Determines initial text visibility (expanded or collapsed).
  final bool expanded;

  /// A callback function that is invoked whenever the `expanded` property changes.
  final ValueChanged<bool>? onExpanded;

  /// Determines whether to disable all the filter when text collapsed.
  final bool filterDisabledOnCollapsed;

  /// The duration of the whole orchestrated animation.
  final Duration duration;

  /// Callback that builds the final widget
  final WxSpoilerBuilder wrapper;

  /// Default builder that uses GestureDetector to enable tapping on the wrapped content
  static const defaultWrapper = WxSpoiler.defaultWrapper;

  @override
  Widget build(BuildContext context) {
    // if maxLines null, returns normal text
    if (maxLines == null) return super.build(context);

    // build collapsed widget from this widget with optional disabled filter
    final collapsedText = WxText.from(
      this,
      overflow: overflow ?? TextOverflow.ellipsis,
      filterDisabled: filterDisabledOnCollapsed || filterDisabled,
    );

    // build expanded text from this widget with disabled maxLines and visible overflow
    final expandedText = WxText.from(
      this,
      maxLines: -1,
      overflow: TextOverflow.visible,
    );

    return _WxSpoilerTextView(
      controller: controller,
      expanded: expanded,
      onExpanded: onExpanded,
      duration: duration,
      wrapper: wrapper,
      collapsedText: collapsedText,
      expandedText: expandedText,
    );
  }
}

class _WxSpoilerTextView extends StatefulWidget {
  const _WxSpoilerTextView({
    this.controller,
    required this.expanded,
    this.onExpanded,
    required this.duration,
    required this.wrapper,
    required this.collapsedText,
    required this.expandedText,
  });

  final WxSpoilerController? controller;
  final bool expanded;
  final ValueChanged<bool>? onExpanded;
  final Duration duration;
  final WxSpoilerBuilder wrapper;
  final Widget collapsedText;
  final Widget expandedText;

  @override
  State<_WxSpoilerTextView> createState() => _WxSpoilerTextViewState();
}

class _WxSpoilerTextViewState extends State<_WxSpoilerTextView> {
  WxSpoilerController? _internalController;
  WxSpoilerController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = WxSpoilerController(
        expanded: widget.expanded,
        onExpanded: widget.onExpanded,
      );
    }
  }

  @override
  void didUpdateWidget(covariant _WxSpoilerTextView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _internalController = WxSpoilerController(
        expanded: widget.expanded,
        onExpanded: widget.onExpanded,
      );
    } else if (widget.controller != null && oldWidget.controller == null) {
      _internalController?.dispose();
      _internalController = null;
    }

    if (widget.controller == null) {
      if (oldWidget.onExpanded != widget.onExpanded) {
        _internalController?.onExpanded = widget.onExpanded;
      }
      if (oldWidget.expanded != widget.expanded &&
          widget.expanded != _internalController?.expanded) {
        _internalController?.expanded = widget.expanded;
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WxSpoilerProvider(
      controller: _effectiveController,
      child: ListenableBuilder(
        listenable: _effectiveController,
        builder: (context, _) {
          final child = AnimatedCrossFade(
            duration: widget.duration,
            crossFadeState: _effectiveController.expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: widget.collapsedText,
            secondChild: widget.expandedText,
          );
          return widget.wrapper(context, child, _effectiveController.toggle);
        },
      ),
    );
  }
}
