import 'package:call_log_management/knowledgedetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../api/api_service.dart';
import '../model/postmodel.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({super.key});

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<PostItem> posts = [];
  int page = 1;
  int totalPages = 1;
  bool isLoading = false;
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    loadPosts();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        if (!isLoading && page <= totalPages) {
          loadPosts();
        }
      }
    });

    _searchController.addListener(() {
      final term = _searchController.text.trim();
      if (term != searchTerm) {
        searchTerm = term;
        page = 1;
        posts.clear();
        totalPages = 1;
        loadPosts();
      }
    });
  }

  Future<void> loadPosts() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final response = await ApiService.searchPosts(
        userId: 1,
        searchTerm: searchTerm,
        pageNumber: page,
        pageSize: 10,
      );

      setState(() {
        posts.addAll(response.posts);
        page++;
        totalPages = response.pages.totalPages;
      });
    } catch (e) {
      debugPrint("ERROR: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Knowledge Base"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          Expanded(
            child: posts.isEmpty && isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _controller,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        ),
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    KnowledgeDetailsScreen(post: post),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
