import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinda_store_controller/shared/bloc_observer.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:kinda_store_controller/styles/themes/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';
import 'layout/store_layout.dart';
import 'local/cache_helper.dart';
import 'modules/Login_screen/login_screen.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token =await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(text: 'تم طلب اوردر جديد', state: ToastState.SUCCESS);
  });
  FirebaseMessaging.onMessage.listen((event) {
    showToast(text: 'تم طلب اوردر جديد', state: ToastState.WARNING);
  });
/*  Future<void> firebaseMessagingBackgroundHandler (RemoteMessage message) async{
   print(message.data.toString());
  }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);*/
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => StoreAppCubit()..getProduct()..getOrders()..getBanners(),
        ),
      ],
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType)=> MaterialApp(
              builder: DevicePreview.appBuilder,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              home: LoginScreen(),
            ),
          );
        },
      ),
    );
  }
}
//  runApp(DevicePreview(builder: (context) =>MyApp()));}
