import 'dart:async';

import '../import.dart';
import 'package:dio/dio.dart';

class LessonApiClient {
  static Future<List<Lesson>> getLessons(
      StreamController<String> errorController) async {
    try {
      final x = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 7),
        receiveTimeout: const Duration(seconds: 7),
      ));
      final response = await x.get(
          'https://$myApiDomain/api/v2/lessons/?lang=en&token=$myApiToken');
      if (response.statusCode == 200) {
        final lessons = response.data!['results'] as List<dynamic>;
        final newLesson =
            lessons.map((e) => e as Map<String, dynamic>).toList();
        final list = newLesson.map((e) async {
          final term = Lesson.fromMap(map: e);
          return term;
        }).toList();
        return Future.wait(list);
      }
      return [];
    } on DioException catch (_) {
      errorController.add('No internet connection');
      return [];
    } catch (e) {
      return [];
    }
  }
}
