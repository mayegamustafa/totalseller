import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:seller_management/features/payment/view/web_view_page.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_config.dart';
import 'package:seller_management/routes/go_route_name.dart';

import 'features/settings/controller/settings_ctrl.dart';

Future<void> _initFirebase() async {
  await FireMessage.initiateWithFirebase();
  LNService.initialize();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PaymentBrowser.setupBrowser();

  // Endpoints.testURL = 'http://192.168.0.107/InHouse/cartuser/v2.1';

  await configureDependencies();

  FileDownloader().configureNotification(
    running: const TaskNotification('Downloading', 'file: {filename}'),
    complete: const TaskNotification('Download finished', 'file: {filename}'),
    error: const TaskNotification('Download error', 'file: {filename}'),
    progressBar: true,
    tapOpensFile: true,
  );

  ///* To enable FIREBASE, change the value to true;
  FireMessage.isFireActive = true;
  await _initFirebase();

  if (kDebugMode) HttpOverrides.global = MyHttpOverrides();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(goRoutesProvider);
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    useEffect(() {
      return null;
    }, [locale]);

    return _EagerInitialization(
      child: RefreshConfiguration(
        headerBuilder: () => WaterDropHeader(
          waterDropColor: context.colors.primary,
        ),
        footerBuilder: () => const ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          loadingText: '',
          noDataText: 'No more messages',
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppDefaults.appName,
          themeMode: mode,
          theme: AppTheme.theme(true),
          darkTheme: AppTheme.theme(false),
          routerConfig: routes,
          locale: locale,
          supportedLocales: TR.delegate.supportedLocales,
          localizationsDelegates: const [
            TR.delegate,
            FormBuilderLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
        ),
      ),
    );
  }
}

class _EagerInitialization extends HookConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //!
    ref.watch(settingsCtrlProvider);
    //!

    EventStreamer eventStream() {
      final eventStreamer = locate<EventStreamer>();
      eventStreamer.stream.listen(
        (event) {
          if (event.type == 'onBanned') {
            RouteNames.sellerBanned.goNamed(context);
            return;
          }
          if (event.type == 'server_status') {
            final code = event.payload?['code'];

            final statusCtrl = ref.read(serverStatusProvider.notifier);
            statusCtrl.update(code);
            return;
          }
        },
      );
      return eventStreamer;
    }

    useEffect(
      () {
        final eventStreamer = eventStream();
        return () => eventStreamer.dispose();
      },
      const [],
    );
    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
