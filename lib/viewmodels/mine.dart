import 'package:hm_shop/viewmodels/home.dart';

class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsDetailsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] == null
          ? []
          : (json["items"] as List)
              .map((item) => GoodDetailItem.fromJSON(item as Map<String, dynamic>))
              .toList(),
    );
  }
}