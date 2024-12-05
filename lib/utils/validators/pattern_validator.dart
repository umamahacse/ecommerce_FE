import 'package:frontend_ecommerce/utils/regex/regex_list.dart';

class PatternValidator {
  
  static String? isValidName(context, String? value,
      String? emptyErrorText, String? invalidErrorText) {
    if (value == null || value.isEmpty) {
      return emptyErrorText;
    } else if(!RegexList.nameRegEx .hasMatch(value)){
      return invalidErrorText;
    } 
    return null;
}

  static String? isValidPassword(context, String? value, String? emptyErrorText, String? invalidErrorText, {String confirmPassword = "", String misMatchErrorText = ""}){
    if (value == null || value.isEmpty) {
      return emptyErrorText;
    }else if(confirmPassword.isNotEmpty && value != confirmPassword){
      return misMatchErrorText;
    } else if(!RegexList.passwordRegEx .hasMatch(value)){
      return invalidErrorText;
    }
    return null;
  }

  static String? isValidEmail(context, String? value,
      String? emptyErrorText, String? invalidErrorText) {
    if (value == null || value.isEmpty) {
      return emptyErrorText;
    } else if(!RegexList.emailRegEx .hasMatch(value)){
      return invalidErrorText;
    } 
    return null;
}

  static String? isValidPhoneNumber(context, String? value,
      String? emptyErrorText, String? invalidErrorText) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return emptyErrorText;
    }
    else if (!regExp.hasMatch(value ?? '')) {
      return invalidErrorText;
    }
    return null;
  }


}