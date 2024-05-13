import 'package:flutter/material.dart';

class ItemArticle extends StatefulWidget {
  const ItemArticle(
      {super.key,
      required this.author,
      required this.title,
      required this.superChapterName,
      required this.chapterName,
      required this.niceShareDate});

  final String author;
  final String title;
  final String superChapterName;
  final String chapterName;
  final String niceShareDate;

  @override
  State<ItemArticle> createState() => _ItemArticleState();
}

class _ItemArticleState extends State<ItemArticle> {

  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      '置顶',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.author,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Text(
                  widget.niceShareDate,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.superChapterName}:${widget.chapterName}',
                  style: const TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isStarred = !isStarred;
                    });
                  },
                  child: Icon(
                    Icons.star_rounded,
                    color: isStarred ? Colors.red : Colors.grey, // 根据状态改变颜色
                    size: 30,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
