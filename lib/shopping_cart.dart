import 'package:flutter/material.dart';


class CartScreen extends StatelessWidget {
  static String id= "cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductCard(
          productName: 'Nike Shoe',
          productPrice: 49.99,
        ),
      ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final double productPrice;

  ProductCard({required this.productName, required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: Text(productName),
            subtitle: Text('\$$productPrice'),
          ),
          Image.asset('assets/shoe.PNG'), // Replace with your product image asset
          ClipRRect(
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80.0),  // Adjust the radius as needed
          topRight: Radius.circular(80.0), // Adjust the radius as needed
          ),
          child:Card(
            elevation: 2,
            color: Colors.white,
            child: SizedBox(
            height: 200,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Add Product details here",
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              Container(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow),
                // Customize other properties as needed
                ),
                onPressed: () {
                // Add your button click logic here
                },
                child: Text(
                'Buy Now',
                style: TextStyle(
                color: Colors.black, // Set text color
                fontSize: 16.0,       // Set text size
                    ),
                  ),
                ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow),
                  // Customize other properties as needed
                ),
                onPressed: () {
                  // Add your button click logic here
                },
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    color: Colors.black, // Set text color
                    fontSize: 16.0,       // Set text size
                  ),
                ),
              ),

            ],
          ),
          ),
          ),
          ),
        ],
    );
  }
}
