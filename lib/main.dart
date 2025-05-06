import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc_base_structure/common/bloc/app_loader/app_loader_cubit.dart';
import 'package:flutter_bloc_base_structure/common/bloc/language_bloc.dart';
import 'package:flutter_bloc_base_structure/config/router/app_router.dart';
import 'package:flutter_bloc_base_structure/core/app_theme.dart';
import 'package:flutter_bloc_base_structure/gen/fonts.gen.dart';
import 'package:flutter_bloc_base_structure/screens/no_Internet_screen/bloc/no_internet_bloc.dart';
import 'package:flutter_bloc_base_structure/service/toastification_service.dart';

import 'common/widget/app_loader.dart';
import 'config/bloc_observer/bloc_observer.dart';
import 'config/di/di/dependency_injector_container.dart';
import 'config/router/app_route_name.dart';
import 'generated/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await DependencyInjectorContainer.init();
  ToastService.init(navigatorKey);
  // Set the status bar icon color to dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // For Android
      statusBarBrightness: Brightness.light, // For iOS
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<NoInternetBloc>(create: (_) => sl()),
            BlocProvider<AppLoaderCubit>(create: (_) => sl()),
            BlocProvider<LanguageBloc>(create: (_) => sl()),
          ],
          child: BlocConsumer<NoInternetBloc, NoInternetState>(
            listener: (context, state) {
              final location =
                  appRouter
                      .routerDelegate
                      .currentConfiguration
                      .last
                      .matchedLocation;

              if (state is ConnectivityDisconnected) {
                if (location != RouteNames.noInternetView &&
                    location != RouteNames.splashView) {
                  ToastService.instance.showError(
                    title: S.of(context).no_internet_connection,
                  );
                  appRouter.pushNamed(RouteNames.noInternetView);
                }
              } else if (state is ConnectivityConnected) {
                if (location == RouteNames.noInternetView) {
                  appRouter.pop();
                }
              }
            },
            builder: (context, state) {
              return BlocBuilder<LanguageBloc, LanguageState>(
                buildWhen:
                    (previous, current) => previous.locale != current.locale,
                builder: (context, state) {
                  return MaterialApp.router(
                    title: "Zoweco",
                    theme: AppTheme.lightAppTheme(
                      fontFamily:
                          state.locale.languageCode == "en"
                              ? FontFamily.montserrat
                              : FontFamily.muktaVaani,
                    ),
                    debugShowCheckedModeBanner: false,
                    locale: state.locale,
                    supportedLocales: S.delegate.supportedLocales,
                    localizationsDelegates: [
                      S.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    routerConfig: appRouter,
                    builder: (context, child) {
                      return BlocBuilder<AppLoaderCubit, bool>(
                        builder: (context, isLoading) {
                          return AppLoader(isLoading: isLoading, child: child);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
