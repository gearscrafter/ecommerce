import 'package:ecommerce/src/core/utils/details_screen_argument.dart';
import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/catalog_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/search_screen.dart';
import '../screens/support_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String cart = '/cart';
  static const String catalog = '/catalog';
  static const String contact = '/contact';
  static const String detail = '/detail';
  static const String search = '/search';
  static const String support = '/support';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case cart:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const CartScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case catalog:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const CatalogScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case contact:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ContactScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case detail:
        final args = settings.arguments as DetailsScreenArguments?;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              DetailScreen(productId: args?.productId ?? 0),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case search:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SearchScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case support:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SupportScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
