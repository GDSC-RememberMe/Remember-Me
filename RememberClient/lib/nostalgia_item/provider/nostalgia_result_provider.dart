import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_calendar_model.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_result_model.dart';
import 'package:remember_me_mobile/nostalgia_item/repository/nostalgia_item_repository.dart';

final nostalgiaResultProvider =
    StateNotifierProvider<NostalgiaResultStateNotifier, List<NostalgiaCalendarModel>>((ref) {
  final nostalgiaResultRepository = ref.watch(nostalgiaItemRepositoryProvider);

  return NostalgiaResultStateNotifier(
    repository: nostalgiaResultRepository,
  );
});

class NostalgiaResultStateNotifier extends StateNotifier<List<NostalgiaCalendarModel>> {
  final NostalgiaItemRepository repository;

  NostalgiaResultStateNotifier({
    required this.repository,
  }) : super([]) {
    getNostalgiaResults(month: DateTime.now().month);
  }

  Future<void> getNostalgiaResults({
    required int month,
  }) async {
    try {
      final result = await repository.getNostalgiaItemResultByMonth(month: month.toString());
      Map<String, dynamic> jsonResult = jsonDecode(result);
      List<NostalgiaCalendarModel> resultList = [];
      jsonResult.forEach((key, value) {
        resultList.add(NostalgiaCalendarModel.fromJson({
          "when": key,
          "": value,
        }));
      });

      state = resultList;
    } catch (e, stackTrace) {
      print(e.toString());
      state = [];
    }
  }
}
