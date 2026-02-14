import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../model/postmodel.dart';

class KnowledgeDetailsScreen extends StatelessWidget {
  final PostItem post;

  const KnowledgeDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(data: post.content),
      ),
    );
  }
}
