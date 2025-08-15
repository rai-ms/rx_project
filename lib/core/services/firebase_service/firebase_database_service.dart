import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Set data at a specific path
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _database.child(path).set(data);
    } catch (e) {
      throw Exception('Failed to set data: $e');
    }
  }

  // Update data at a specific path
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _database.child(path).update(data);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  // Read data once from a specific path
  Future<DatabaseEvent> getData(String path) async {
    try {
      return await _database.child(path).once();
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  // Listen to real-time updates from a specific path
  Stream<DatabaseEvent> streamData(String path) {
    try {
      return _database.child(path).onValue;
    } catch (e) {
      throw Exception('Failed to stream data: $e');
    }
  }

  // Remove data at a specific path
  Future<void> removeData(String path) async {
    try {
      await _database.child(path).remove();
    } catch (e) {
      throw Exception('Failed to remove data: $e');
    }
  }

  // Push data to a list (auto-generates a unique key)
  Future<DatabaseReference> pushData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final ref = _database.child(path).push();
      await ref.set(data);
      return ref;
    } catch (e) {
      throw Exception('Failed to push data: $e');
    }
  }

  // Query data with ordering and filtering
  Query orderByChild({
    required String path,
    required String childKey,
    dynamic startAt,
    dynamic endAt,
    dynamic equalTo,
    int? limitToFirst,
    int? limitToLast,
  }) {
    try {
      Query query = _database.child(path).orderByChild(childKey);
      
      if (startAt != null) query = query.startAt(startAt);
      if (endAt != null) query = query.endAt(endAt);
      if (equalTo != null) query = query.equalTo(equalTo);
      if (limitToFirst != null) query = query.limitToFirst(limitToFirst);
      if (limitToLast != null) query = query.limitToLast(limitToLast);
      
      return query;
    } catch (e) {
      throw Exception('Failed to query data: $e');
    }
  }
}
