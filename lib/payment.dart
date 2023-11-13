import 'package:flutter/material.dart';


class PaymentPage extends StatelessWidget {
  static String id = "pay";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home:Scaffold(
        appBar: AppBar(
          title: Text("Payment"),
        ),
      body:SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Amount: \$499.00",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Payment Information",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Card Number"),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Expiry Date"),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "CVV"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle payment logic here
                        },
                        child: Text("Pay"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    ),
    );
  }
}