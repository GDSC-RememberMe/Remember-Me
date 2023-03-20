import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember_me_mobile/memory_bubble/model/body/save_memory_body.dart';
import 'package:remember_me_mobile/memory_bubble/model/body/update_memory_body.dart';
import 'package:remember_me_mobile/memory_bubble/repository/memory_repository.dart';

final memoryProvider = StateNotifierProvider<MemoryStateNotifier, void>((ref) {
  final memoryRepository = ref.watch(memoryRepositoryProvider);

  return MemoryStateNotifier(
    repository: memoryRepository,
  );
});

class MemoryStateNotifier extends StateNotifier<void> {
  final MemoryRepository repository;

  MemoryStateNotifier({
    required this.repository,
  }) : super(null) {}

  Future<void> saveMemory({
    required String title,
    required String content,
    required String tagWho,
    required String tagWhere,
    required String tagWhat,
  }) async {
    try {
      final SaveMemoryBody body =
          SaveMemoryBody(title: title, content: content, tagWho: tagWho, tagWhere: tagWhere, tagWhat: tagWhat);

      await repository.saveMemory(body: body);
    } catch (e) {}
  }

  Future<void> updateMemory({
    String? title,
    String? content,
    String? tagWho,
    String? tagWhere,
    String? tagWhat,
    required int id,
  }) async {
    try {
      final UpdateMemoryBody body =
          UpdateMemoryBody(title: title, content: content, tagWho: tagWho, tagWhere: tagWhere, tagWhat: tagWhat);

      await repository.updateMemory(id: id.toString(), body: body);
    } catch (e) {}
  }

  Future<void> deleteMemory({
    required int id,
  }) async {
    try {
      await repository.deleteMemory(id: id.toString());
    } catch (e) {}
  }
}
