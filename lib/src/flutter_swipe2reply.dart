import 'package:flutter/material.dart';

class Swipe2reply extends StatefulWidget {
  final VoidCallback onSlided;
  final bool isRight;
  final Widget child;

  const Swipe2reply({
    Key? key,
    required this.onSlided,
    required this.isRight,
    required this.child,
  }) : super(key: key);

  @override
  State<Swipe2reply> createState() => _Swipe2replyState();
}

class _Swipe2replyState extends State<Swipe2reply>
    with SingleTickerProviderStateMixin {
  final _duration = const Duration(milliseconds: 1);
  late final _controller =
      AnimationController(vsync: this, duration: _duration);
  double animationProgress = 0.0;

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation(double progress) {
    setState(() {
      animationProgress = progress;
      _controller.value = animationProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (widget.isRight) {
          _updateAnimation(
              (animationProgress - (details.delta.dx / 100)).clamp(0.0, 1.0));
        } else {
          _updateAnimation(
              (animationProgress + (details.delta.dx / 100)).clamp(0.0, 1.0));
        }
      },
      onHorizontalDragEnd: (_) async {
        if (_controller.value > 0.5) {
          widget.onSlided.call();
        }
        _controller.reverse().whenComplete(() => _updateAnimation(0));
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: widget.isRight ? 16 : null,
            left: widget.isRight ? null : 16,
            child: AnimatedOpacity(
              duration: _duration,
              opacity: _controller.value > 0.5 ? 1 : 0,
              child: const Icon(
                Icons.reply,
                color: Colors.black,
              ),
            ),
          ),
          SlideTransition(
            position: Tween(
              begin: const Offset(0.0, 0.0),
              end: Offset(widget.isRight ? -0.2 : 0.2, 0.0),
            ).animate(
              CurvedAnimation(
                curve: Curves.fastOutSlowIn,
                parent: _controller,
              ),
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
