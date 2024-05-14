import 'dart:io';

import 'package:flutter/material.dart';

class ItemProject extends StatefulWidget {
  const ItemProject({super.key, required this.imagePath, required this.title, required this.projectLink, required this.link});

  final String imagePath;
  final String title;
  final String projectLink;
  final String link;

  @override
  State<ItemProject> createState() => _ItemProjectState();
}

class _ItemProjectState extends State<ItemProject> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Set the desired height of the card
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded( // Use Expanded to force the Image.network to fit within available space
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}