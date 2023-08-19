import 'package:flutter/material.dart';

class LineLoaderWidget extends StatefulWidget {
  final Color color;
  final double height;
  final double width;
  final Duration duration;
  final Function function;

  const LineLoaderWidget(
      {required this.color,
      this.height = 2,
      this.width = 150,
      this.duration = const Duration(seconds: 1),
      required this.function});

  @override
  _LineLoaderWidgetState createState() => _LineLoaderWidgetState();
}

class _LineLoaderWidgetState extends State<LineLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.function();
        }
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.height),
            child: LinearProgressIndicator(
              value: _animation.value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(widget.color),
            ),
          );
        },
      ),
    );
  }
}
