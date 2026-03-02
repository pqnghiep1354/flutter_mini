class CoffeeModel {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String category;
  final String description;
  final bool isPopular;

  const CoffeeModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.category,
    required this.description,
    this.isPopular = false,
  });
}

class CartItem {
  final CoffeeModel coffee;
  int quantity;
  String size;
  String chocolateType;
  bool isSelected;

  CartItem({
    required this.coffee,
    this.quantity = 1,
    this.size = 'M',
    this.chocolateType = 'Milk Chocolate',
    this.isSelected = true,
  });

  double get totalPrice => coffee.price * quantity;
}

const List<String> coffeeCategories = [
  'Espresso',
  'Latte',
  'Cappuccino',
  'Cafetière',
];

const List<CoffeeModel> sampleCoffees = [
  CoffeeModel(
    id: '1',
    name: 'Cafetière',
    subtitle: 'caffeine latte',
    price: 4.20,
    rating: 4.5,
    reviewCount: 1240,
    imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400&q=80',
    category: 'Espresso',
    description: 'A bold and rich espresso made with the finest coffee beans sourced from Ethiopian highlands. Perfect balance of bitterness and acidity with a velvety crema on top.',
    isPopular: true,
  ),
  CoffeeModel(
    id: '2',
    name: 'Ristretto',
    subtitle: 'short espresso',
    price: 3.80,
    rating: 4.7,
    reviewCount: 890,
    imageUrl: 'https://images.unsplash.com/photo-1521302080334-4bebac2763a6?w=400&q=80',
    category: 'Espresso',
    description: 'A concentrated shot of espresso with a sweeter, more intense flavor than a regular espresso. Made with half the amount of water for a bolder taste.',
    isPopular: false,
  ),
  CoffeeModel(
    id: '3',
    name: 'Macchiato',
    subtitle: 'espresso marked',
    price: 4.50,
    rating: 4.4,
    reviewCount: 670,
    imageUrl: 'https://images.unsplash.com/photo-1485808191679-5f86510bd9d4?w=400&q=80',
    category: 'Espresso',
    description: 'Espresso stained with a small amount of milk foam. A classic Italian drink that balances the intensity of espresso with creamy milk.',
    isPopular: true,
  ),
  CoffeeModel(
    id: '4',
    name: 'Flat White',
    subtitle: 'smooth & creamy',
    price: 4.90,
    rating: 4.6,
    reviewCount: 2100,
    imageUrl: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=400&q=80',
    category: 'Latte',
    description: 'Velvety microfoam milk poured over a rich double ristretto. Stronger than a latte with a silky smooth texture and a higher coffee-to-milk ratio.',
    isPopular: true,
  ),
  CoffeeModel(
    id: '5',
    name: 'Caramel Latte',
    subtitle: 'sweet & smooth',
    price: 5.20,
    rating: 4.8,
    reviewCount: 3400,
    imageUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400&q=80',
    category: 'Latte',
    description: 'Creamy steamed milk with espresso and rich caramel syrup, topped with whipped cream and a generous drizzle of caramel sauce.',
    isPopular: true,
  ),
  CoffeeModel(
    id: '6',
    name: 'Vanilla Latte',
    subtitle: 'light & fragrant',
    price: 5.00,
    rating: 4.5,
    reviewCount: 1850,
    imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&q=80',
    category: 'Latte',
    description: 'Espresso meets warm steamed milk infused with pure Madagascar vanilla. A comforting and aromatic classic for any time of the day.',
    isPopular: false,
  ),
  CoffeeModel(
    id: '7',
    name: 'Cappuccino',
    subtitle: 'foamy & balanced',
    price: 4.40,
    rating: 4.6,
    reviewCount: 2760,
    imageUrl: 'https://images.unsplash.com/photo-1568649929103-28ffbefaca1e?w=400&q=80',
    category: 'Cappuccino',
    description: 'The iconic Italian classic: equal parts espresso, steamed milk, and velvety foam. Dusted with fine cocoa powder for the perfect finish.',
    isPopular: true,
  ),
  CoffeeModel(
    id: '8',
    name: 'Dry Cappuccino',
    subtitle: 'bold & foamy',
    price: 4.20,
    rating: 4.3,
    reviewCount: 580,
    imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&q=80',
    category: 'Cappuccino',
    description: 'Extra foam, less milk. For those who love the boldness of espresso with just a cloud of microfoam on top. Bold, intense, unforgettable.',
    isPopular: false,
  ),
  CoffeeModel(
    id: '9',
    name: 'Irish Coffee',
    subtitle: 'warm & spirited',
    price: 6.80,
    rating: 4.7,
    reviewCount: 940,
    imageUrl: 'https://images.unsplash.com/photo-1504627298434-2a81df87e30d?w=400&q=80',
    category: 'Cafetière',
    description: 'Hot brewed coffee with a touch of brown sugar, topped with thick lightly whipped cream. A warming classic perfect for cold evenings.',
    isPopular: false,
  ),
  CoffeeModel(
    id: '10',
    name: 'Cold Brew',
    subtitle: 'smooth & chilled',
    price: 5.50,
    rating: 4.9,
    reviewCount: 4200,
    imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=400&q=80',
    category: 'Cafetière',
    description: 'Coffee steeped in cold water for 20 hours. Incredibly smooth, naturally sweet with a lower acidity than regular coffee. Served over ice.',
    isPopular: true,
  ),
];
