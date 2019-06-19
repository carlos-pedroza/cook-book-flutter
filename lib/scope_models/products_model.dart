import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products;
  Uuid uuid;
  bool isFilterFavorite = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get mainProducts {
    return !isFilterFavorite
        ? List.from(_products)
        : List.from(_products.where((p) => p.isFavorite));
  }

  Product get(String _id) {
    return _products.firstWhere((Product _product) => _product.id == _id,
        orElse: () => null);
  }

  ProductsModel() {
    _products = [];
    uuid = new Uuid();
    sampleTest();
  }

  void add(Product product) {
    product.id = uuid.v1();
    _products.add(product);
  }

  void update(Product editProduct) {
    Product product = _products.firstWhere(
        (Product _product) => _product.id == editProduct.id,
        orElse: () => null);
    product.title = editProduct.title;
    product.description = editProduct.description;
    product.imageUrl = editProduct.imageUrl;
    product.price = editProduct.price;
  }

  void delete(String _id) {
    Product product =
        _products.firstWhere((Product p) => p.id == _id, orElse: () => null);
    if (product != null) {
      _products.remove(product);
    }
  }

  Product create({Product product}) {
    if (product == null) {
      String productImage =
          "https://images-na.ssl-images-amazon.com/images/I/81fdRep8ucL._SL1500_.jpg";
      return Product(
          id: "",
          title: "",
          description: "",
          imageUrl: productImage,
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

  toggleFavorite(String _id) {
    Product product =
        _products.firstWhere((Product p) => p.id == _id, orElse: () => null);
    product.isFavorite = !product.isFavorite;
  }

  toggleFilterFavorite() {
    isFilterFavorite = !isFilterFavorite;
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
