import 'package:flutter/material.dart';

import '../entity/project_entity.dart';

class ItemSquare extends StatefulWidget {
  const ItemSquare({super.key, required this.element});

  final DataElement element;

  @override
  State<ItemSquare> createState() => _ItemSquareState();
}

class _ItemSquareState extends State<ItemSquare> {
  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // 定义卡片宽度为屏幕宽度
      height: 150, // 定义卡片高度为100
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey[200],
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isStarred = !isStarred;
                });
              },
              child: Icon(
                Icons.favorite,
                color: isStarred ? Colors.red : Colors.grey,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              // 使用Expanded包裹以确保子组件不会溢出
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.element.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                    softWrap: true, // 设置为true，使文字过长时自动换行
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('分享人:${widget.element.shareUser}'),
                  const SizedBox(height: 5,),
                  Text(widget.element.niceShareDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
