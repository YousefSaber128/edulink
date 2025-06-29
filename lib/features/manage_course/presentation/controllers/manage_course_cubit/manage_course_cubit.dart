import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/duration_entity.dart'
    show DurationEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/courses_repo.dart';
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'manage_course_state.dart';

class ManageCourseCubit extends Cubit<ManageCourseState> {
  ManageCourseCubit(this.course) : super(const ManageCourseInitial());
  CourseEntity course;
  CourseEntity _updateCourse(CourseEntity courseEntity) =>
      course = courseEntity;
  void setTitle(String title) {
    _updateCourse(course.setTitle(title));
    emit(ManageCourseUpdated());
  }

  void setId() {
    _updateCourse(course.setId(course.code!));
    emit(ManageCourseUpdated());
  }

  void setCode(String code) {
    _updateCourse(course.setCode(code));
    emit(ManageCourseUpdated());
  }

  void setDescription(String description) {
    _updateCourse(course.setDescription(description));
    emit(ManageCourseUpdated());
  }

  Future<void> setImage() async {
    _updateCourse(await course.setImage());
    emit(ManageCourseUpdated());
  }

  void setImageUrl(String imageUrl) {
    _updateCourse(course.setImageUrl(imageUrl));
    emit(ManageCourseUpdated());
  }

  void setType(String type) {
    _updateCourse(course.setType(type));
    emit(ManageCourseUpdated());
  }

  void setLevel(String level) {
    _updateCourse(course.setLevel(level));
    emit(ManageCourseUpdated());
  }

  void setDepartment(String department) {
    _updateCourse(course.setDepartment(department));
    emit(ManageCourseUpdated());
  }

  void setSemester(String semester) {
    _updateCourse(course.setSemester(semester));
    emit(ManageCourseUpdated());
  }

  void setCreditHour(int creditHour) {
    _updateCourse(course.setCreditHour(creditHour));
    emit(ManageCourseUpdated());
  }

  void setLectures(int lectures) {
    _updateCourse(course.setLectures(lectures));
    emit(ManageCourseUpdated());
  }

  void setDuration(DurationEntity duration) {
    _updateCourse(course.setDuration(duration));
    emit(ManageCourseUpdated());
  }

  void setProfessor(UserEntity professor) {
    _updateCourse(course.setProfessor(professor));
    emit(ManageCourseUpdated());
  }

  void resetCourse() {
    _updateCourse(const CourseEntity());
    emit(ManageCourseUpdated());
  }

  Future<void> update() async {
    emit(const ManageCourseLoading());
    setId();
    if (course.image != null) {
      await const CoursesRepo().uploadImage(course.image!).then(setImageUrl);
    }
    return const CoursesRepo()
        .update(data: course.toMap(), documentId: course.id!)
        .then((_) => emit(const ManageCourseSuccess()))
        .catchError((e) => emit(ManageCourseFailure(e.toString())));
  }

  Future<void> upload() {
    emit(const ManageCourseLoading());
    setId();
    return const CoursesRepo()
        .uploadImage(course.image!)
        .then(setImageUrl)
        .then(
          (_) => const CoursesRepo()
              .add(data: course.toMap(), documentId: course.id)
              .then(
                (_) => const UserRepo().update(
                  data: getUser!
                      .copyWith(
                        coursesIds: getUser!.coursesIds?..add(course.id!),
                      )
                      .toMap(),
                  documentId: getUser!.id!,
                ),
              )
              .then((_) => emit(const ManageCourseSuccess())),
        )
        .catchError((e) => emit(ManageCourseFailure(e.toString())));
  }
}
