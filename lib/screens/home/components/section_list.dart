import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lojavirtualapp/models/section.dart';
import 'package:lojavirtualapp/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {

  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
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
                return AspectRatio(
                  aspectRatio: 1,
                    child: Image.network(section.items[index].image,
                      fit: BoxFit.cover,

                    )
                );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 4,),
                itemCount: section.items.length),
          )
        ],
      ),
    );
  }
}