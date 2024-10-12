class BuyerLoginRequestModel {
    BuyerLoginRequestModel({
        required this.email,
        required this.password,
        this.idToken
    });

    final String? email;
    final String? password;
    final String? idToken;

    BuyerLoginRequestModel copyWith({
        String? email,
        String? password,
        String? idToken
    }) {
        return BuyerLoginRequestModel(
            email: email ?? this.email,
            password: password ?? this.password,
            idToken: idToken ?? this.idToken
        );
    }

    factory BuyerLoginRequestModel.fromJson(Map<String, dynamic> json){ 
        return BuyerLoginRequestModel(
            email: json["email"],
            password: json["password"],
            idToken: json['id_token']
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "id_token": idToken
    };

    @override
    String toString(){
        return "$email, $password, $idToken";
    }
}
