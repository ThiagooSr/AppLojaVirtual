import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/models/home_manager.dart';
import 'package:lojavirtualapp/models/user_manager.dart';
import 'package:lojavirtualapp/screens/home/components/section_list.dart';
import 'package:provider/provider.dart';

import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168),
               ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Thiago'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __){
                      if(userManager.adminEnabled) {
                        if(homeManager.editing){
                           return PopupMenuButton(
                             onSelected: (e){
                               if(e == 'Salvar'){
                                  homeManager.saveEditing();
                               }else{
                                  homeManager.discardEditing();
                               }
                             },
                               itemBuilder:(_){
                                return ['Salvar', 'Descartar'].map((e) {
                                  return PopupMenuItem(
                                      value: e,
                                      child: Text(e),
                                  );
                                }).toList();
                               }
                               );
                        }else {
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: homeManager.enterEditing,


                          );
                        }
                      }else return Container();
                    },
                  )
                ],
              ),
              Consumer<HomeManager>(
                  builder: (_, homeManager, __){
                    final List<Widget> children = homeManager.sections.
                    map<Widget>((section) {
                      switch(section.type){
                        case 'List' :
                          return SectionList(section);
                        case 'Staggered' :
                          return SectionStaggered(section);
                          default:
                      return Container();
                      }

                    }
                    ).toList();

                    if(homeManager.editing)
                      children.add(AddSectionWidget());
                    return SliverList(
                        delegate: SliverChildListDelegate(children),
                    );
                  }

              )
            ],
          ),
        ],
      ),

    );
  }
}