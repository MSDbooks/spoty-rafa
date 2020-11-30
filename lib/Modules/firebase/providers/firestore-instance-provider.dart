import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstanceProvider {

  final Firestore firestore = Firestore();

  static FirestoreInstanceProvider _instanceSingleton;

  factory FirestoreInstanceProvider() {
    _instanceSingleton ??= FirestoreInstanceProvider._internalConstructor();

    return _instanceSingleton;
  }

  FirestoreInstanceProvider._internalConstructor();

}