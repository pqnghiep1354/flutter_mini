class CoffeeModel {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;

  CoffeeModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
  });
}

class CartItemModel {
  final CoffeeModel coffee;
  int quantity;
  bool isSelected;

  CartItemModel({
    required this.coffee,
    this.quantity = 1,
    this.isSelected = true,
  });
}

// Sample data
final List<CoffeeModel> sampleCoffees = [
  CoffeeModel(
    id: '1',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.5,
    imageUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=300',
    category: 'Espresso',
  ),
  CoffeeModel(
    id: '2',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.6,
    imageUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=300',
    category: 'Espresso',
  ),
  CoffeeModel(
    id: '3',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.5,
    imageUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=300',
    category: 'Latte',
  ),
  CoffeeModel(
    id: '4',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.5,
    imageUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=300',
    category: 'Cappuccino',
  ),
  CoffeeModel(
    id: '5',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.6,
    imageUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=300',
    category: 'Espresso',
  ),
  CoffeeModel(
    id: '6',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.5,
    imageUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=300',
    category: 'Espresso',
  ),
];
