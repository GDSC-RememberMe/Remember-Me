import 'package:dio/dio.dart' hide Headers;
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_book_model.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nostalgia_item_repository.g.dart';

@Riverpod(
  keepAlive: true,
)
NostalgiaItemRepository nostalgiaItemRepository(NostalgiaItemRepositoryRef ref) {
  final dio = ref.watch(dioProvider);

  return NostalgiaItemRepository(dio, baseUrl: NOSTALGIAITEM_BASE_URL);
}

@RestApi()
abstract class NostalgiaItemRepository {
  factory NostalgiaItemRepository(Dio dio, {String baseUrl}) = _NostalgiaItemRepository;

  @GET("/")
  @Headers({
    "accessToken": "true",
  })
  Future<List<NostalgiaItemModel>> getNostalgiaItems();

  @GET("/all")
  @Headers({
    "accessToken": "true",
  })
  Future<List<NostalgiaItemBookModel>> getNostalgiaItemBook();

  @POST("/result")
  @Headers({
    "accessToken": "true",
  })
  Future<void> saveNostalgiaItemResult({
    @Field("resultList") required List<Map> resultList,
  });

  @GET("/result/{month}")
  @Headers({
    "accessToken": "true",
  })
  Future<String> getNostalgiaItemResultByMonth({
    @Path() required String month,
  });
}
