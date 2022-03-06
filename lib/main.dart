import 'package:flutter/material.dart';
import 'package:golf_app/Pages/EnterScore.dart';
import 'package:golf_app/Pages/SelectGame.dart';
import 'package:golf_app/Pages/SelectTeeBox.dart';
import 'package:golf_app/Pages/ViewMatch.dart';
import 'package:golf_app/Utils/Providers/MatchSetUpProvider.dart';
import 'package:golf_app/Utils/Providers/MatchProvider.dart';
import 'package:golf_app/Utils/TeeBox.dart';
import 'package:provider/provider.dart';
import '/Utils/all.dart';
import '/Pages/all.dart';



Future<void> main() async {

  //WidgetsFlutterBinding.ensureInitialized();

  //await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnnonKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(lightTheme)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        //ChangeNotifierProvider(create: (_) => MatchSetUpProvider()),
        ChangeNotifierProvider(create: (_) => MatchProvider())
      ],
      
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.read<ThemeProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeNotifier.getTheme(),
      initialRoute: '/Home',
      routes: <String, WidgetBuilder>{
        //'/': (_) => const SplashPage(),
        //'/login': (_) => const Login(),
        //'/signUp': (_) => SignUp(),
        '/Home' : (_) => Home(),
        //'/AddPlayers' : (_) => AddPlayers(),
        '/SelectCourse' : (_) => SelectCourse(),
        //'/TeeBox' : (_) => SelectTeeBox(),
       // '/EnterScore' : (_) => EnterScore(),
        //'/SelectGame' : (_) => SelectGame(),
        //'/ViewMatch' : (_) => ViewMatch(),
      }
    );
  }
}

