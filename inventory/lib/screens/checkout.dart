import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:intl/intl.dart';
import 'package:inventory/screens/dashboard.dart';
import 'package:inventory/database/database_helper.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ticketController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final _signatureKey = GlobalKey<SignatureState>();
  ByteData? _signatureData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout",
          style: TextStyle(color: Colors.blue),
          ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.blue,
        ),

        actions: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                },
              ),
            ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Summary
                ...widget.cartItems.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${item['name']} - Quantity: ${item['quantity']}",
                        style: TextStyle(fontSize: 16),
                      ),
                    )),
                SizedBox(height: 16),

                // Timestamp
                Text("Date: ${DateFormat.yMd().add_jm().format(DateTime.now())}"),
                SizedBox(height: 16),

                // Ticket Number
                TextFormField(
                  controller: _ticketController,
                  decoration: InputDecoration(
                    labelText: "Ticket/Job Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a ticket number.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Recipient Name
                TextFormField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    labelText: "Recipient Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the recipient's name.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Signature Pad
                Text("Sign Below:"),
                SizedBox(height: 8),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Signature(
    key: _signatureKey,
    color: Colors.black,
    onSign: () async {
      final image = await _signatureKey.currentState?.getData();
      if (image != null) {
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        setState(() {
          _signatureData = byteData;
        });
      }
    },
  ),
                ),
                TextButton(
                  child: Text("Clear"),
                  onPressed: () => _signatureKey.currentState?.clear(),
                ),
                SizedBox(height: 16),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Submit"),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (_signatureData == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please provide your signature.")),
                  );
                return;
              }

            final log = {
              'ticketNumber': _ticketController.text,
              'recipient': _recipientController.text,
              'timestamp': DateTime.now().toIso8601String(),
              'products': jsonEncode(widget.cartItems),
              'signature': _signatureData!.buffer.asUint8List(), // Save signature as a blob
          };

          await DatabaseHelper().insertLog(log);

          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Stock successfully assigned!")),
          );

          Navigator.pop(context);
        }
      }

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
