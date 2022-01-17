import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import '/Utils/all.dart';
import '/Pages/all.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnnonKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(lightTheme)),
        ChangeNotifierProvider(create: (_) => UserProvider())
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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const Login(),
        '/signUp': (_) => SignUp(),
        '/Home' : (_) => Home(),
      }
    );
  }
}

