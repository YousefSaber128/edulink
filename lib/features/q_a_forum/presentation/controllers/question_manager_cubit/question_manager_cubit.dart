import 'dart:async';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'question_manager_state.dart';

class QuestionManagerCubit extends Cubit<QuestionManagerState> {
  QuestionManagerCubit(this._courseId) : super(const _QuestionManagerInitial());
  final String _courseId;
  QuestionEntity _question = const QuestionEntity();

  QuestionEntity _updateQuestion(QuestionEntity question) =>
      _question = question;

  void setId([String? id]) {
    final QuestionEntity result = _question.setId(id);
    _updateQuestion(result);
    emit(_QuestionUpdated());
  }

  void setQuestion(String question) {
    final QuestionEntity result = _question.setQuestion(question);
    _updateQuestion(result);
    emit(_QuestionUpdated());
  }

  void setDate(DateTime date) {
    final QuestionEntity result = _question.setDate(date);
    _updateQuestion(result);
    emit(_QuestionUpdated());
  }

  void setUser(UserEntity user) {
    final QuestionEntity result = _question.setUser(user);
    _updateQuestion(result);
    emit(_QuestionUpdated());
  }

  Future<void> addQuestion() async {
    await const CoursesRepo().addQuestion(_question, _courseId);
    emit(const QuestionSuccess());
  }

  Future<void> updateQuestion() async {
    await const CoursesRepo().updateQuestion(_question, _courseId);
    emit(const QuestionSuccess());
  }

  Future<void> deleteQuestion(QuestionEntity question) async {
    await const CoursesRepo().deleteQuestion(question, _courseId);
    emit(const QuestionSuccess());
  }
}
