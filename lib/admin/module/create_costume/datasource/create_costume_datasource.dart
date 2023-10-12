import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  final CollectionReference listBrandCollection;
  final CollectionReference listCategoryCollection;
  final CollectionReference listCharackterCollection;
  final CollectionReference listCharackterNameCollection;
  final CollectionReference listCostumeCollection;
  final CollectionReference costumeListCollection;

  FirestoreCollections()
      : listBrandCollection = FirebaseFirestore.instance
            .collection('costume')
            .doc('brand')
            .collection('list_brand'),
        listCategoryCollection = FirebaseFirestore.instance
            .collection('costume')
            .doc('category')
            .collection('list_category'),
        listCharackterCollection = FirebaseFirestore.instance
            .collection('costume')
            .doc('charackter')
            .collection('charackter_origin'),
        listCharackterNameCollection = FirebaseFirestore.instance
            .collection('costume')
            .doc('charackter')
            .collection('charackter_name'),
        listCostumeCollection = FirebaseFirestore.instance
            .collection('costume')
            .doc('costume')
            .collection('list_costume'),
        costumeListCollection = FirebaseFirestore.instance
            .collection('costume')
            .doc('costume')
            .collection('list_costume');
}
