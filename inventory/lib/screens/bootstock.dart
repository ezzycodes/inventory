import 'package:flutter/material.dart';
import 'package:inventory/screens/checkout.dart';

class StockItem{
   String name;
  int quantity;
  Image image;
  int inCart;

  StockItem({required this.name, required this.quantity,required this.image, this.inCart = 0 });
}

class BootStock extends StatefulWidget {
  const BootStock({super.key});

  @override
  State<BootStock> createState() => _BootStock();
}

class _BootStock extends State<BootStock> {

   List<StockItem> stockList = [
      StockItem(name: "Shelly Plug", quantity: 20, image:Image.asset("assets/images/shelly.jpg")),
      StockItem(name: "Janus Coupler", quantity: 20, image:Image.asset("assets/images/janus.jpg")),
      StockItem(name: "Plug Top", quantity: 10, image:Image.asset("assets/images/plugtop.png")),
      StockItem(name: "Transend 120GB SSD", quantity: 10, image:Image.asset("assets/images/transcend120.png")),
      StockItem(name: "Samsung NVMe 250GB", quantity: 10, image:Image.asset("assets/images/samsung250.jpg")),
      StockItem(name: "CMOS Battery", quantity: 10, image:Image.asset("assets/images/cmos.jpg")),
    ];

    int get totalCartItems {
    return stockList.fold(0, (sum, item) => sum + item.inCart);
  }

  void addToCart(StockItem item) {
    setState(() {
      if (item.quantity > 0) {
        item.quantity--;
        item.inCart++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No more stock available for ${item.name}")),
        );
      }
    });
  }

  void removeFromCart(StockItem item) {
    setState(() {
      if (item.inCart > 0) {
        item.inCart--;
        item.quantity++;
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No more stock available for ${item.name}")),
        );
      }

    });
  }

  void assignToJob() {
    setState(() {
      for (var item in stockList) {
        item.inCart = 0; // Clear the cart
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Stock assigned to the job!")),
    );
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Stock List",
            style: TextStyle(color: Colors.blue),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded,
              color: Colors.blue,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_bag,
                color: Colors.blue,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        cartItems: stockList
                        .where((item) => item.inCart > 0)
                        .map((item) => {'name': item.name, 'quantity': item.inCart})
                        .toList(),
                      ),
                    ),
                  );
                },
                //onPressed: totalCartItems > 0 ? assignToJob : null,
              ),
              if (totalCartItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      "$totalCartItems",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
      ),
      body: ListView.builder(
        itemCount: stockList.length, // Number of items
        itemBuilder: (context, index) {
          final item = stockList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            
            child: Card(
              
              child: Row(

                children: [
                  // Image Section

                  SizedBox(width:10),
                  Container(
                    width: 80, // Adjust as needed
                    height: 80, // Placeholder image
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Image(image: stockList[index].image.image, ),
                  ),

                  SizedBox(width: 40,),
                  // Text and Buttons Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //'Label',
                            (stockList[index].name),
                            style: TextStyle(fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0,),
                          Text(
                            //Quantity
                            (stockList[index].quantity.toString()),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Buttons Section
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: () => addToCart(item),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.blue,
                        onPressed: () => removeFromCart(item),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
