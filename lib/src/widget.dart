import 'package:flutter/material.dart';

class MarqueeTransition extends StatefulWidget {
  const MarqueeTransition({
    super.key,
    this.repeat = -1,
    this.pause = false,
    this.mirror = false,
    this.direction = AxisDirection.right,
    this.curve = Curves.linear,
    this.delay = Duration.zero,
    required this.duration,
    this.reverseCurve,
    this.reverseDelay,
    this.reverseDuration,
    this.padding,
    this.divider,
    required this.children,
  });

  final int repeat;
  final bool pause;
  final bool mirror;
  final AxisDirection direction;
  final Curve curve;
  final Duration delay;
  final Duration duration;
  final Curve? reverseCurve;
  final Duration? reverseDelay;
  final Duration? reverseDuration;
  final EdgeInsetsGeometry? padding;
  final Widget? divider;
  final List<Widget> children;

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

  void _animate() {
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
      curve: widget.curve,
    );

    if (!isAvailable) return;
    await Future.delayed(widget.reverseDelay ?? widget.delay);
    await controller.animateTo(
      minExtent,
      duration: widget.reverseDuration ?? widget.duration,
      curve: widget.reverseCurve ?? widget.curve,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _animate());
  }

  @override
  void didUpdateWidget(MarqueeTransition oldWidget) {
    _animate();
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
    final children = isNotMirror
        ? [...widget.children, ...widget.children]
        : widget.children;

    return SingleChildScrollView(
      scrollDirection: axis,
      controller: controller,
      padding: widget.padding,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      child: Flex(
        direction: axis,
        children: children,
      ),
    );
  }
}
