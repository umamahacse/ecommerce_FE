class BuyerRegisterRequestModel {
    BuyerRegisterRequestModel({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
    });

    final String? firstName;
    final String? lastName;
    final String? email;
    final String? password;

    BuyerRegisterRequestModel copyWith({
        String? firstName,
        String? lastName,
        String? email,
        String? password,
    }) {
        return BuyerRegisterRequestModel(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            password: password ?? this.password,
        );
    }

    factory BuyerRegisterRequestModel.fromJson(Map<String, dynamic> json){ 
        return BuyerRegisterRequestModel(
            firstName: json["first_name"],
            lastName: json["last_name"],
            email: json["email"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
    };

    @override
    String toString(){
        return "$firstName, $lastName, $email, $password, ";
    }
}
