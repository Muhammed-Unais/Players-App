import 'package:flutter/material.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({super.key, required this.value, required this.function, required this.max});

  final double value;
  final double max;
  final Function(double) function;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
          trackHeight: 3),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.4,
        child: Slider(
          value: value,
          onChanged: function,
          min: 0.0,
          max:max,
          inactiveColor: Colors.grey,
          activeColor: Colors.white,
        ),
      ),
    );
  }
}
