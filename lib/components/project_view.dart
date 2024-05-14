import 'dart:convert';

import 'package:application/widgets/item_project.dart';
import 'package:flutter/material.dart';

import '../common/api.dart';
import '../entity/project_entity.dart';
import '../network/http_util.dart';
import 'article_webview.dart';


class ProjectView extends StatefulWidget {
  const ProjectView({super.key, required this.cid});

  final int cid;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}



class _ProjectViewState extends State<ProjectView> {

  List<DataElement> projects = [];


  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  @override
  void dispose() {
    projects.clear(); // 清空列表，以确保释放资源
    super.dispose();
  }

  Future<void> _fetchData() async {
    var data = {'cid':widget.cid};
    var response = await HttpUtil().get(Api.PROJECT_LIST,data: data );
    Map<String, dynamic> projectMap = json.decode(response.toString());
    var projectEntity = ProjectEntity.fromJson(projectMap);
    if (projectEntity.errorCode == 0) {
      setState(() {
        projects = projectEntity.data.datas;
      });
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
    return SingleChildScrollView(
      child: projects.isEmpty // 添加空值检查
          ? const Center(
        child: CircularProgressIndicator(), // 显示加载指示器或其他UI，以表示数据正在加载中
      ) : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          var item = projects[index];
          return GestureDetector(
            onTap: () {
              // 调用方法处理点击事件
              _handleArticleTap(index);
            },
            child: ItemProject(
              imagePath: item.envelopePic,
              title: item.title,
              projectLink: item.projectLink,
              link: item.link,
            ),
          );
        },
      ),
    );
  }

}
