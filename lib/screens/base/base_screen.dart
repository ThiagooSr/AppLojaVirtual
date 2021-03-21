import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/models/page_manager.dart';
import 'package:lojavirtualapp/models/user_manager.dart';
import 'package:lojavirtualapp/screens/admin_users/admin_users_screen.dart';
//import 'package:lojavirtualapp/screens/base/login/login_screen.dart';
import 'package:lojavirtualapp/screens/base/products/products_screen.dart';
import 'package:lojavirtualapp/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),

              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Meus Pedidos'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('Pedidos'),
                    ),
                  ),
                ]
            ],
          );
        },
      ),
    );
  }
}
