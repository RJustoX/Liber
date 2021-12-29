import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProvider {
  factory FirebaseProvider() {
    return _instance;
  }

  FirebaseProvider._internal();

  static final FirebaseProvider _instance = FirebaseProvider._internal();

  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  Future<String> getUserAvatar(int id) async {
    final Reference ref = (await _fStorage.ref('images/$id/avatar').listAll()).items.last;
    String avatarUrl = await ref.getDownloadURL();
    return avatarUrl;
  }

  Future<String> getGoalImage(int id) async {
    final Reference ref = (await _fStorage.ref('images/$id/met').listAll()).items.last;
    String avatarUrl = await ref.getDownloadURL();
    return avatarUrl;
  }
}
