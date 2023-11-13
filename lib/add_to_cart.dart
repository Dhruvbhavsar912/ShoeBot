import 'package:flutter/material.dart';
import 'package:shoebot/payment.dart';

class AddToCartScreen extends StatelessWidget {
  static String id = "cart";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add to Cart'),
        ),
        body: Column(
          children: [
            Expanded(
              child: CartItemList(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
              onPressed: () {
                // Add your logic to proceed with the purchase
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              child: Text("Buy Now"),
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
  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  List<CartItem> cartItems = [
    CartItem(
      productName: "Air Max+ 2023 'Volt'",
      imageUrl: 'assets/shoe.PNG',
    ),
  ];

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
