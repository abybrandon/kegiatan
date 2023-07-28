import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventListPage extends StatelessWidget {
  final String eventId;

  EventListPage({required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event List')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .doc(eventId)
            .collection('eventList')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Jika data berhasil didapatkan dari snapshot
          if (snapshot.hasData) {
            final eventListDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: eventListDocs.length,
              itemBuilder: (context, index) {
                final eventData =
                    eventListDocs[index].data() as Map<String, dynamic>;
                final eventName = eventData['nameEvent'];
                return ListTile(
                  title: Text(eventName),
                );
              },
            );
          }

          return Text('No data available');
        },
      ),
    );
  }
}
