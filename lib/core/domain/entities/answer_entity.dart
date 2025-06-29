import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:edu_link/core/domain/entities/user_entity.dart';

class AnswerEntity {
  const AnswerEntity({this.answer, this.user, this.date});
  factory AnswerEntity.fromMap(Map<String, dynamic>? data) {
    final DateTime? date = switch (data?['date']) {
      final String s => DateTime.tryParse(s),
      final int i => DateTime.fromMillisecondsSinceEpoch(i),
      final Timestamp t => t.toDate(),
      final DateTime d => d,
      _ => null,
    };
    return AnswerEntity(
      answer: data?['answer'],
      user: data?['user'] != null
          ? UserEntity.fromMap(data?['user'])
          : UserEntity(id: data?['userId']),
      date: date,
    );
  }
  final String? answer;
  final UserEntity? user;
  final DateTime? date;
  Map<String, dynamic> toMap() => {
    'answer': answer,
    'userId': user?.id,
    'date': date,
  };
  AnswerEntity copyWith({String? answer, UserEntity? user, DateTime? date}) =>
      AnswerEntity(
        answer: answer ?? this.answer,
        user: user ?? this.user,
        date: date ?? this.date,
      );
  AnswerEntity setAnswer(String answer) => copyWith(answer: answer);
  AnswerEntity setUser(UserEntity user) => copyWith(user: user);
  AnswerEntity setDate(DateTime date) => copyWith(date: date);
}
