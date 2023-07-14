import 'package:newtest/module/home/controller.dart';
import 'package:newtest/module/home/model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DateSelectionPage extends StatelessWidget {
  final JadwalKegiatanController controller = JadwalKegiatanController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Rentang Tanggal')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final selectedDates = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now(),
              );

              if (selectedDates != null) {
                final startDate = selectedDates.start;
                final endDate = selectedDates.end;

                // Langkah 3: Buat query ke Firebase Firestore
                final QuerySnapshot snapshot = await FirebaseFirestore.instance
                    .collection('event')
                    .where('createdDate', isGreaterThanOrEqualTo: startDate)
                    .where('createdDate', isLessThanOrEqualTo: endDate)
                    .get();

                final List<JadwalKegiatan> fetchedEvents = snapshot.docs
                    .map((doc) => JadwalKegiatan.fromJson(
                        doc.data() as Map<String, dynamic>))
                    .toList();

                if (fetchedEvents.isEmpty) {
                  // Kasus ketika tidak ada data yang sesuai dengan tanggal yang dipilih
                  print('Data kosong');
                } else {
                  // Kasus ketika ada data yang sesuai dengan tanggal yang dipilih
                  controller.dateList.value = fetchedEvents;
                  print('data ada');
                }
              }
            },
            child: Text('Pilih Tanggal'),
          ),
          Obx(
            () => Text('Total Data ${controller.dateList.length.toString()}'),
          ),
          Obx(() => EventListView(events: controller.dateList.value))
        ],
      ),
    );
  }
}

// Langkah 4: Tampilkan data di ListViewBuilder
class EventListView extends StatelessWidget {
  final List<JadwalKegiatan> events;

  const EventListView({required this.events});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final jadwal = events[index];
          return ListTile(
            title: Text(jadwal.tryValue1),
            subtitle: Text(jadwal.tryValue2),
          );
        },
      ),
    );
  }
}
