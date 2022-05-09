import 'package:tradelait/deposits/screens/deposit_list_screen.dart';
import 'package:tradelait/res/second_custom_colours.dart';
import 'package:tradelait/screens/splash_screen/splash_screen.dart';
import 'package:tradelait/brokers/screens/broker_list_screen.dart';
import 'package:tradelait/users/screens/user_profile_screen.dart';
import 'package:flutter/services.dart';
//import 'package:linkfive_purchases/logic/linkfive_purchases.dart';
import 'package:linkfive_purchases_provider/linkfive_purchases_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'services/auth/auth.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /* LinkFivePurchases.init(
      "250d71fae89726e33502171228e714f12bc1e6221a1b3c70dea5d279890dc33c"); */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //PaymentService paymentService = PaymentService();
    //BrokerService BrokerService = BrokerService();
    AuthService authService = AuthService();
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => authService,
        ),

        ChangeNotifierProvider(
          create: (context) => LinkFiveProvider(
              "250d71fae89726e33502171228e714f12bc1e6221a1b3c70dea5d279890dc33c"),
          lazy: false,
        ),

        //StreamProvider<PaymentModel>.value(initialData: [],  value: paymentService.streamPaymentsList()),
      ],
      child: MaterialApp(
        title: 'tradelait - School Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette2.custom,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'brokers': (context) => brokerListScreen(),
          'deposits': (context) => DepositListScreen(),
          'account': (context) => UserProfileScreen(),
        },
      ),
    );
  }
}
