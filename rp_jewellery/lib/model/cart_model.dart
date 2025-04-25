class CartItem {
  final String name;
  final double price;
  final int quantity;
  final String imagePath;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });
}

List<CartItem> cartItems = [
  CartItem(
      name: "Gold Earrings",
      price: 2000,
      quantity: 2,
      imagePath: 'assets/icons/studs.jpg'),
  CartItem(
      name: "Diamond Ring",
      price: 5000,
      quantity: 1,
      imagePath: 'assets/icons/studs.jpg'),
];
