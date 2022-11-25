import 'dart:io';

abstract class MediaRepository {
  Future<String> sendImage({required File file});
}
