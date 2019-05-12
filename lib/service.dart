class Service {
  List<String> GetProducts() {
    List<String> list = [];

    for(var i=1; i<100000; i++) {
      list.add(i.toString());
    }

    return list;
  }
}