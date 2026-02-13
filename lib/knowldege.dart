import 'package:call_log_management/model/postmodel.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'package:flutter_html/flutter_html.dart'; // for rendering HTML content

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({super.key});

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  final ScrollController _controller = ScrollController();
  List<PostItem> posts = [];
  int page = 1;
  int totalPages = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPosts();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        // load more if not loading and pages remain
        if (!isLoading && page <= totalPages) {
          loadPosts();
        }
      }
    });
  }

  Future<void> loadPosts() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final response = await ApiService.fetchPosts(
        userId: 1,
        pageNumber: page,
        pageSize: 10,
      );

      setState(() {
        posts.addAll(response.posts);
        page++;
        totalPages = response.pages.totalPages;
      });
    } catch (e) {
      print("ERROR: $e");
      // optional: show snackbar
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Knowledge Base",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: posts.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _controller,
              padding: const EdgeInsets.all(16),
              itemCount: posts.length + (page <= totalPages ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final post = posts[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.blue),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Html(data: post.content),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      // Optional: navigate to post details page
                    },
                  ),
                );
              },
            ),
    );
  }
}
