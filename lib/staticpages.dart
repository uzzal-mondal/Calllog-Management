import 'package:call_log_management/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StaticContentPage extends StatefulWidget {
  final String title;
  final String keyName;

  const StaticContentPage({
    super.key,
    required this.title,
    required this.keyName,
  });

  @override
  State<StaticContentPage> createState() => _StaticContentPageState();
}

class _StaticContentPageState extends State<StaticContentPage> {
  String htmlContent = '';
  bool loading = true;
  String pageTitle = '';
  bool error = false;

  static const cacheDuration = Duration(minutes: 30);

  @override
  void initState() {
    super.initState();
    pageTitle = widget.title;
    loadContent();
  }

  Future<void> loadContent() async {
    setState(() {
      loading = true;
      error = false;
    });

    final prefs = await SharedPreferences.getInstance();
    final contentKey = 'static_content_${widget.keyName}';
    final timestampKey = 'static_content_${widget.keyName}_ts';

    final cachedContent = prefs.getString(contentKey);
    final cachedTitle = prefs.getString('${contentKey}_title');
    final cachedTime = prefs.getInt(timestampKey);

    final now = DateTime.now().millisecondsSinceEpoch;

    if (cachedContent != null &&
        cachedTime != null &&
        now - cachedTime < cacheDuration.inMilliseconds) {
      // Load from cache
      pageTitle = cachedTitle ?? widget.title;
      htmlContent = cachedContent;
      setState(() => loading = false);
      return;
    }

    // Fetch from API
    try {
      final data = await ApiService.getStaticContent(widget.keyName);

      htmlContent = data['Content'] ?? '';
      pageTitle = data['ToolbarTitle'] ?? data['Title'] ?? widget.title;

      // Save to cache
      await prefs.setString(contentKey, htmlContent);
      await prefs.setString('${contentKey}_title', pageTitle);
      await prefs.setInt(timestampKey, now);

      if (mounted) setState(() => loading = false);
    } catch (e) {
      debugPrint('❌ Error fetching content: $e');
      setState(() {
        error = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(pageTitle, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : error
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Failed to load content.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: loadContent,
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  )
                : htmlContent.isEmpty
                    ? const Center(child: Text('No content found.'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Html(data: htmlContent),
                      ),
      ),
    );
  }
}