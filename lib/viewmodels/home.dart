class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  // flutter必须强制转化 没有隐式转化
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

// 根据json编写class对象和工厂转化函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  List<dynamic>? goods;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });

  // 工厂函数 从json创建对象
  factory CategoryItem.fromJSON(Map<String, dynamic> json) {
    // 必须返回一个CategoryItem对象
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
              .map((item) => CategoryItem.fromJSON(item as Map<String, dynamic>))
              .toList(),
      goods: json["goods"],
    );
  }
}
