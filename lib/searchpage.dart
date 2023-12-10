import 'package:flutter/material.dart';
import 'package:shoebot/add_to_cart.dart';
import 'package:shoebot/product_details.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final double rating;
  final double discount;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.discount,
  });
}

class MySearchApp extends StatelessWidget {
  static String id = "searchapp";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Page',
      theme: ThemeData.dark(),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', image: 'assets/shoe.PNG', price: 19.99, rating: 4.5, discount: 10),
    Product(name: 'Product 2', image: 'assets/shoe10.PNG', price: 29.99, rating: 3.8, discount: 5),
    Product(name: 'Product 3', image: 'assets/shoe8.PNG', price: 49.99, rating: 4.2, discount: 15),
    Product(name: 'Product 4', image: 'assets/shoe9.PNG', price: 59.99, rating: 4.0, discount: 8),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
        actions: <Widget>[
          Stack(
            children: [
              // Add to Cart Icon
              // IconButton(
              //   icon: Icon(Icons.shopping_cart),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AddToCartScreen()),
              //     );
              //   },
              // ),
              // Cart Item Count
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tapped on ${product.name}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen(product.name,product.price,product.rating,product.discount,product.image)),
        );
      },
      child: Card(
        elevation: 4.0,
        color: Colors.white.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '\$${calculateDiscountedPrice(product.price, product.discount).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14.0, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      Text(
                        '${product.rating}',
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateDiscountedPrice(double originalPrice, double discountPercentage) {
    double discountedPrice = originalPrice - (originalPrice * (discountPercentage / 100));
    return discountedPrice;
  }
}