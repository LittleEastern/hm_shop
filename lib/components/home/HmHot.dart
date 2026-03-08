import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmHot extends StatefulWidget {
  final SpecialRecommendResult result;
  final String type;
  HmHot({Key? key, required this.result, required this.type}) : super(key: key);

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  List<GoodsItem> get _items {
    if (widget.result.subTypes.isEmpty) return [];
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.type == "hot"
            ? Color.fromARGB(255, 211, 228, 240)
            : Color.fromARGB(255, 249, 247, 219),
      ),
      child: Column(
        children: [_buildHeader(), SizedBox(height: 10), _buildContent()],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "hot" ? "爆款推荐" : "一站买全",
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "hot" ? "最受欢迎" : "精心优选",
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 20),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _getChildrenList(),
    );
  }

  List<Widget> _getChildrenList() {
    return List.generate(
      _items.length,
      (index) => Expanded(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _items[index].picture,
                  //width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "lib/assets/home_cmd_inner.png",
                      //width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                "￥${_items[index].price}",
                style: TextStyle(
                  color: Color.fromARGB(255, 86, 24, 20),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
