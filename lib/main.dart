import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:girdhari/features/app_lock/app_password_controller.dart';
import 'package:girdhari/features/app_lock/password_screen.dart';
import 'package:girdhari/features/client/controller/client_provider_controller.dart';
import 'package:girdhari/features/expenses/controller/expenses_provider.dart';
import 'package:girdhari/features/expenses/model/expenses_model.dart';
import 'package:girdhari/features/orders/controller/bill_provider.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';
import 'package:girdhari/features/product/provider/product_controller_provider.dart';
import 'package:girdhari/features/product/provider/remove_stock_provider.dart';
import 'package:girdhari/firebase_options.dart';
import 'package:girdhari/features/splash_screen.dart';
import 'package:girdhari/theme/dark_theme.dart';
import 'package:girdhari/theme/light_theme.dart';
import 'package:girdhari/theme/theme_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => RemoveStockProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => SelectedProductProvider()),
        ChangeNotifierProvider(create: (_) => ModifyBillProduct()),
        ChangeNotifierProvider(create: (_) => ClientProviderController()),
        ChangeNotifierProvider(create: (_) => ProductControllerProvider()),
        ChangeNotifierProvider(create: (_) => BillProvider()),
        ChangeNotifierProvider(create: (_) => AppPasswordController()),
        ChangeNotifierProvider(create: (_) => ThemeChangerprovider()),
        StreamProvider<List<ExpensesModel>>(
            create: (_) => ExpensesProvider().fetchExpenses(),
            initialData: const []),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<ThemeChangerprovider>(context);

        return GetMaterialApp(
            title: 'Girdhari',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeChanger.themeMode,
            home: const PasswordScreen());
      }),
    );
  }
}
