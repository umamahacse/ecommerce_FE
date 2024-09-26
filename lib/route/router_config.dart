import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view/buyer_login.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view/buyer_register.dart';
import 'package:frontend_ecommerce/features/buyer/landing/view/landing_screen.dart';
import 'package:frontend_ecommerce/route/router_constant.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <GoRoute>[
      GoRoute(
          path: AppPages.landing,
          builder: (BuildContext context, GoRouterState state) {
            return const LandingScreen();
          }),
      GoRoute(
        path: AppPages.auth+AppPages.buyerRegister,
        builder: (BuildContext context, GoRouterState state) {
          return const BuyerRegister();
        }
      ),
      GoRoute(
        path: AppPages.auth+AppPages.buyerLogin,
        builder: (BuildContext context, GoRouterState state) {
          return const BuyerLogin();
        }
      ),
    ],
  );
}
