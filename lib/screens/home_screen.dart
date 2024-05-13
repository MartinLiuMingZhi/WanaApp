import 'dart:convert';

import 'package:application/common/api.dart';
import 'package:application/components/articlelist.dart';
import 'package:application/components/carousel.dart';
import 'package:application/entity/article_entity.dart';
import 'package:application/entity/banner_entity.dart';
import 'package:application/network/http_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> banners = [];
  List<Datum> articles = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var response = await HttpUtil().get(Api.BANNER);
    Map<String, dynamic> bannerMap = json.decode(response.toString());
    var bannerEntity = BannerEntity.fromJson(bannerMap);
    if (bannerEntity.errorCode == 0) {
      setState(() {
        banners = bannerEntity.data;
      });
    }

    var articleResponse = await HttpUtil().get(Api.TOP_ARTICLE);
    Map<String, dynamic> articleMap = json.decode(articleResponse.toString());
    var articleEntity = ArticleEntity.fromJson(articleMap);
    if (articleEntity.errorCode == 0) {
      setState(() {
        articles = articleEntity.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: banners.isEmpty
                ? const Center(child: CircularProgressIndicator()) // 加载指示器
                : Carousel(banners: banners), // 显示轮播图
          ),
          Expanded(
            flex: 3,
            child: banners.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ArticleList(
                    articles: articles,
                  ),
          ),
        ],
      ),
    );
  }
}
