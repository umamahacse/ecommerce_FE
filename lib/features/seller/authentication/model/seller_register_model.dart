import 'package:frontend_ecommerce/features/shared/model/error_response.dart';

class SellerRegisterModel {
  SellerRegisterModel({
    required this.status,
    required this.data,
    this.accessToken
  });

  final int? status;
  final Data? data;
  final String? accessToken;

  SellerRegisterModel copyWith({
    int? status,
    Data? data,
    String? accessToken
  }) {
    return SellerRegisterModel(
        status: status ?? this.status,
        data: data ?? this.data,
        accessToken: accessToken
    );
  }

  factory SellerRegisterModel.fromJson(Map<String, dynamic> json){
    return SellerRegisterModel(
        status: json["status"],
        data: json["result"] == null ? null : Data.fromJson(json["result"]),
        accessToken: json["access_token"]
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": data?.toJson(),
    "access_token": accessToken
  };

  @override
  String toString(){
    return "$status, $data, $accessToken";
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.updatedAt,
    required this.createdAt,
    required this.phoneNumber,
    required this.isOtpVerified,
    required this.gstNumber,
    required this.gstOtpVerified,
    required this.storeName,
    required this.pickUp,
    required this.shippingMethod,
    required this.shippingCharge,
    required this.authToken,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String? phoneNumber;
  final bool? isOtpVerified;
  final bool? gstNumber;
  final bool? gstOtpVerified;
  final String? storeName;
  final Pickup? pickUp;
  final String? shippingMethod;
  final String? shippingCharge;
  final String? authToken;

  Data copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? phoneNumber,
    bool? isOtpVerified,
    bool? gstNumber,
    bool? gstOtpVerified,
    String? storeName,
    Pickup? pickUp,
    String? shippingMethod,
    String? shippingCharge,
    String? authToken,
  }) {
    return Data(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      gstNumber: gstNumber ?? this.gstNumber,
      gstOtpVerified: gstOtpVerified ?? this.gstOtpVerified,
      storeName: storeName ?? this.storeName,
      pickUp: this.pickUp,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shippingCharge: shippingCharge ?? this.shippingCharge,
      authToken: authToken ?? this.authToken,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      confirmPassword: json["confirmPassword"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      phoneNumber: json["phoneNumber"],
      isOtpVerified: json["isOtpVerified"],
      gstNumber: json["gstNumber"],
      gstOtpVerified: json["gstOtpVerified"],
      storeName: json["storeName"],
      pickUp: json["pickUp"] != null? Pickup.fromJson(json["pickUp"] as Map<String, dynamic>) : null,
      shippingMethod: json["shippingMethod"],
      shippingCharge: json["shippingCharge"],
      authToken: json["authToken"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "phoneNumber": phoneNumber,
    "isOtpVerified": isOtpVerified,
    "gstNumber": gstNumber,
    "gstOtpVerified": gstOtpVerified,
    "storeName": storeName,
    "pickUp": pickUp?.toJson(),
    "shippingMethod": shippingMethod,
    "shippingCharge": shippingCharge,
    "authToken": authToken,
  };

  @override
  String toString() {
    return "$id, $firstName, $lastName, $email, $password, $confirmPassword, $updatedAt, $createdAt, $phoneNumber, $isOtpVerified, $gstNumber, $gstOtpVerified, $storeName, ${pickUp?.toString()}, $shippingMethod, $shippingCharge, $authToken";
  }
}



class Pickup {
  final String? address;
  final double? lat;
  final double? lng;
  final String? street;
  final String? doorNo;
  final String? city;

  Pickup({
    this.address,
    this.lat,
    this.lng,
    this.street,
    this.doorNo,
    this.city,
  });

  // Factory constructor to parse JSON data
  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      street: json['street'] as String?,
      doorNo: json['door_no'] as String?,
      city: json['city'] as String?,
    );
  }

  // Convert the Pickup object to JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'lat': lat,
      'lng': lng,
      'street': street,
      'door_no': doorNo,
      'city': city,
    };
  }

  @override
  String toString() {
    return 'Pickup(address: $address, lat: $lat, lng: $lng, street: $street, doorNo: $doorNo, city: $city)';
  }
}



class SellerRegisterResponseModel{
  final SellerRegisterModel? sellerRegisterModel;
  final ErrorResponseModel? errorResponseModel;

  SellerRegisterResponseModel({
    required this.sellerRegisterModel,
    required this.errorResponseModel
  });
}
