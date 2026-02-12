// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? userId;
    String? username;
    String? displayName;
    String? userImage;
    String? email;
    String? source;
    bool? isActive;
    String? mobile;
    String? emergencyContactPersion;
    String? emergencyContactMobile;
    String? presentAddress;
    String? permanentAddress;
    int? departmentId;
    int? designationId;

    UserModel({
        this.userId,
        this.username,
        this.displayName,
        this.userImage,
        this.email,
        this.source,
        this.isActive,
        this.mobile,
        this.emergencyContactPersion,
        this.emergencyContactMobile,
        this.presentAddress,
        this.permanentAddress,
        this.departmentId,
        this.designationId,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["UserId"],
        username: json["Username"],
        displayName: json["DisplayName"],
        userImage: json["UserImage"],
        email: json["Email"],
        source: json["Source"],
        isActive: json["IsActive"],
        mobile: json["Mobile"],
        emergencyContactPersion: json["EmergencyContactPersion"],
        emergencyContactMobile: json["EmergencyContactMobile"],
        presentAddress: json["PresentAddress"],
        permanentAddress: json["PermanentAddress"],
        departmentId: json["DepartmentId"],
        designationId: json["DesignationId"],
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Username": username,
        "DisplayName": displayName,
        "UserImage": userImage,
        "Email": email,
        "Source": source,
        "IsActive": isActive,
        "Mobile": mobile,
        "EmergencyContactPersion": emergencyContactPersion,
        "EmergencyContactMobile": emergencyContactMobile,
        "PresentAddress": presentAddress,
        "PermanentAddress": permanentAddress,
        "DepartmentId": departmentId,
        "DesignationId": designationId,
    };
}
