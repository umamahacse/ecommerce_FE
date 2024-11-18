class SellerRegisterRequestModel {
  SellerRegisterRequestModel({
    required this.firstName,
    required this.lastName,
    this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    this.idToken
  });

  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? confirmPassword;
  final String? idToken;

  SellerRegisterRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? idToken
  }) {
    return SellerRegisterRequestModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        idToken: idToken ?? this.idToken
    );
  }

  factory SellerRegisterRequestModel.fromJson(Map<String, dynamic> json){
    return SellerRegisterRequestModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        displayName: json["display_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        idToken: json['id_token']
    );
  }

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "displayName": displayName,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
    "confirmPassword": confirmPassword,
    "id_token" : idToken.toString()
  };

  @override
  String toString(){
    return "$firstName, $lastName, $displayName, $phoneNumber, $email, $confirmPassword, $password, $idToken";
  }
}
