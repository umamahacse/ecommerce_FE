class BuyerLoginRequestModel {
    BuyerLoginRequestModel({
        required this.email,
        required this.password,
        this.displayName,
        this.idToken
    });

    final String? displayName;
    final String? email;
    final String? password;
    final String? idToken;

    BuyerLoginRequestModel copyWith({
        String? email,
        String? password,
        String? displayName,
        String? idToken
    }) {
        return BuyerLoginRequestModel(
            email: email ?? this.email,
            password: password ?? this.password,
            displayName: displayName ?? this.displayName,
            idToken: idToken ?? this.idToken
        );
    }

    factory BuyerLoginRequestModel.fromJson(Map<String, dynamic> json){ 
        return BuyerLoginRequestModel(
            email: json["email"],
            password: json["password"],
            displayName: json["display_name"],
            idToken: json['id_token']
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "display_name" : displayName,
        "id_token": idToken
    };

    @override
    String toString(){
        return "$email, $password, $displayName, $idToken";
    }
}
