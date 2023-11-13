import 'package:flutter/material.dart';
import 'package:shoebot/add_to_cart.dart';


class ProductScreen extends StatelessWidget {
  static String id= "product";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions:<Widget>[
          Stack(
            children: [
              // Add to Cart Icon
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddToCartScreen()),
                  );
                },
              ),
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
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductCard(
          productName: "Air Max+ 2023 'Volt'",
          productPrice: 499.99,
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
    return SingleChildScrollView(
        child: Column(
        children: <Widget>[
          ListTile(
            title: Text(productName),
            subtitle: Text('C \$$productPrice'),

          ),
          Image.asset('assets/shoe.PNG'), // Replace with your product image asset
          SingleChildScrollView(
            child: ClipRRect(
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80.0),  // Adjust the radius as needed
          topRight: Radius.circular(80.0), // Adjust the radius as needed
          ),
          child:Card(
            elevation: 10,
            color: Colors.white,
            child: SizedBox(
            height: 300,
            width: 800,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(25.0),
              child : Text(
                "The Air Max+ 2013 is known for its distinctive and eye-catching design. The 'Volt' colorway features a bright neon yellow-green shade known as 'Volt,' which is a signature color for Nike. The shoe typically features a combination of synthetic materials and mesh on the upper for breathability and support. It includes Nike's Air Max technology in the sole, providing responsive cushioning and impact protection. The black accents and Nike Swoosh complement the vibrant Volt color, giving it a bold and sporty look.",
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
    /*      ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow),
                // Customize other properties as needed
                ),
                onPressed: () {
                // Add your button click logic here
                  Navigator.pushNamed(context, AddToCartScreen.id);
                },
                child: Text(
                'Buy Now',
                style: TextStyle(
                color: Colors.black, // Set text color
                fontSize: 16.0,       // Set text size
                    ),
                  ),
                ),*/
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow),
                  // Customize other properties as needed
                ),
                onPressed: () {
                  // Add your button click logic here
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddToCartScreen()),
                  );
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

            ],
          ),
          ),
          ),
          ),
          ),
        ],
        ),
    );
  }
}
