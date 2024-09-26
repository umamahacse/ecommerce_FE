class ErrorResponseModel {
    ErrorResponseModel({
        required this.status,
        required this.message,
    });

    final int? status;
    final String? message;

    ErrorResponseModel copyWith({
        int? status,
        String? message,
    }) {
        return ErrorResponseModel(
            status: status ?? this.status,
            message: message ?? this.message,
        );
    }

    factory ErrorResponseModel.fromJson(Map<String, dynamic> json){ 
        return ErrorResponseModel(
            status: json["status"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };

    @override
    String toString(){
        return "$status, $message, ";
    }
}
