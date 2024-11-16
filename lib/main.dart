import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/Utils/Route/routes.dart';
import 'package:mblog/View_Model/visibility.dart';
import 'package:mblog/view/Splash_View.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> PassVisibility()),
        ],
      child: Builder(builder: (BuildContext context){
        return  MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // appBarTheme: AppBarTheme(
              //   color: Color(0xff7AB2D3)
              // ),
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff7AB2D3)),
              useMaterial3: true,
            ),
            initialRoute: RouteName.navbar,
            onGenerateRoute: Routes.onGenerateRoute
        );
      }),
    );

  }
}

