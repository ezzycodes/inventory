import 'package:flutter/material.dart';
import 'package:inventory/screens/bootstock.dart';
import 'package:inventory/screens/history.dart';
import 'package:inventory/screens/profile.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Dashboard',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.person,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
                );
            },
          ),

          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.blue,
                ),
                onPressed: () {},
              ),
            ],

        ),
        
        body: Column(
          children: [
            SizedBox(height: 20),
              Text('Welcome \$user',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
                
            SizedBox(height: 20),
            Image.asset(
                'assets/images/inventory.jpg',
                height: 300,
                ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>BootStock()),
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Boot Stock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

            // SizedBox(height: 40),

            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue,
            //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ), 
            //   child: Text('Repairs',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //     ),
            //   ),
            //   ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>HistoryPage()),
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ), 
              child: Text('Records',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              ),

            ],
          ),
      ),
    );
  }

}