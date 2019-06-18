import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products;
  Uuid uuid;

  List<Product> get products {
    return List.from(_products);
  }

  ProductsModel() {
    _products = [];
    uuid = new Uuid();
    sampleTest();
  }

  void addProduct(Product product) {
    product.id = uuid.v1();
    _products.add(product);
  }

  void updateProduct(Product editProduct) {
    Product product = _products.firstWhere(
        (Product _product) => _product.id == editProduct.id,
        orElse: () => null);
    product.title = editProduct.title;
    product.description = editProduct.description;
    product.imageUrl = editProduct.imageUrl;
    product.price = editProduct.price;
  }

  void deleteProduct(Product product) {
    _products.remove(product);
  }

  Product createProduct({Product product}) {
    if (product == null) {
      return Product(
          id: "",
          title: "",
          description: "",
          imageUrl: "https://picsum.photos/id/237/400/200",
          price: 0.0);
    } else {
      return Product(
          id: product.id,
          title: product.title,
          imageUrl: product.imageUrl,
          description: product.description,
          price: product.price);
    }
  }

  sampleTest() {
    _products.add(Product(
        id: uuid.v1(),
        title: "Pulsera inteligente Xiaomi Mi Band 3, Negro",
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/516SRTkFwbL._SL1000_.jpg",
        description:
            "Capacidad Batería: 110 mAh (8 días en uso continuo), Pantalla táctil: Sí, Bluetooth 4.2, Color Negro, Con un diseño a prueba de agua de hasta 50 metros",
        price: 579.97));
    _products.add(Product(
        id: uuid.v1(),
        title: "Microwave",
        imageUrl: "https://picsum.photos/id/0/500/200",
        description: "LG Silver",
        price: 550));
    _products.add(Product(
        id: uuid.v1(),
        title: "Mercedes Bens",
        imageUrl: "https://picsum.photos/id/0/500/200",
        description: "A8",
        price: 150595.34));
  }
}
