// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool? success;
    String? token;
    User? user;
    Permissions? permissions;

    LoginResponse({
        this.success,
        this.token,
        this.user,
        this.permissions,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["Success"],
        token: json["Token"],
        user: json["User"] == null ? null : User.fromJson(json["User"]),
        permissions: json["Permissions"] == null ? null : Permissions.fromJson(json["Permissions"]),
    );

    Map<String, dynamic> toJson() => {
        "Success": success,
        "Token": token,
        "User": user?.toJson(),
        "Permissions": permissions?.toJson(),
    };
}

class Permissions {
    bool? administrationGeneral;
    bool? administrationTranslation;
    bool? administrationSecurity;

    Permissions({
        this.administrationGeneral,
        this.administrationTranslation,
        this.administrationSecurity,
    });

    factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
        administrationGeneral: json["Administration:General"],
        administrationTranslation: json["Administration:Translation"],
        administrationSecurity: json["Administration:Security"],
    );

    Map<String, dynamic> toJson() => {
        "Administration:General": administrationGeneral,
        "Administration:Translation": administrationTranslation,
        "Administration:Security": administrationSecurity,
    };
}

class User {
    int? userId;
    String? username;
    String? displayName;
    String? email;
    String? source;
    int? isActive;
    String? mobile;
    String? emergencyContactPersion;
    String? emergencyContactMobile;
    String? presentAddress;
    String? permanentAddress;
    int? departmentId;
    int? designationId;

    User({
        this.userId,
        this.username,
        this.displayName,
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["UserId"],
        username: json["Username"],
        displayName: json["DisplayName"],
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
