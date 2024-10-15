import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_button.dart';
import 'package:frontend_ecommerce/common/widget/shared/input_text_field.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view_model/login_viewmodel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class BuyerLogin extends StatefulWidget {
  const BuyerLogin({super.key});

  @override
  State<BuyerLogin> createState() => _BuyerLoginState();
}

class _BuyerLoginState extends State<BuyerLogin> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name, imageUrl, userEmail, uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Consumer<LoginViewmodel>(builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 150, height: 150, child: AppLogo()),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        color: AppColors.white,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              InputTextField(
                                formKey: provider.emailFormKey,
                                controller: provider.emailController,
                                errorText: provider.emailErrorText,
                                hintText:
                                    AppLocalizations.of(context).enter_email,
                                labelText: AppLocalizations.of(context).email,
                                onTextChange: (value) {
                                  provider.validateEmail(context, value);
                                },
                              ),
                              SizedBox(
                                height: DimenConstant.inputContentSpacing,
                              ),
                              InputTextField(
                                formKey: provider.passwordFormKey,
                                controller: provider.passwordController,
                                errorText: provider.passwordErrorText,
                                isObscureText: true,
                                hintText:
                                    AppLocalizations.of(context).enter_password,
                                labelText:
                                    AppLocalizations.of(context).password,
                                onTextChange: (value) {
                                  provider.validatePassword(context, value);
                                },
                              ),
                              SizedBox(
                                height: DimenConstant.inputContentSpacing,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CustomButton(
                                    buttonText:
                                        AppLocalizations.of(context).login,
                                    onPressed: () {
                                      provider.buyerLogin(context);
                                    },
                                    backgroundColor: AppColors.primaryColor,
                                    textStyle: FontStyles.labelMedium
                                        .copyWith(color: AppColors.white)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Container(
                                      color: AppColors.inActiveBorder,
                                      height: 1,
                                      width: 100,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('Or'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Container(
                                      color: AppColors.inActiveBorder,
                                      height: 1,
                                      width: 100,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                  onTap: () {
                                    signInWithGoogle(provider, context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.inActiveBorder),
                                        borderRadius: BorderRadius.circular(
                                            DimenConstant.buttonCornerRadius)),
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 20,
                                        end: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                                'asset/logo/google_logo.png')),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                            child: Text(
                                          AppLocalizations.of(context)
                                              .sign_in_with_google,
                                          style: const TextStyle(fontSize: 16),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }


  Future<User?> signInWithGoogle(LoginViewmodel provider, BuildContext context) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    // The `GoogleAuthProvider` can only be
    // used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();


    try {
      final UserCredential userCredential =
      await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
      String idToken = await user.getIdToken() ?? '';
      print("name: $name");
      print("userEmail: $userEmail");
      print("imageUrl: $imageUrl");
      print("idToken: $idToken");

      provider.buyerRegisterCallSocial(context, name ?? '' , userEmail ?? '', idToken);
    }
    return user;
  }

}
