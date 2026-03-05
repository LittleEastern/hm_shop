import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
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
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }

  List<Widget> _getScrollChildren() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), // 轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置分类组件
      // SliverGrid SliverList只能纵向排列
      // 所以SliverToBoxAdapter包裹ListView
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)), // 分类组件
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

  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  // 分类列表
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }
}
