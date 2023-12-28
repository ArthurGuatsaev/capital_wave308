import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../import.dart';

class LessonsRepo with LessonAbzac {
  final StreamController<String> errorController;
  LessonsRepo({required this.errorController});
  List<Lesson>? lessons;
  Future<void> getLessons({StreamController<VLoading>? controller}) async {
    final l = await LessonApiClient.getLessons(errorController);
    lessons = await Future.wait(l.map((e) async {
      final st = await getStudied(id: e.id);
      return e.copyWith(studied: st, index: st);
    }).toList());
    controller?.add(VLoading.lesson);
  }

  Future<void> resetLesson() async {
    lessons!.forEach((element) async {
      await removeProgress(id: element.id);
    });
  }
}

mixin LessonAbzac {
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<void> changeStudied({required int number, required int id}) async {
    (await prefs).setInt('$id', number);
  }

  Future<int> getStudied({required int id}) async {
    return (await prefs).getInt('$id') ?? 1;
  }

  Future<void> removeProgress({required int id}) async {
    (await prefs).remove('$id');
  }
}
