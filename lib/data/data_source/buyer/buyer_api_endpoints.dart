import 'package:frontend_ecommerce/config/endpoints_config.dart';

class BuyerApiEndpoints {
  static const String buyerRegister = "${EndpointsConfig.backendUrl}buyer/register";
  static const String buyerRegisterSocial = "${EndpointsConfig.backendUrl}buyer/register-social";
  static const String buyerLogin = "${EndpointsConfig.backendUrl}buyer/login";
}