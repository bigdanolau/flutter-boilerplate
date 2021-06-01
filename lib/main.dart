// @packages
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// @scripts
import 'package:flutter_boilerplate/business_logic/services/shared_preferences.dart';
import 'package:flutter_boilerplate/screens/forgot_password/forgot_password.dart';
import 'package:flutter_boilerplate/screens/verify_code/verify_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_boilerplate/config/theme/custom_theme.dart';
import 'package:flutter_boilerplate/screens/root/root.dart';
import 'package:flutter_boilerplate/screens/second_screen/second_screen.dart';
import 'package:flutter_boilerplate/business_logic/bloc/basic_state/basic_state_bloc.dart';
import 'package:flutter_boilerplate/screens/sign_up_screen/sign_up.dart';
import 'package:flutter_boilerplate/business_logic/bloc/user_auth_state/user_auth_state_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BasicStateBloc>(create: (_) => BasicStateBloc()),
        BlocProvider<UserAuthStateBloc>(create: (_) => UserAuthStateBloc()),
      ],
      child: FlutterBaseline(),
    );
  }
}

class FlutterBaseline extends StatefulWidget {
  const FlutterBaseline({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlutterBaseline();
}

class _FlutterBaseline extends State<FlutterBaseline> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: CustomTheme().lightTheme,
            routes: {
              '/': (context) => const Root(),
              '/secondScreen': (context) => const SecondScreen(),
              '/signUp': (context) => const SignUpPage(),
              '/verifyAccount': (context) => const VerifyPage(),
              '/forgotPassword': (context) => const ForgotPassword()
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
