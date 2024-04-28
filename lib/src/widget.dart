import 'package:flutter/material.dart';

class MarqueeTransition extends StatefulWidget {
  const MarqueeTransition({
    super.key,
    this.repeat = -1,
    this.pause = false,
    this.mirror = false,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 50000),
    this.direction = AxisDirection.right,
    this.padding,
    this.divider,
    required this.child,
  });

  final int repeat;
  final bool pause;
  final bool mirror;
  final Duration delay;
  final Duration duration;
  final AxisDirection direction;
  final EdgeInsetsGeometry? padding;
  final Widget? divider;
  final Widget child;

  @override
  State<MarqueeTransition> createState() => MarqueeTransitionState();
}

class MarqueeTransitionState extends State<MarqueeTransition> {
  /// The [ScrollController] that controls the animation.
  final controller = ScrollController();

  /// Track of how many times the animation cycle has finished playing.
  int cycle = 0;

  /// Track whether the animation has initially run.
  bool isInitialized = false;

  /// Track whether all specified loops have finished playing
  /// (if [widget.repeat] is not set to `-1` for infinite loops).
  bool get isCompleted => isDefinitely && cycle > widget.repeat;

  /// Track whether the animation is running.
  bool get isAnimating => !widget.pause;

  /// Indicates the animation should play forward, then backward in a mirroring effect.
  bool get isMirror => widget.mirror;

  /// Indicates the animation should play in straight direction.
  bool get isNotMirror => !isMirror;

  /// Indicates repeat definitely
  bool get isDefinitely => widget.repeat > -1;

  /// Indicates repeat indefinitely
  bool get isIndefinitely => !isDefinitely;

  bool get isAvailable => mounted && controller.hasClients;

  Axis get axis => axisDirectionToAxis(widget.direction);

  Widget get defaultDivider => SizedBox(
        width: axis == Axis.horizontal ? 10 : null,
        height: axis == Axis.vertical ? 10 : null,
      );

  void _animate(_) {
    if (isMirror) {
      _animateMirror();
    } else {
      _animateEndless();
    }
  }

  void _animateEndless() {}

  void _animateMirror() async {
    if (!isAvailable) return;
    final double maxExtent = controller.position.maxScrollExtent;
    final double minExtent = controller.position.minScrollExtent;

    if (!isAvailable) return;
    await Future.delayed(widget.delay);
    await controller.animateTo(
      maxExtent,
      duration: widget.duration,
      curve: Curves.linear,
    );

    if (!isAvailable) return;
    await Future.delayed(widget.delay);
    await controller.animateTo(
      minExtent,
      duration: widget.duration,
      curve: Curves.linear,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_animate);
  }

  @override
  void didUpdateWidget(covariant MarqueeTransition oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Flex(
      direction: axis,
      children: [
        widget.child,
        widget.divider ?? defaultDivider,
        widget.child,
      ],
    );

    return SingleChildScrollView(
      scrollDirection: axis,
      controller: controller,
      padding: widget.padding,
      physics: const NeverScrollableScrollPhysics(),
      child: child,
    );
  }
}
