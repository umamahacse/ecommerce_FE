import '../../../config/endpoints_config.dart';

class SellerApiEndpoints {
  static const String sellerRegister = "${EndpointsConfig.backendUrl}seller/register";
  static const String sellerGenerateOTP = "${EndpointsConfig.backendUrl}seller/generate-otp";
  static const String sellerVerifyOTP = "${EndpointsConfig.backendUrl}seller/verify-otp";
  static const String sellerRegisterSocial = "${EndpointsConfig.backendUrl}seller/register-social";
  static const String sellerLogin = "${EndpointsConfig.backendUrl}seller/login";
  static const String sellerCreateContract = "${EndpointsConfig.backendUrl}seller/creating-contract";
  static const String getCreateContractDetails = "${EndpointsConfig.backendUrl}seller/get-contract-details";
}