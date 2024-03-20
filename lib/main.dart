import 'package:better_self/cubit/gunluk_hedefler_cubit.dart';
import 'package:better_self/cubit/ilham_noktasi_cubit.dart';
import 'package:better_self/cubit/pariltili_degisim_cubit.dart';
import 'package:better_self/cubit/zinciri_kirma_cubit.dart';
import 'package:better_self/views/intro_screens/OnBoarding.dart';
import 'package:better_self/views/intro_screens/logo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

int? isViewed;

void main() async {
  
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard') ;

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>IlhamNoktasiCubit()),
        BlocProvider(create: (context)=>PariltiliDegisimCubit()),
        BlocProvider(create: (context)=>GunlukHedeflerCubit()),
        BlocProvider(create: (context)=>ZinciriKirmaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isViewed !=0  ?  OnBoarding() : LogoScreen(),
      ),
    );
  }
}

