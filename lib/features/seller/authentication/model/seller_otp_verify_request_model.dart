class SellerOTPVerifyRequestModel {
  final String? phoneNumber;
  final String? otp;
  SellerOTPVerifyRequestModel({
    required this.phoneNumber,
    required this.otp
  });

  SellerOTPVerifyRequestModel copyWith({
    String? phoneNumber,
    String? otp
  }) {
    return SellerOTPVerifyRequestModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp
    );
  }

  factory SellerOTPVerifyRequestModel.fromJson(Map<String, dynamic> json){
    return SellerOTPVerifyRequestModel(
      phoneNumber: json["phone_number"],
      otp: json['otp']
    );
  }

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "otp" : otp
  };

  @override
  String toString(){
    return "$phoneNumber, $otp";
  }
}