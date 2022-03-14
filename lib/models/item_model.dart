class Item {
  String name;
  int qty;
  double price;
  Item({
    required this.name,
    required this.qty,
    required this.price,
  });
  List<String> toList() => [
        name,
        "$qty",
        "\$${price.toStringAsFixed(2)}",
        ((price * qty).toStringAsFixed(2))
      ];
}
