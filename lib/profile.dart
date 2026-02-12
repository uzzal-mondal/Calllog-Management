import 'package:flutter/material.dart';
import 'package:call_log_management/api/api_service.dart';
import 'package:call_log_management/api/api_constants.dart';
import 'package:call_log_management/model/desiginationlist.dart';
import 'package:call_log_management/model/loginresponse.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController displayNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController emergencyContactController;
  late TextEditingController presentAddressController;
  late TextEditingController permanentAddressController;

  // Dropdown values
  DesignationList? selectedDepartment;
  DesignationList? selectedDesignation;

  // Dropdown lists
  List<DesignationList> departmentItems = [];
  List<DesignationList> designationItems = [];

  @override
  void initState() {
    super.initState();
    final user = ApiConstants.loginResponse.user!;

    // Initialize controllers with user data
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

    fetchDropdowns();
  }

  Future<void> fetchDropdowns() async {
    final userId = ApiConstants.loginResponse.user!.userId!;
    final deptList = await ApiService.getDropdownList("Department", userId);
    final desigList = await ApiService.getDropdownList("Designation", userId);

    setState(() {
      departmentItems = deptList;
      designationItems = desigList;

      selectedDepartment = departmentItems.isNotEmpty
          ? departmentItems.firstWhere(
              (d) => d.id == ApiConstants.loginResponse.user!.departmentId,
              orElse: () => departmentItems[0],
            )
          : null;

      selectedDesignation = designationItems.isNotEmpty
          ? designationItems.firstWhere(
              (d) => d.id == ApiConstants.loginResponse.user!.designationId,
              orElse: () => designationItems[0],
            )
          : null;
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
      appBar: AppBar(
        backgroundColor: Colors.blue, // set your app bar color
        iconTheme: const IconThemeData(
          color: Colors.white, // back button color
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true, // optional
      ),

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
              buildTextField("Emergency Contact", emergencyContactController),
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
              buildDropdown(
                "Department",
                selectedDepartment,
                departmentItems,
                (value) => setState(() => selectedDepartment = value),
              ),
              buildDropdown(
                "Designation",
                selectedDesignation,
                designationItems,
                (value) => setState(() => selectedDesignation = value),
              ),

              SizedBox(
                width: double.infinity, // makes button full width
                child: ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ), // taller button
                    backgroundColor: Colors.blue, // button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // rounded corners
                    ),
                    elevation: 4, // shadow effect
                  ),
                  child: const Text(
                    "Save Profile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text field builder
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

  // Dropdown builder
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

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ApiConstants.loginResponse.user!;

    User updatedUser = User(
      userId: user.userId,
      displayName: displayNameController.text,
      email: emailController.text,
      mobile: mobileController.text,
      emergencyContactMobile: emergencyContactController.text,
      presentAddress: presentAddressController.text,
      permanentAddress: permanentAddressController.text,
      departmentId: selectedDepartment?.id,
      designationId: selectedDesignation?.id,
    );

    bool success = await ApiService.updateUserProfile(updatedUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "Profile updated successfully" : "Failed to update profile",
        ),
      ),
    );

    if (success) setState(() {});
  }
}
