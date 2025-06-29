import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';
import 'package:edu_link/core/helpers/text_id_generator.dart';

class QuestionEntity {
  const QuestionEntity({
    this.id,
    this.question,
    this.answers,
    this.user,
    this.date,
  });
  factory QuestionEntity.fromMap(Map<String, dynamic>? data) {
    final DateTime? date = switch (data?['date']) {
      final String s => DateTime.tryParse(s),
      final int i => DateTime.fromMillisecondsSinceEpoch(i),
      final Timestamp t => t.toDate(),
      final DateTime d => d,
      _ => DateTime.now(),
    };
    return QuestionEntity(
      id: data?['id'],
      question: data?['question'],
      answers: ListHandler.parseComplex(data?['answers'], AnswerEntity.fromMap),
      user: data?['user'] != null
          ? UserEntity.fromMap(data?['user'])
          : UserEntity(id: data?['userId']),
      date: date,
    );
  }
  final String? id;
  final String? question;
  final List<AnswerEntity>? answers;
  final UserEntity? user;
  final DateTime? date;
  Map<String, dynamic> toMap() => {
    'id': id,
    'question': question,
    'answers': answers?.map((e) => e.toMap()).toList(),
    'userId': user?.id,
    'date': date,
  };
  QuestionEntity copyWith({
    String? id,
    String? question,
    List<AnswerEntity>? answers,
    UserEntity? user,
    DateTime? date,
  }) => QuestionEntity(
    id: id ?? this.id,
    question: question ?? this.question,
    answers: answers ?? this.answers,
    user: user ?? this.user,
    date: date ?? this.date,
  );
  QuestionEntity setId([String? id]) => copyWith(
    id:
        id ??
        TextIdGenerator(date!.millisecondsSinceEpoch.toString()).generateId(),
  );
  QuestionEntity setQuestion(String question) => copyWith(question: question);
  QuestionEntity setUser(UserEntity user) => copyWith(user: user);
  QuestionEntity setDate(DateTime date) => copyWith(date: date);
}
