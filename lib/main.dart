import 'package:feelin/locator.dart';
import 'package:feelin/ui/view/home_view.dart';
import 'package:feelin/ui/view/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Make sure the App looks good on every device
    return ScreenUtilInit(
      designSize: const Size(360,592),
      builder: () {
        return GetMaterialApp(
          title: 'Feelin',
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(
              name: '/',
              page: () => const StartUpView()
            ),
            GetPage(
                name: '/home',
                page: () => const HomeView()
            )
          ],
          initialRoute: '/',
          theme: ThemeData(
            fontFamily: 'Roboto',
            primarySwatch: Colors.orange
          ),
        );
      }
    );
  }
}