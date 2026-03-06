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
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 爆款推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站买全
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  // 滚动控制器
  final ScrollController _controller = ScrollController();
  bool _isLoading = false; // 当前正在加载状态
  bool _hasMore = true; // 是否还有下一页
  int _page = 1; // 页码

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialRecommendList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList(_page);
    _registerEvent();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller, // 绑定控制器
      slivers: _getScrollChildren());
  }

  List<Widget> _getScrollChildren() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), // 轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置分类组件
      // SliverGrid SliverList只能纵向排列
      // 所以SliverToBoxAdapter包裹ListView
      SliverToBoxAdapter(
        child: HmCategory(categoryList: _categoryList),
      ), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion(specialRecommendResult: _specialRecommendResult)), // 特惠推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 爆款推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot(result: _inVogueResult, type: "hot")),
              SizedBox(width: 10),
              Expanded(child: HmHot(result: _oneStopResult, type: "step")),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
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

  // 特惠推荐
  void _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListAPI();
    setState(() {});
  }

  // 爆款推荐
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 一站买全
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

   // 获取推荐列表
  void _getRecommendList(int page) async {
    // 当已经有请求正在加载 或者已经没有下一页了 就放弃请求
    if(_isLoading || !_hasMore) return;
    _isLoading = true; // 占住位置
    _recommendList = await getRecommendListAPI({"limit": _page * 10});
    _isLoading = false; //松开位置
    setState(() {});
    // 我要10条 你给10条 说明我要的你都给了 接着认为还有下一页
    // 我要10条 你给9条 
    if(_recommendList.length < _page * 10) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if(_controller.position.pixels >= (_controller.position.maxScrollExtent - 50)) {
        // 加载下一页数据
        _getRecommendList(_page);
      }
    });
  }
}
