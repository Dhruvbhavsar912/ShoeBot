import 'package:flutter/material.dart';
import 'package:shoebot/payment.dart';

class AddToCartScreen extends StatelessWidget {
  static String id = "cart";

  final double price,discount;
  final String name, image;

  AddToCartScreen(this.name, this.price, this.image,this.discount);

  @override
  Widget build(BuildContext context) {
    double discountedPrice = price - (price * (discount / 100));
    String dp = discountedPrice.toStringAsFixed(2);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add to Cart'),
        ),
        body: Column(
          children: [
            Expanded(
              child: CartItemList(
                name: name,
                price: price,
                image: image,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add your logic to proceed with the purchase
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage(dp)),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Buy Now:  " + "$dp",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String productName;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.productName,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartItemList extends StatefulWidget {
  final double price;
  final String name, image;

  CartItemList({required this.name, required this.price, required this.image});

  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize cartItems with the provided parameters
    cartItems.add(
      CartItem(
        productName: widget.name,
        imageUrl: widget.image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Image.asset(
              item.imageUrl,
              width: 100,
              height: 100,
            ),
            title: Text(item.productName),
            subtitle: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (item.quantity > 1) {
                      setState(() {
                        item.quantity--;
                      });
                    }
                  },
                ),
                Text(item.quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      item.quantity++;
                    });
                  },
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  cartItems.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }
}