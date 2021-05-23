import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/common/empty_card.dart';
import 'package:lojavirtualapp/models/admin_orders__manager.dart';
import 'package:lojavirtualapp/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
    drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Todos os Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrderManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.orders.isEmpty){
            return EmptyCard(
              title: 'Nenhuma venda realizada!',
              iconData:  Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(
                  ordersManager.orders.reversed.toList()[index]
                );
              }
              );
        }
      ),
    );
  }

}