import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember_me_mobile/common/const/data.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'memory_data_repository.g.dart';

@Riverpod(
  keepAlive: true,
)
MemoryDataRepository memoryDataRepository(MemoryDataRepositoryRef ref) {
  final dio = ref.watch(dioProvider);

  return MemoryDataRepository(baseUrl: APP_BASE_URL, dio: dio);
}

class MemoryDataRepository {
  final String baseUrl;
  final Dio dio;

  MemoryDataRepository({required this.baseUrl, required this.dio});

  Future<bool> uploadImage({
    required XFile image,
    required int memoryId,
  }) async {
    try {
      final data = FormData();

      data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(
          File(image.path).path,
          filename: image.path.split(Platform.pathSeparator).last,
        ),
      ));

      final resp = await dio.post(
        "$baseUrl/image/$memoryId",
        data: data,
      );

      return resp.statusCode == 200;
    } on DioError catch (_) {
      return false;
    }
  }

  Future<bool> uploadAudio({
    required File audio,
    required int memoryId,
  }) async {
    try {
      final data = FormData();

      data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(
          audio.path,
          filename: audio.path.split(Platform.pathSeparator).last,
        ),
      ));

      final resp = await dio.post(
        "$baseUrl/audio/$memoryId",
        data: data,
      );

      return resp.statusCode == 200;
    } on DioError catch (_) {
      return false;
    }
  }
}
