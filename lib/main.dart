import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:lojavirtualapp/models/admin_users_manager.dart';
import 'package:lojavirtualapp/models/cart_manager.dart';
import 'package:lojavirtualapp/models/home_manager.dart';
import 'package:lojavirtualapp/models/product.dart';
import 'package:lojavirtualapp/models/product_manager.dart';
//import 'package:lojavirtualapp/models/user.dart';
import 'package:lojavirtualapp/models/user_manager.dart';
import 'package:lojavirtualapp/screens/base/base_screen.dart';
import 'package:lojavirtualapp/screens/base/login/login_screen.dart';
import 'package:lojavirtualapp/screens/base/signup/signup_screen.dart';
import 'package:lojavirtualapp/screens/cart/cart_screen.dart';
import 'package:lojavirtualapp/screens/edit_product/edit_product_screen.dart';
import 'package:lojavirtualapp/screens/product/product_screen.dart';
import 'package:provider/provider.dart';
//import 'package:provider/p';

void main() async {
  runApp(MyApp());

  DocumentSnapshot document =
      await Firestore.instance.collection('pedidos').document('Thiago').get();

  print(document.data);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create:(_) => UserManager(),
             lazy: false,
    ),
          ChangeNotifierProvider(
             create: (_) => ProductManager(),
            lazy: false,

    ),
          ChangeNotifierProvider(
              create: (_) => HomeManager(),
               lazy: false,
          ),
          ChangeNotifierProxyProvider<UserManager, CartManager>(
              create: (_) => CartManager(),
            lazy: false,
            update: (_, userManager, cartManager) =>
            cartManager..updateUser(userManager),
          ),
          ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
              create: (_) => AdminUsersManager(),
            lazy: false,
            update: (_, userManager, adminUsersManager) =>
            adminUsersManager..updateUser(userManager),
          )
        ],

    child: MaterialApp(
      title: 'Loja do Thiago',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 4, 125, 141),
        scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
        appBarTheme: const AppBarTheme(elevation: 0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/base',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/base':
            return MaterialPageRoute(builder: (_) => BaseScreen());
          case '/cart':
            return MaterialPageRoute(builder: (_) => CartScreen());
          case '/product':
            return MaterialPageRoute(builder: (_) => ProductScreen(
              settings.arguments as Product
            ));
          case '/edit_product':
            return MaterialPageRoute(builder: (_) => EditProductScreen(
              settings.arguments as Product

            ));
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignUpScreen());
          default:
            return MaterialPageRoute(builder: (_) => BaseScreen());
        }
      },
    ),
    );
  }
}
