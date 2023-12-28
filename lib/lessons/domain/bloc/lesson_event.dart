// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'lesson_bloc.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class GetLessonsEvent extends LessonEvent {}

class UpdateLessonsEvent extends LessonEvent {}

class ResetLessonEvent extends LessonEvent {}

class ChangeStudiedLessonsEvent extends LessonEvent {
  final int number;

  const ChangeStudiedLessonsEvent({required this.number});
}

class ChangeLessonsIndexEvent extends LessonEvent {
  final int index;
  const ChangeLessonsIndexEvent({
    required this.index,
  });
}
