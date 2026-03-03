import 'package:flutter/material.dart';
import 'package:hm_shop/components/home/HmCategory.dart';
import 'package:hm_shop/components/home/HmHot.dart';
import 'package:hm_shop/components/home/HmMoreList.dart';
import 'package:hm_shop/components/home/HmSlider.dart';
import 'package:hm_shop/components/home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }

  List<Widget> _getScrollChildren() {
    final List<BannerItem> _bannerList = [
      BannerItem(
        id: "1",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
      ),
      BannerItem(
        id: "2",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
      ),
      BannerItem(
        id: "3",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
      ),
    ];

    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), // 轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置分类组件
      // SliverGrid SliverList只能纵向排列
      // 所以SliverToBoxAdapter包裹ListView
      SliverToBoxAdapter(child: HmCategory()), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion()), // 特惠推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 爆款推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(), // 无限滚动列表
    ];
  }
}
