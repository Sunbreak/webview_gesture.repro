import 'package:flutter/material.dart';

class HorizontalDragDetector extends StatefulWidget {
  final Widget child;

  const HorizontalDragDetector({Key key, this.child}) : super(key: key);

  @override
  _HorizontalDragDetectorState createState() => _HorizontalDragDetectorState();
}

class _HorizontalDragDetectorState extends State<HorizontalDragDetector> {
  double lastMoveX;
  double lastMoveY;
  double downX;
  bool isHorizontalDrag;
  int horizontalDragThreshold = 50;

  int downPointer = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (downEvent) {
        downX = lastMoveX = downEvent.position.dx;
        lastMoveY = downEvent.position.dy;
        isHorizontalDrag = false;

        downPointer = downEvent.pointer;
      },
      onPointerMove: (moveEvent) {
        if (downPointer != moveEvent.pointer) return;
        final double moveX = moveEvent.position.dx;
        final double moveY = moveEvent.position.dy;
        if ((moveY - lastMoveY).abs() < (moveX - lastMoveX).abs() &&
            (moveX - downX).abs() > horizontalDragThreshold) {
          isHorizontalDrag = true;
        }
        if (isHorizontalDrag) {
          final double offsetX = moveX - lastMoveX;

          if (offsetX != 0) {
            OverscrollNotification(
                    overscroll: -offsetX,
                    context: context,
                    metrics: FixedScrollMetrics(
                        axisDirection: offsetX > 0
                            ? AxisDirection.left
                            : AxisDirection.right,
                        pixels: 0,
                        minScrollExtent: 0,
                        maxScrollExtent: 0,
                        viewportDimension: 0))
                .dispatch(context);
          }
        }
        lastMoveX = moveX;
        lastMoveY = moveY;
      },
      child: widget.child,
    );
  }
}
