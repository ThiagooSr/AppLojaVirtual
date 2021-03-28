import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lojavirtualapp/models/home_manager.dart';
import 'package:lojavirtualapp/models/section.dart';
import 'package:lojavirtualapp/screens/home/components/add_tile_widget.dart';
import 'package:lojavirtualapp/screens/home/components/item_tile.dart';
import 'package:lojavirtualapp/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {

  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
                itemBuilder: (_, index){
                if (index < section.items.length)
                return ItemTile(section.items[index]);
                else
                  return AddTileWidget(section);
                },
                separatorBuilder: (_, __) => const SizedBox(width: 4,),
                itemCount: homeManager.editing
                    ? section.items.length + 1
                    : section.items.length,

            ),
          )
        ],
      ),
    );
  }
}