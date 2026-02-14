import 'package:call_log_management/common/commondropdown.dart';
import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../model/desiginationlist.dart';

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

  DesignationList? selectedDepartment;
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
    issueLabel = await ApiService.getDropdownList("IssueLabel", 1);
    issuePriority = await ApiService.getDropdownList("IssuePriority", 1);
    issueStatus = await ApiService.getDropdownList("IssueStatus", 1);
    await loadSection(1);
    setState(() => loading = false);
  }

  /// Load Section By RefId
  Future<void> loadSection(int refId) async {
    section = await ApiService.getDropdownList("Section", 12, refId: refId);
    selectedSection = null;
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
                CrossAxisAlignment.stretch, // Stretch to full width
            children: [
              /// Issue Priority
              SizedBox(
                width: double.infinity, // Ensure full width
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

              /// Section Dropdown
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

              /// Bottom spacing
              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
