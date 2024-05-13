
import 'package:flutter/material.dart';
import '../entity/article_entity.dart';
import '../widgets/item_article.dart';
import 'article_webview.dart';


class ArticleList extends StatefulWidget {
  const ArticleList({super.key, required this.articles});

  final List<Datum> articles;

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {


  // 定义方法处理点击事件
  void _handleArticleTap(int index) async {
    // 获取当前文章的URL
    String articleUrl = widget.articles[index].link;
    String title = widget.articles[index].title;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleWebView(title: title ,url: articleUrl),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return GestureDetector(
        onTap: () {
          // 调用方法处理点击事件
          _handleArticleTap(index);
        },
        child: ItemArticle(
          author: widget.articles[index].author,
          title: widget.articles[index].title,
          superChapterName: widget.articles[index].superChapterName,
          chapterName: widget.articles[index].chapterName,
          niceShareDate: widget.articles[index].niceShareDate,
        ),
      );
    },itemCount: widget.articles.length,);
  }
}
