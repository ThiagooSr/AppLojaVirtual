import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualapp/models/order.dart';

class AdminOrderManager extends ChangeNotifier{

  List<Order> orders = [];

  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;

  void updateAdmin({bool adminEnable}){
    orders.clear();

    _subscription?.cancel();
    if(adminEnable){
      _listenToOrders();
    }
  }

  void _listenToOrders(){
    _subscription = firestore.collection('orders').snapshots().listen(
            (event) {
              orders.clear();
              for(final doc in event.documents){
                orders.add(Order.fromDocument(doc));
              }
              notifyListeners();
            });
  }

 @override

 void dispose(){
  super.dispose();
  _subscription?.cancel();
 }
}