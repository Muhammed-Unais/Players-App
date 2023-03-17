import 'package:flutter/material.dart';

class PlaySongButtons extends StatelessWidget {

  final Widget icons;
  final double width;
  final double hight;
  const PlaySongButtons({
    Key? key, required this.icons, required this.width, required this.hight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      decoration:  const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
      child: icons,
    );
  }
}
