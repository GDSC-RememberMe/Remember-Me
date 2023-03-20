import 'package:dio/dio.dart' hide Headers;
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:remember_me_mobile/memory_bubble/model/body/save_memory_body.dart';
import 'package:remember_me_mobile/memory_bubble/model/body/update_memory_body.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memory_repository.g.dart';

@Riverpod(
  keepAlive: true,
)
MemoryRepository memoryRepository(MemoryRepositoryRef ref) {
  final dio = ref.watch(dioProvider);

  return MemoryRepository(dio, baseUrl: MEMORY_BASE_URL);
}

@RestApi()
abstract class MemoryRepository {
  factory MemoryRepository(Dio dio, {String baseUrl}) = _MemoryRepository;

  @POST("/")
  @Headers({
    "accessToken": "true",
  })
  Future<void> saveMemory({
    @Body() required SaveMemoryBody body,
  });

  @PATCH("/{id}")
  @Headers({
    "accessToken": "true",
  })
  Future<void> updateMemory({
    @Path() required String id,
    @Body() required UpdateMemoryBody body,
  });

  @DELETE("/{id}")
  @Headers({
    "accessToken": "true",
  })
  Future<void> deleteMemory({
    @Path() required String id,
  });
}
