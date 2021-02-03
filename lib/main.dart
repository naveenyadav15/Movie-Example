import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'src/provider/auth_provider.dart';
import 'src/ui/home/home_screen.dart';
import 'src/ui/login/phone_auth.dart';
import 'src/ui/login/verify_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AuthProvider(FirebaseAuth.instance),
      child: MaterialApp(
        // supportedLocales: [
        //   Locale('en'),
        //   Locale('it'),
        //   Locale('fr'),
        //   Locale('es'),
        // ],
        // localizationsDelegates: [
        //   CountryLocalizations.delegate,
        // ],
        title: 'Movie Example',
        // debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff524f6a),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Authenticate(),
        // AuthScreen(),
        routes: {
          VerifyScreen.routeArgs: (ctx) => VerifyScreen(),
          HomeScreen.routeArgs: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();

    final Stream firebaseUser =
        Provider.of<AuthProvider>(context, listen: false).authState;
    int i = 0;
    firebaseUser.forEach((element) {
      print("firebase user element $i is: $element");
      if (element == null) {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
      print("logged $i : $loggedIn");
      setState(() {});
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loggedIn) {
      print("return home");
      return HomeScreen();
    }

    print("return auth");
    return AuthScreen();
  }
}
