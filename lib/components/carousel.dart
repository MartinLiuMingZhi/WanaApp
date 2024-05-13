import 'package:application/entity/banner_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key, required this.banners});

  final List<Data> banners; // 添加一个构造函数参数来接收数据

  @override
  State<Carousel> createState() => _CarouselState();

}

class _CarouselState extends State<Carousel> {

  late final SwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose(); // 释放 ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,

      child:Transform(
        transform: Matrix4.identity()..setEntry(3, 2, 0.001),
        child: Swiper(
          controller: _swiperController,
          itemBuilder: (BuildContext context, int index) {
            // 检查路径是否为空，如果为空则使用默认值
            final imagePath = widget.banners[index].imagePath ?? "";
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // 圆角半径
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // 阴影颜色
                    spreadRadius: 2, // 阴影扩散半径
                    blurRadius: 5, // 阴影模糊半径
                    offset: const Offset(0, 3), // 阴影偏移量
                  ),
                ],
              ),
              child: ClipRRect( // 添加圆角
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          itemCount: widget.banners.length,
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );

  }
}

