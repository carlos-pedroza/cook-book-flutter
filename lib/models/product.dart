class Product {
  String title;
  String imageUrl;
  String description;
  double price;

  Product(this.title, this.imageUrl,this.description, this.price);

  Map<String,String> toMap() {
    return { "title": title, "image_url": imageUrl, "description": description, "price": price.toString() };
  }
}