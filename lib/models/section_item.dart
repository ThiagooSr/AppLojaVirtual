class SectionItem{

  SectionItem({this.product, this.image});

  SectionItem.fromMap(Map<String, dynamic>map){
    image = map['image'] as String;
    product = map['product'] as String;
  }

  String image;
  String product;

  SectionItem clone(){
    return SectionItem(

      product: product,
      image: image,
    );
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}