import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityCollections {
  final CollectionReference communityCollection;

  CommunityCollections()
      : communityCollection = FirebaseFirestore.instance
            .collection('community')
            .doc('community')
            .collection('community_list');
}
