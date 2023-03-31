import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_model.dart';
import 'package:remember_me_mobile/nostalgia_item/repository/nostalgia_item_repository.dart';

final nostalgiaItemProvider = StateNotifierProvider<NostalgiaItemStateNotifier, List<NostalgiaItemModel>>((ref) {
  final nostalgiaItemRepository = ref.watch(nostalgiaItemRepositoryProvider);

  return NostalgiaItemStateNotifier(
    repository: nostalgiaItemRepository,
  );
});

final nostalgiaItemDetailProvider = Provider.family<NostalgiaItemModel?, int>((ref, id) {
  final state = ref.watch(nostalgiaItemProvider);

  if (state.isEmpty) {
    return null;
  }

  return state.firstWhereOrNull((element) => element.rightNostalgiaItemId == id);
});

class NostalgiaItemStateNotifier extends StateNotifier<List<NostalgiaItemModel>> {
  final NostalgiaItemRepository repository;

  NostalgiaItemStateNotifier({
    required this.repository,
  }) : super([]) {
    getItems();
  }

  Future<void> getItems() async {
    final items = await repository.getNostalgiaItems();
    state = items;
  }

  Future<bool> saveNostalgiaItemResult({
    required List<Map<NostalgiaItemModel, Map<String, bool>>> selectedAnswers,
  }) async {
    try {
      List<Map> resultList = [];

      for (Map<NostalgiaItemModel, Map<String, bool>> answer in selectedAnswers) {
        resultList.add({
          "id": answer.entries.first.key.rightNostalgiaItemId,
          "result": answer.entries.first.value.entries.first.value
        });
      }

      await repository.saveNostalgiaItemResult(resultList: resultList);

      return true;
    } catch (e) {
      return false;
    }
  }
}
