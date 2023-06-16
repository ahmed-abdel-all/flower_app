class Item {
  String imagePath;
  double price;
  String location;
  String name;

  Item({
    required this.imagePath,
    required this.price,
    required this.name,
    this.location = "Main Branch",
  });


}

List<Item> items = [
  Item(
      name: 'Product 1',
      imagePath: 'assets/images/1.webp',
      price: 12.99,
      location: 'Flower Shop'),
  Item(
      name: 'Product 2',
      imagePath: 'assets/images/3.webp',
      price: 30.99,
      location: 'ElZahraa Shop'),
  Item(name: 'Product 3', imagePath: 'assets/images/4.webp', price: 12.99),
  Item(
      name: 'Product 4',
      imagePath: 'assets/images/5.webp',
      price: 11.99,
      location: 'Saoq Shop'),
  Item(name: 'Product 5', imagePath: 'assets/images/6.webp', price: 32.99),
  Item(
      name: 'Product 6',
      imagePath: 'assets/images/7.webp',
      price: 26.99,
      location: 'Flower Shop'),
  Item(name: 'Product 7', imagePath: 'assets/images/8.webp', price: 33.99),
  Item(
      name: 'Product 8',
      imagePath: 'assets/images/2.webp',
      price: 40.99,
      location: 'Ahmed Shop'),
];
