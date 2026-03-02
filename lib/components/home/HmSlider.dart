import 'package:flutter/material.dart';

class HmSlider extends StatefulWidget {
  HmSlider({Key? key}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 300,
      child: PageView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "轮播图${index + 1}",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
