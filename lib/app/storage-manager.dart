import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AppCloudStorage {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final Reference profileRef = _storage.ref().child("profile");

  static Future<void> uploadFile({
    required final File file,
    required final Reference reference,
    final void Function(double progress)? onProgress,
    final void Function(String? url)? onComplete,
  }) async {
    UploadTask task = reference.putFile(file);

    task.snapshotEvents.listen((event) {
      final double progress = event.bytesTransferred / event.totalBytes * 100;
      if (onProgress != null) {
        onProgress(progress);
      }
    });

    final TaskState taskState = (await task.whenComplete(() {})).state;
    if (taskState == TaskState.success) {
      final String url = await reference.getDownloadURL();
      if (onComplete != null) {
        onComplete(url);
      }
    }
    if(taskState == TaskState.error){
      if (onComplete != null) {
        onComplete(null);
      }
    }
  }
}
