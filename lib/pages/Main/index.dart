import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 一般应用程序的导航是固定的
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_home_active.png", // 激活显示的图标
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_pro_active.png", // 激活显示的图标
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_cart_active.png", // 激活显示的图标
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_my_active.png", // 激活显示的图标
      "text": "我的",
    },
  ];
  int _currentIndex = 0;

  final UserController _usercontroller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    // 初始化用户
    _initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea避开安全区组件
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  _initUser() async {
    await tokenManager.init(); // 初始化token
    if(tokenManager.getToken().isNotEmpty) {
      // 如果token有值就获取用户信息
      _usercontroller.updateUserInfo(await getUserInfoAPI());
    }
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }
}
