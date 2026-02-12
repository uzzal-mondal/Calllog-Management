import 'package:call_log_management/api/api_constants.dart';
import 'package:call_log_management/api/api_service.dart';
import 'package:call_log_management/model/desiginationlist.dart';
import 'package:call_log_management/model/loginresponse.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  late TextEditingController displayNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController emergencyContactController;
  late TextEditingController presentAddressController;
  late TextEditingController permanentAddressController;

  // Selected dropdown values
  DesignationList? selectedDepartment;
  DesignationList? selectedDesignation;

  // Dropdown lists
  List<DesignationList> departmentItems = [];
  List<DesignationList> designationItems = [];

  @override
  void initState() {
    super.initState();
    final user = ApiConstants.loginResponse.user!;

    // Initialize controllers
    displayNameController = TextEditingController(text: user.displayName ?? "");
    emailController = TextEditingController(text: user.email ?? "");
    mobileController = TextEditingController(text: user.mobile ?? "");
    emergencyContactController = TextEditingController(
      text: user.emergencyContactMobile ?? "",
    );
    presentAddressController = TextEditingController(
      text: user.presentAddress ?? "",
    );
    permanentAddressController = TextEditingController(
      text: user.permanentAddress ?? "",
    );

    // Fetch dropdown data
    fetchDepartments();
    fetchDesignations();
  }

  Future<void> fetchDepartments() async {
    final userId = ApiConstants.loginResponse.user!.userId!;
    final list = await ApiService.getDropdownList("Department", userId);
    setState(() {
      departmentItems = list;
    });
  }

  Future<void> fetchDesignations() async {
    final userId = ApiConstants.loginResponse.user!.userId!;
    final list = await ApiService.getDropdownList("Designation", userId);
    setState(() {
      designationItems = list;
    });
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    emergencyContactController.dispose();
    presentAddressController.dispose();
    permanentAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50, color: Colors.white),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              buildTextField("Display Name", displayNameController),
              buildTextField(
                "Email",
                emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              buildTextField(
                "Mobile No",
                mobileController,
                keyboardType: TextInputType.phone,
              ),
              buildTextField(
                "Emergency Contact Person",
                emergencyContactController,
              ),
              buildTextField(
                "Present Address",
                presentAddressController,
                maxLines: 2,
              ),
              buildTextField(
                "Permanent Address",
                permanentAddressController,
                maxLines: 2,
              ),
              const SizedBox(height: 15),
              // Department Dropdown
              buildDropdown(
                "Department",
                selectedDepartment,
                departmentItems,
                (value) => setState(() => selectedDepartment = value),
              ),
              // Designation Dropdown
              buildDropdown(
                "Designation",
                selectedDesignation,
                designationItems,
                (value) => setState(() => selectedDesignation = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Prepare updated User object
                    User updatedUser = User(
                      displayName: displayNameController.text,
                      email: emailController.text,
                      mobile: mobileController.text,
                      emergencyContactMobile: emergencyContactController.text,
                      presentAddress: presentAddressController.text,
                      permanentAddress: permanentAddressController.text,
                      // You can also add department and designation ids if your API supports them
                      // e.g. departmentId: selectedDepartment?.id, designationId: selectedDesignation?.id
                    );

                    bool success = await ApiService.updateUserProfile(
                      updatedUser,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? "Profile updated successfully"
                              : "Failed to update profile",
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Save Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text Field Builder
  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) =>
            (value == null || value.isEmpty) ? "Please enter $label" : null,
      ),
    );
  }

  // Generic Dropdown Builder for DesignationList objects
  Widget buildDropdown(
    String label,
    DesignationList? value,
    List<DesignationList> items,
    ValueChanged<DesignationList?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<DesignationList>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<DesignationList>(
                value: item,
                child: Text(item.name ?? ""),
              ),
            )
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? "Please select $label" : null,
      ),
    );
  }
}
