import 'dart:convert';

import 'package:flutter/material.dart';

import '../common/api.dart';
import '../components/article_webview.dart';
import '../entity/project_entity.dart';
import '../network/http_util.dart';
import '../widgets/item_square.dart';


class SquareScreen extends StatefulWidget {
  const SquareScreen({super.key});

  @override
  State<SquareScreen> createState() => _SquareScreenState();
}

class _SquareScreenState extends State<SquareScreen> {

  List<DataElement> projects = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    int currentPage = 0;
    while (true) {
      final response = await HttpUtil().get(Api.USER_ARTICE, data: {"page_size": (currentPage + 1).toString()});
      final projectMap = json.decode(response.toString());
      final projectEntity = ProjectEntity.fromJson(projectMap);
      if (projectEntity.errorCode == 0 && projectEntity.data.datas.isNotEmpty) {
        setState(() {
          projects.addAll(projectEntity.data.datas);
          isLoading = false;
        });
        currentPage++;
      } else {
        setState(() {
          isLoading = false;
        });
        break; // No more data available
      }
    }
  }


  // 定义方法处理点击事件
  void _handleArticleTap(int index) async {
    // 获取当前文章的URL
    String articleUrl = projects[index].link;
    String title = projects[index].title;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleWebView(title: title ,url: articleUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('近期分享'),
        centerTitle: true, // 这个属性会使标题居中
      ),
      body:  ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          // 构建列表项
          return GestureDetector(
            onTap: () {
              // 调用方法处理点击事件
              _handleArticleTap(index);
            },
            child:  ItemSquare(element: projects[index],),
          );
        },
        itemCount: projects.length, // 列表项数量

      ),
    );
  }
}
