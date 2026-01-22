import 'package:cloud_firestore/cloud_firestore.dart';

/// Provides basic CRUD operations for a Firestore collection.
class FirebaseService {
  FirebaseService(this.collectionPath);

  final String collectionPath;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create a new document in the collection.
  Future<DocumentReference<Map<String, dynamic>>> create(Map<String, dynamic> data) {
    return _db.collection(collectionPath).add(data);
  }

  /// Read all documents from the collection as a stream.
  Stream<QuerySnapshot<Map<String, dynamic>>> readAll() {
    return _db.collection(collectionPath).snapshots();
  }

  /// Update a document by [id].
  Future<void> update(String id, Map<String, dynamic> data) {
    return _db.collection(collectionPath).doc(id).update(data);
  }

  /// Delete a document by [id].
  Future<void> delete(String id) {
    return _db.collection(collectionPath).doc(id).delete();
  }
}
