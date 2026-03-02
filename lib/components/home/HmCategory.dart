import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // 返回一个横向滚动的组件
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
        return Container(color: Colors.blue, width: 80, alignment: Alignment.center, margin: EdgeInsets.symmetric(horizontal: 10),
        child: Text("分类${index + 1}", style: TextStyle(color: Colors.white),),);
      }),
    );
  }
}