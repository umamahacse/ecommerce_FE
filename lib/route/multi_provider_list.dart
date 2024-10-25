import 'package:frontend_ecommerce/features/buyer/authentication/view_model/login_viewmodel.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view_model/register_viewmodel.dart';
import 'package:frontend_ecommerce/features/seller/authentication/view_model/seller_register_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
List<SingleChildWidget> providersList = [
  ChangeNotifierProvider(create: (_) => RegisterViewmodel()),
  ChangeNotifierProvider(create: (_) => LoginViewmodel()),
  ChangeNotifierProvider(create: (_) => SellerRegisterViewModel()),
];