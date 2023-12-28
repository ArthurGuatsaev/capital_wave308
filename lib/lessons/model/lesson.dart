import 'package:flutter/material.dart';
import '../import.dart';

class Lesson {
  final int id;
  final String title;
  final String image;
  final String description;
  final int studied;
  final int index;
  Lesson({
    required this.index,
    required this.id,
    required this.title,
    required this.studied,
    required this.image,
    required this.description,
  });

  Lesson copyWith({
    int? id,
    String? title,
    String? image,
    int? studied,
    int? index,
    String? description,
  }) {
    return Lesson(
      index: index ?? this.index,
      id: id ?? this.id,
      title: title ?? this.title,
      studied: studied ?? this.studied,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Text get progress {
    if (studied == abc.length) {
      return const Text(
        'Passed',
        style: TextStyle(
            fontSize: 13, color: primary, fontWeight: FontWeight.w400),
      );
    } else if (studied == 1) {
      return const Text('0%',
          style: TextStyle(
              fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400));
    } else {
      final prog = (studied * 100) / abc.length;
      return Text(
        '${prog.toStringAsFixed(1)}%',
        style: const TextStyle(
            fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
      );
    }
  }

  double get progressValue {
    if (studied == abc.length) {
      return 1;
    } else if (studied == 1) {
      return 0;
    } else {
      final prog = (studied * 100) / abc.length;
      return prog / 100;
    }
  }

  factory Lesson.fromMap({required Map<String, dynamic> map}) {
    try {
      final image = map['resultImage'];
      final id = map['resultId'];
      final segments = map['resultSegments'] as List<dynamic>;
      final items = segments
          .map(
            (e) => e as Map<String, dynamic>,
          )
          .toList();
      const stud = 0;
      final title = items.first['resultSubTitle'] as String;
      final description = items.first['resultText'] as String;
      return Lesson(
        id: id,
        studied: stud,
        index: 0,
        title: title,
        image: image,
        description: description,
      );
    } catch (e) {
      return Lesson(
          title: '', image: '', description: '', id: 0, studied: 0, index: 0);
    }
  }

  @override
  String toString() =>
      'Lesson(title: $title, image: $image, description: $description)';

  @override
  bool operator ==(covariant Lesson other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.image == image &&
        other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ image.hashCode ^ description.hashCode;

  List<String> get abc {
    String init = description;
    List<String> result = [];
    for (var i = 0; i < 10; i++) {
      int index = init.indexOf('\r\n\r\n');
      if (index < 0) break;
      String first = init.substring(0, index);
      if (init.length > index + 4) index += 4;
      init = init.substring(index);
      if (first.contains('\n')) first.substring(2);
      if (first.length > 20) result.add(first);
    }
    return result;
  }
}
