import '../../../config/endpoints_config.dart';

class SellerApiEndpoints {
  static const String sellerRegister = "${EndpointsConfig.backendUrl}seller/register";
  static const String sellerRegisterSocial = "${EndpointsConfig.backendUrl}seller/register-social";
  static const String sellerLogin = "${EndpointsConfig.backendUrl}seller/login";
}