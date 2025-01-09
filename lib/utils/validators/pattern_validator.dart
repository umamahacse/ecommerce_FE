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


  static bool? isValidGstNumber(context, String gstNumber){
    final regex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9A-Z]{1}$');
    return regex.hasMatch(gstNumber);
  }

  static bool? isValidPanNumber(context, String panNumber){
    final regex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return regex.hasMatch(panNumber);
  }

}