import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_book_model.dart';
import 'package:remember_me_mobile/nostalgia_item/repository/nostalgia_item_repository.dart';

final nostalgiaItemBookProvider =
    StateNotifierProvider<NostalgiaItemBookStateNotifier, List<NostalgiaItemBookModel>>((ref) {
  final nostalgiaItemBookRepository = ref.watch(nostalgiaItemRepositoryProvider);

  return NostalgiaItemBookStateNotifier(
    repository: nostalgiaItemBookRepository,
  );
});

class NostalgiaItemBookStateNotifier extends StateNotifier<List<NostalgiaItemBookModel>> {
  final NostalgiaItemRepository repository;

  NostalgiaItemBookStateNotifier({
    required this.repository,
  }) : super([]) {
    getNostalgiaItemBookBook();
  }

  Future<void> getNostalgiaItemBookBook() async {
    try {
      final resp = await repository.getNostalgiaItemBook();
      state = resp;
    } catch (e) {
      state = [];
    }
  }
}
