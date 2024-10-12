class BuyerLoginRequestModel {
    BuyerLoginRequestModel({
        required this.email,
        required this.password,
    });

    final String? email;
    final String? password;

    BuyerLoginRequestModel copyWith({
        String? email,
        String? password,
    }) {
        return BuyerLoginRequestModel(
            email: email ?? this.email,
            password: password ?? this.password,
        );
    }

    factory BuyerLoginRequestModel.fromJson(Map<String, dynamic> json){ 
        return BuyerLoginRequestModel(
            email: json["email"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };

    @override
    String toString(){
        return "$email, $password, ";
    }
}
