class SellerCreateContractRequestModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final int? stepIndex;
  final String? panName;
  final String? panNumber;
  final String? gstNumber;

  SellerCreateContractRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.stepIndex,
    this.panName,
    this.panNumber,
    this.gstNumber
  });

  SellerCreateContractRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    int? stepIndex,
    String? panName,
    String? panNumber,
    String? gstNumber,
  }) {
    return SellerCreateContractRequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      stepIndex: stepIndex ?? this.stepIndex,
      gstNumber: gstNumber ?? this.gstNumber,
      panName: panName ?? this.panName,
      panNumber: panNumber ?? this.panNumber
    );
  }

  factory SellerCreateContractRequestModel.fromJson(Map<String, dynamic> json){
    return SellerCreateContractRequestModel(
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      confirmPassword: json["confirm_password"],
      stepIndex: json["stepIndex"],
      gstNumber: json["gstNumber"],
      panNumber: json["panNumber"],
      panName: json["panName"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "stepIndex": stepIndex,
      "panNumber": panNumber,
      "panName": panName,
      "gstNumber": gstNumber
    };
  }

  @override
  String toString(){
    return "$firstName $lastName $email $password $confirmPassword $stepIndex";
  }
}