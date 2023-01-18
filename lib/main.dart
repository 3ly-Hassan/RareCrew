import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_crew/core/cache_helper.dart';
import 'package:rare_crew/core/db_helper.dart';
import 'package:rare_crew/core/light_theme.dart';
import 'package:rare_crew/view_models/auth_view_model.dart';
import 'package:rare_crew/view_models/dashboard_view_model.dart';
import 'package:rare_crew/views/auth_view.dart';
import 'package:rare_crew/views/dashboard_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

User? loggedIn;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DBHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  loggedIn = FirebaseAuth.instance.currentUser;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashBoardViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rare Crew',
        theme: getLightTheme(context),
        home: loggedIn != null ? DashBoard() : const AuthScreen(),
      ),
    );
  }
}
