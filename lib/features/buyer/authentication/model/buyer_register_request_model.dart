class BuyerRegisterRequestModel {
    BuyerRegisterRequestModel({
        required this.firstName,
        required this.lastName,
        this.displayName,
        required this.email,
        required this.password,
        this.idToken
    });

    final String? firstName;
    final String? lastName;
    final String? displayName;
    final String? email;
    final String? password;
    final String? idToken;

    BuyerRegisterRequestModel copyWith({
        String? firstName,
        String? lastName,
        String? displayName,
        String? email,
        String? password,
        String? idToken
    }) {
        return BuyerRegisterRequestModel(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            displayName: displayName ?? this.displayName,
            email: email ?? this.email,
            password: password ?? this.password,
            idToken: idToken ?? this.idToken
        );
    }

    factory BuyerRegisterRequestModel.fromJson(Map<String, dynamic> json){
        return BuyerRegisterRequestModel(
            firstName: json["first_name"],
            lastName: json["last_name"],
            displayName: json["display_name"],
            email: json["email"],
            password: json["password"],
            idToken: json['id_token']
        );
    }

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "display_name": displayName,
        "email": email,
        "password": password,
        "id_token" : idToken.toString()
    };

    @override
    String toString(){
        return "$firstName, $lastName, $displayName, $email, $password, $idToken";
    }
}
