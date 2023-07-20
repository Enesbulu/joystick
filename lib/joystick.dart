import 'package:flutter/material.dart';

enum Directions { up, down, right, left }

enum JoystickMode { all, horizontal, vertical }

class Joystick extends StatefulWidget {
  final Color backgroundColor;
  final double opacity;
  final double size;
  final JoystickMode joystickMode;
  final Color iconColor;
  //CallBacks
  final VoidCallback onUpPressed;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final VoidCallback onDownPressed;
  final Function(Directions) onPressed;
  final bool isDraggable;

  const Joystick({
    super.key,
    this.backgroundColor = Colors.cyan,
    this.opacity = 0.2,
    required this.size,
    required this.iconColor,
    required this.joystickMode,
    required this.onUpPressed,
    required this.onLeftPressed,
    required this.onRightPressed,
    required this.onDownPressed,
    required this.onPressed,
    required this.isDraggable,
  })  : assert(size != null),
        assert(isDraggable != null);
  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            bottom: _y,
            right: _x,
            child: GestureDetector(
              onLongPress: (widget.isDraggable == false)
                  ? null
                  : () {
                      setState(() {
                        _x = 0;
                        _y = 0;
                      });
                    },
              child: Container(
                  //container alanının yukseklik ve genişlik değerleri
                  height: widget.size,
                  width: widget.size,
                  decoration: BoxDecoration(
                      color: widget.backgroundColor
                              .withOpacity(widget.opacity ?? 1) ??
                          Colors.orange,
                      shape: BoxShape.circle),
                  child: Column(children: [
                    //Up
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                              //Üst ok bölümü
                              child: (widget.joystickMode ==
                                      JoystickMode.horizontal)
                                  ? SizedBox()
                                  : IconButton(
                                      padding: EdgeInsets.all(
                                          0), //kenar alan yapılandırılması-Paddin alanı
                                      icon: Icon(Icons.keyboard_arrow_up,
                                          color: (widget.iconColor == null)
                                              ? Colors.blue
                                              : widget.iconColor),
                                      onPressed: () {
                                        if (widget.onUpPressed != null)
                                          widget.onUpPressed();
                                        if (widget.onPressed != null)
                                          widget.onPressed(Directions.up);
                                      },
                                    ),
                            ),
                            Expanded(
                              child: SizedBox(),
                            )
                          ],
                        )),
                    //Middle
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              //sol buton alanı
                              child:
                                  (widget.joystickMode == JoystickMode.vertical)
                                      ? SizedBox()
                                      : IconButton(
                                          padding: EdgeInsets.all(
                                              0), //kenar alan yapılandırılması-Paddin alanı
                                          icon: Icon(Icons.keyboard_arrow_left,
                                              color: (widget.iconColor == null)
                                                  ? Colors.blue
                                                  : widget.iconColor),
                                          onPressed: () {
                                            if (widget.onLeftPressed != null)
                                              widget.onLeftPressed();
                                            if (widget.onPressed != null)
                                              widget.onPressed(Directions.left);
                                          },
                                        ),
                            ),
                            Expanded(
                              //Sürükle- bırak bölümü
                              child: GestureDetector(
                                child: Icon(Icons.drag_handle,
                                    color: (widget.iconColor == null)
                                        ? Colors.blue
                                        : widget.iconColor),
                                onPanUpdate: (details) {
                                  if (widget.isDraggable == true) {
                                    setState(() {
                                      _x -= details.delta.dx;
                                      _y -= details.delta.dy;
                                    });
                                  }
                                },
                              ),
                            ),
                            //Sağ ok alanı
                            Expanded(
                              child: (widget.joystickMode ==
                                      JoystickMode.vertical)
                                  ? SizedBox()
                                  : IconButton(
                                      padding: EdgeInsets.all(
                                          0), //kenar alan yapılandırılması-Paddin alanı
                                      icon: Icon(Icons.keyboard_arrow_right,
                                          color: (widget.iconColor == null)
                                              ? Colors.blue
                                              : widget.iconColor),
                                      onPressed: () {
                                        if (widget.onRightPressed != null)
                                          widget.onRightPressed();
                                        if (widget.onPressed != null)
                                          widget.onPressed(Directions.right);
                                      },
                                    ),
                            )
                          ],
                        )),
                    //Down
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                              //Alt ok alanı
                              child: (widget.joystickMode ==
                                      JoystickMode.horizontal)
                                  ? SizedBox()
                                  : IconButton(
                                      padding: EdgeInsets.all(
                                          0), //kenar alan yapılandırılması-Paddin alanı
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      color: (widget.iconColor == null)
                                          ? Colors.black
                                          : widget.iconColor,
                                      onPressed: () {
                                        if (widget.onDownPressed != null)
                                          widget.onDownPressed();
                                        if (widget.onPressed != null)
                                          widget.onPressed(Directions.down);
                                      },
                                    ),
                            ),
                            Expanded(
                              child: SizedBox(),
                            )
                          ],
                        )),
                  ])),
            ))
      ],
    );
  }
}
