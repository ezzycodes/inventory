import 'dart:convert';

import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: FutureBuilder(
        future: DatabaseHelper().getLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null || (snapshot.data as List).isEmpty) {
            return Center(child: Text("No logs found."));
          }

          final logs = snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              final products = List<Map<String, dynamic>>.from(jsonDecode(log['products']));
              return ListTile(
                title: Text("Ticket: ${log['ticketNumber']}"),
                subtitle: Text("Recipient: ${log['recipient']}\nDate: ${log['timestamp']}"),
                onTap: () {
                  // Show detailed log info
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Log Details"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ticket: ${log['ticketNumber']}"),
                          Text("Recipient: ${log['recipient']}"),
                          Text("Timestamp: ${log['timestamp']}"),
                          Text("Products:"),
                          ...products.map((p) => Text("- ${p['name']}: ${p['quantity']}")),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
