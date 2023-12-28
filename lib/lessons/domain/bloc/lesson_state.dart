// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'lesson_bloc.dart';

class LessonState {
  final List<Lesson> lessons;
  final int studiedIndex;
  final int index;
  const LessonState({
    this.lessons = const [],
    this.studiedIndex = 0,
    this.index = 0,
  });

  LessonState copyWith({
    List<Lesson>? lessons,
    int? studiedIndex,
    int? index,
  }) {
    return LessonState(
      lessons: lessons ?? this.lessons,
      index: index ?? this.index,
      studiedIndex: studiedIndex ?? this.studiedIndex,
    );
  }
}
