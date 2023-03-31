import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember_me_mobile/memory_bubble/model/body/save_memory_body.dart';
import 'package:remember_me_mobile/memory_bubble/model/body/update_memory_body.dart';
import 'package:remember_me_mobile/memory_bubble/model/memory_model.dart';
import 'package:remember_me_mobile/memory_bubble/repository/memory_data_repository.dart';
import 'package:remember_me_mobile/memory_bubble/repository/memory_repository.dart';

final memoryProvider = StateNotifierProvider<MemoryStateNotifier, List<MemoryModel>>((ref) {
  final memoryRepository = ref.watch(memoryRepositoryProvider);
  final memoryDataRepository = ref.watch(memoryDataRepositoryProvider);

  return MemoryStateNotifier(
    repository: memoryRepository,
    dataRepository: memoryDataRepository,
  );
});

final memoryDetailProvider = Provider.family<MemoryModel?, int>((ref, id) {
  final state = ref.watch(memoryProvider);

  if (state.isEmpty) {
    return null;
  }

  return state.firstWhereOrNull((element) => element.memoryId == id);
});

class MemoryStateNotifier extends StateNotifier<List<MemoryModel>> {
  final MemoryRepository repository;
  final MemoryDataRepository dataRepository;

  MemoryStateNotifier({
    required this.repository,
    required this.dataRepository,
  }) : super([]) {
    getMemories();
  }

  Future<void> getMemories() async {
    final memories = await repository.getMemories();

    state = memories;
  }

  Future<int> saveMemory({
    required String title,
    required String content,
    String? tagWho,
    required String tagWhere,
    String? tagWhat,
    required XFile image,
    File? audio,
  }) async {
    try {
      final SaveMemoryBody body =
          SaveMemoryBody(title: title, content: content, tagWho: tagWho, tagWhere: tagWhere, tagWhat: tagWhat);

      int id = 0;
      await repository.saveMemory(body: body).then((memoryId) {
        // dataRepository.uploadImage(image: image, memoryId: memoryId);
        // if (audio != null) {
        //   dataRepository.uploadAudio(audio: audio, memoryId: memoryId);
        // }
        id = memoryId;
      });

      getMemories();
      return id;
    } catch (e) {
      return 0;
    }
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

  Future<void> getMemory({
    required int memoryId,
  }) async {
    try {
      final resp = await repository.getMemory(id: memoryId.toString());

      final pState = state;

      state = pState.map((e) {
        if (e.memoryId == memoryId) {
          return resp;
        } else {
          return e;
        }
      }).toList();
    } catch (e) {}
  }
}
