class SellerOTPRequestModel {
  final String? phoneNumber;
  SellerOTPRequestModel({
    required this.phoneNumber,
  });

  SellerOTPRequestModel copyWith({
    String? phoneNumber,
  }) {
    return SellerOTPRequestModel(
        phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory SellerOTPRequestModel.fromJson(Map<String, dynamic> json){
    return SellerOTPRequestModel(
        phoneNumber: json["phone_number"],
    );
  }

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
  };

  @override
  String toString(){
    return "$phoneNumber";
  }
}