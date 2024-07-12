import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dart_fake_store_api_wrapper/dart_fake_store_api_wrapper.dart';
import 'package:mosaic_flair/mosaic_flair.dart';

import '../../injection_container.dart';
import '../blocs/register_bloc.dart';
import '../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterBloc _registerBloc;
  final _container = InjectionContainer();
  StreamSubscription<IdEntity>? _subscription;

  @override
  void initState() {
    final useCases = _container.useCases;
    _registerBloc = RegisterBloc(useCases);
    _subscription = _registerBloc.haveRegister.listen(
      (id) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
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
    _registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegisterTemplate(
      onRegister: (email, password, username, lastname, name, phone) {
        _registerBloc.register(UserEntity(
            username: username,
            password: password,
            email: email,
            name: NameEntity(firstname: name, lastname: lastname),
            phone: phone));
      },
    );
  }
}
