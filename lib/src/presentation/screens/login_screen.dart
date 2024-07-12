import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../injection_container.dart';
import '../blocs/login_bloc.dart';
import '../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final _container = InjectionContainer();
  StreamSubscription<TokenEntity>? _subscription;

  @override
  void initState() {
    final useCases = _container.useCases;
    _loginBloc = LoginBloc(useCases);
    _subscription = _loginBloc.haveLogin.listen(
      (token) {
        Navigator.pushNamed(context, AppRoutes.home);
      },
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: LoginTemplate(
        onLogin: (username, password) {
          _loginBloc.login(UserEntity(username: username, password: password));
        },
        onTapWithoutAccount: () {
          Navigator.pushNamed(
            context,
            AppRoutes.register,
          );
        },
      ),
    );
  }
}
