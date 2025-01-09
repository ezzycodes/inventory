import 'package:flutter/material.dart';
import 'package:inventory/screens/dashboard.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      appBar: AppBar(
        title: const Text('Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
                );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

              SizedBox(height: 20.0),
              
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/profile.jpg',),
                  radius: 40.0,
                ),
              ),

              Divider(
                height: 60.0,
                color: Colors.grey[800],
              ),
              
              Text(
                'NAME',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Mr John Doe',
                style:TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30.0),

              Text(
                'PHONE',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),

              SizedBox(height: 10.0),
              Text(
                '011 123 4567',
                style:TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30.0),

              Text(
                'OCCUPATION',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),

              SizedBox(height: 10.0),
              Text(
                'Data Analyst',
                style:TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30.0),

              // Row(
              //   children: <Widget> [
              //     Icon(
              //       Icons.email,
              //       color: Colors.grey[400],
              //     ),
              //     SizedBox(width: 10.0),
              //     Text(
              //       'johndoe@test.co.za',
              //       style: TextStyle(
              //         color: Colors.grey[400],
              //         fontSize: 18.0,
              //         letterSpacing: 1.0,
              //         ),
              //       ),

              //   ],
              // ),

              Divider(
                height: 60.0,
                color: Colors.grey[800],
              ),

              SizedBox(height: 30.0),

            Center(
              child: ElevatedButton(
                onPressed: (){
              
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                ),
                child: Text(
                  'Update Profile',
                  style: TextStyle(
                    color: Colors.white,
                    ),
                  ),
                  ),
                ),

            ],
      ),
    );
  }
}