
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualapp/models/section.dart';

class HomeManager extends ChangeNotifier{

  HomeManager(){
    _loadSelection();
  }

  List<Section> _sections = [];

  List<Section> _editingSections = [];

  bool editing = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSelection() async{
    firestore.collection('home').snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _sections.add(Section.fromDocument(document));

      }
      notifyListeners();
    });


    }
  void addSection(Section section){
    _editingSections.add(section);
    notifyListeners();

  }
  List<Section> get sections{
    if(editing)
      return _editingSections;
    else
      return _sections;
  }

  void enterEditing(){
    editing = true;

    _editingSections = _sections.map((s) => s.clone()).toList();

    notifyListeners();
  }
  void saveEditing(){
    editing = false;
    notifyListeners();
  }
  void discardEditing(){
    editing = false;
    notifyListeners();
  }
}