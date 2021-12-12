import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProvider {
  factory FirebaseProvider() {
    return _instance;
  }

  FirebaseProvider._internal();

  static final FirebaseProvider _instance = FirebaseProvider._internal();

  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  Future<String> getUserAvatar(String nickname) async {
    final Reference ref = (await _fStorage.ref('images/$nickname/avatar').listAll()).items.last;
    String avatarUrl = await ref.getDownloadURL();
    return avatarUrl;
  }
}
