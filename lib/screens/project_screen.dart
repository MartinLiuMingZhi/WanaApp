import 'dart:convert';

import 'package:application/entity/project_type_entity.dart';
import 'package:application/network/http_util.dart';
import 'package:flutter/material.dart';

import '../common/api.dart';
import '../components/project_view.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  List<Datum> projectTypes = [];
  int _selectedIndex = 0; // 记录当前选中的索引

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  Future<void> _fetchData() async {
    var response = await HttpUtil().get(Api.PROJECT);
    Map<String, dynamic> projectTypeMap = json.decode(response.toString());
    var projectTypeEntity = ProjectTypeEntity.fromJson(projectTypeMap);
    if (projectTypeEntity.errorCode == 0) {
      setState(() {
        projectTypes = projectTypeEntity.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: projectTypes.length,
      child: Scaffold(
        appBar: AppBar(
          title  : TabBar(
            isScrollable: true, // 允许滚动
            tabs: projectTypes.map((datum) => Tab(text: datum.name)).toList(),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: projectTypes.map((datum) => ProjectView(cid:datum.id)).toList(),
        ),
      ),
    );
  }
}
