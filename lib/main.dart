import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/bindings/root_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/utils.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const double maxMobileWidth = 600.0;

    return ScreenUtilInit(
      designSize: const Size(440, 956),
      splitScreenMode: true,
      builder: (context, child) {
        if (!AppSizes.isInitialized) {
          AppSizes.initialize(context);
        }

        return GetMaterialApp(
          title: 'Bea',
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          initialBinding: RootBinding(),
          getPages: AppPages.routes,
          theme: GlobalAppTheme.lighttheme,
          darkTheme: GlobalAppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: TextScaler.linear(1.0)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isTablet = constraints.maxWidth > maxMobileWidth;
                  return Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? maxMobileWidth : double.infinity,
                      ),
                      child: child!,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
