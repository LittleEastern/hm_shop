import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  final CarouselSliderController _controller = CarouselSliderController(); // 控制轮播图跳转的控制器
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }

  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    return CarouselSlider(
      carouselController: _controller, // 绑定controller对象
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        onPageChanged: (index, reason) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            fillColor: Color.fromRGBO(0, 0, 0, 0.4),
            contentPadding: EdgeInsets.symmetric(horizontal: 40),
            hint: Text(
              "搜索...",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  // 返回指示灯导航部件
  Widget _getDots() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
          children: List.generate(widget.bannerList.length, (index) {
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(index);
                _currentIndex = index;
                setState(() {});
              },
              child: AnimatedContainer(
                height: 6,
                width: _currentIndex == index ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.white : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ), duration: Duration(milliseconds: 300),
              ),
            );
          }),
        ),
      ),
    );
  }
}
