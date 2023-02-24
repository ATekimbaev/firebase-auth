import 'package:firebase_app/screens/login/bloc/login_bloc_bloc.dart';
import 'package:firebase_app/screens/registration/bloc/registration_bloc.dart';
import 'package:firebase_app/screens/registration/registartion_screen.dart';
import 'package:firebase_app/screens/welcome_screen/welcome_screen.dart';
import 'package:firebase_app/services/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FireBaseAuthService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationBloc(
                repo: RepositoryProvider.of<FireBaseAuthService>(context)),
          ),
          BlocProvider(
            create: (context) => LoginBlocBloc(
                repo: RepositoryProvider.of<FireBaseAuthService>(context)),
          ),
        ],
        child: const MaterialApp(
          home: Welcome(),
        ),
      ),
    );
  }
}
