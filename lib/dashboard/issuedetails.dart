import 'package:call_log_management/common/commondropdown.dart';
import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../model/desiginationlist.dart';
import '../../api/api_constants.dart';

class IssueDetailsScreen extends StatefulWidget {
  final int issueId;

  const IssueDetailsScreen({super.key, required this.issueId});

  @override
  State<IssueDetailsScreen> createState() => _IssueDetailsScreenState();
}

class _IssueDetailsScreenState extends State<IssueDetailsScreen> {
  bool loading = true;

  List<DesignationList> issueLabel = [];
  List<DesignationList> issuePriority = [];
  List<DesignationList> issueStatus = [];
  List<DesignationList> section = [];

  DesignationList? selectedIssueLabel;
  DesignationList? selectedIssuePriority;
  DesignationList? selectedIssueStatus;
  DesignationList? selectedSection;

  @override
  void initState() {
    super.initState();
    loadAllDropdowns();
  }

  /// Load all dropdowns
  Future<void> loadAllDropdowns() async {
    loading = true;
    setState(() {});


    issueLabel = await ApiService.getDropdownList("IssueLabel", 1);
    issuePriority = await ApiService.getDropdownList("IssuePriority", 1);
    issueStatus = await ApiService.getDropdownList("IssueStatus", 1);

   
    await loadSection(refId: 1);

    loading = false;
    setState(() {});
  }

  /// Load Section dynamically based on logged-in userId and refId
  Future<void> loadSection({required int refId}) async {
    int userId = ApiConstants.loginResponse.user!.userId!;
    section = await ApiService.getDropdownList("Section", userId, refId: refId);
    selectedSection = null; // Reset selection
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Issue Details"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch full width
            children: [
              /// Issue Priority
              SizedBox(
                width: double.infinity,
                child: CommonDropdown(
                  label: "Issue Priority",
                  value: selectedIssuePriority,
                  items: issuePriority,
                  onChanged: (v) => setState(() => selectedIssuePriority = v),
                ),
              ),
              const SizedBox(height: 16),

              /// Issue Status
              SizedBox(
                width: double.infinity,
                child: CommonDropdown(
                  label: "Issue Status",
                  value: selectedIssueStatus,
                  items: issueStatus,
                  onChanged: (v) => setState(() => selectedIssueStatus = v),
                ),
              ),
              const SizedBox(height: 16),

              /// Section Dropdown (dynamic)
              SizedBox(
                width: double.infinity,
                child: CommonDropdown(
                  label: "Section",
                  value: selectedSection,
                  items: section,
                  onChanged: (v) => setState(() => selectedSection = v),
                ),
              ),
              const SizedBox(height: 16),

              /// Issue Label
              SizedBox(
                width: double.infinity,
                child: CommonDropdown(
                  label: "Issue Label",
                  value: selectedIssueLabel,
                  items: issueLabel,
                  onChanged: (v) => setState(() => selectedIssueLabel = v),
                ),
              ),

              const SizedBox(height: 24), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
