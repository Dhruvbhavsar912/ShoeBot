import 'package:flutter/material.dart';
import 'package:shoebot/add_to_cart.dart';

class ProductScreen extends StatelessWidget {
  static String id = "product";

  double price,rating,discount;
  String name,image;
  

  ProductScreen(this.name,this.price,this.rating,this.discount,this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: <Widget>[
          Stack(
            children: [
              // Add to Cart Icon
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddToCartScreen(name,price,image,discount)),
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
            productName: name,
            productPrice: price,
            productRating: rating,
            productDiscount: discount,
            productimage : image,
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final double productPrice;
  final double productRating;
  final double productDiscount;
  final String productimage;

  ProductCard({
    required this.productName,
    required this.productPrice,
    required this.productRating,
    required this.productDiscount,
    required this.productimage,
  });

  @override
  Widget build(BuildContext context) {
    double discountedPrice = productPrice - (productPrice * (productDiscount / 100));
    String dp = discountedPrice.toStringAsFixed(2);

    return Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            title: Text(
              productName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'C \$$productPrice',
                  style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough),
                ),
                Text(
                  '$dp',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Custom widget to display stars based on product rating
                        StarRating(rating: productRating),
                        SizedBox(width: 4),
                        Text(
                          '${productRating.toStringAsFixed(1)}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),

          ),
          Image.asset(
            productimage,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "The Air Max+ 2013 is known for its distinctive and eye-catching design. The 'Volt' colorway features a bright neon yellow-green shade known as 'Volt,' which is a signature color for Nike. The shoe typically features a combination of synthetic materials and mesh on the upper for breathability and support. It includes Nike's Air Max technology in the sole, providing responsive cushioning and impact protection. The black accents and Nike Swoosh complement the vibrant Volt color, giving it a bold and sporty look.",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your button click logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToCartScreen(productName,productPrice,productimage, productDiscount)),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                ),
                SizedBox(height: 8),
                // Dropdown to show all reviews
                ReviewDropdown(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class ReviewDropdown extends StatefulWidget {
  @override
  _ReviewDropdownState createState() => _ReviewDropdownState();
}

class _ReviewDropdownState extends State<ReviewDropdown> {
  List<ReviewCard> reviews = [
    ReviewCard(author: 'Dhruv Bhavsar', rating: 5.0, comment: 'Great shoes!'),
    ReviewCard(author: 'Kartik Nair', rating: 4.0, comment: 'Comfortable and stylish.'),
  ];

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(isExpanded ? 'Hide Reviews' : 'Show Reviews'),
        ),
        if (isExpanded)
          Column(
            children: reviews.map((review) => review).toList(),
          ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String author;
  final double rating;
  final String comment;

  ReviewCard({required this.author, required this.rating, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Row(
          children: [
            StarRating(rating: rating),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(author, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(comment),
          ],
        ),
      ),
    );
  }
}


class StarRating extends StatelessWidget {
  final double rating;
  final int starCount = 5; // Number of stars in the rating

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    int filledStars = rating.floor();
    double remainingStar = rating - filledStars;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        Icon starIcon;
        if (index < filledStars) {
          starIcon = Icon(Icons.star, color: Colors.yellow);
        } else if (index == filledStars && remainingStar > 0) {
          starIcon = Icon(Icons.star_half, color: Colors.yellow);
        } else {
          starIcon = Icon(Icons.star_border, color: Colors.yellow);
        }

        return starIcon;
      }),
    );
  }
}
