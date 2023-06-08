import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('event').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final events = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;
              final tryValue = event['try']
                  as String?; // Ubah sesuai tipe bidang yang diharapkan
              final try2Value = event['try2']
                  as String?; // Ubah sesuai tipe bidang yang diharapkan

              return ListTile(
                title: Text('Try: $tryValue'),
                subtitle: Text('Try2: $try2Value'),
              );
            },
          );
        },
      ),
    );
  }
}
