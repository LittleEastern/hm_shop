import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
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
  double _paddingTop = 0;

  // GlobalKey是一个方法可以创建一个key绑定到Widget部件上 可以操作Widget部件
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _registerEvent();
    // initState => build => 下拉刷新组件 => 才可以操作它
    // Future.mic
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller, // 绑定控制器
          slivers: _getScrollChildren(),
        ),
      ),
    );
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
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ), // 特惠推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 爆款推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
  }

  // 分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  // 特惠推荐
  Future<void> _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListAPI();
  }

  // 爆款推荐
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 一站买全
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  // 获取推荐列表
  Future<void> _getRecommendList(int page) async {
    // 当已经有请求正在加载 或者已经没有下一页了 就放弃请求
    if (_isLoading || !_hasMore) return;
    _isLoading = true; // 占住位置
    _recommendList = await getRecommendListAPI({"limit": _page * 10});
    _isLoading = false; //松开位置
    // 我要10条 你给10条 说明我要的你都给了 接着认为还有下一页
    // 我要10条 你给9条
    if (_recommendList.length < _page * 10) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  Future<void> _onRefresh() async {
    _isLoading = false;
    _hasMore = true;
    _page = 1;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList(_page);
    // 数据获取成功 刷新成功了
    ToastUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // 加载下一页数据
        _getRecommendList(_page);
      }
    });
  }
}
