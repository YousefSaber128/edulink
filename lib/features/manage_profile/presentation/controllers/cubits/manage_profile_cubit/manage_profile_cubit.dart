import 'dart:async';
import 'package:edu_link/core/domain/entities/available_time_entity.dart'
    show AvailableTimeEntity;
import 'package:edu_link/core/domain/entities/department_entity.dart';
import 'package:edu_link/core/domain/entities/program_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/departments_repo.dart' show DepartmentsRepo;
import 'package:edu_link/core/repos/programs_repo.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'manage_profile_state.dart';

class ManageProfileCubit extends Cubit<ManageProfileState> {
  ManageProfileCubit() : super(const ManageProfileInitial()) {
    unawaited(fetchDepartmentsAndPrograms());
  }
  UserEntity? user = getUser?.copyWith();

  final departments = List<DepartmentEntity>.empty(growable: true);
  final programs = List<ProgramEntity>.empty(growable: true);

  Future<void> fetchDepartmentsAndPrograms() async {
    departments.addAll(await DepartmentsRepo().departments());
    programs.addAll(await ProgramsRepo().programs());
    emit(ManageProfileUpdated());
  }

  UserEntity? updateUser(UserEntity? userEntity) => user = userEntity;

  void setName(String name) {
    updateUser(user?.setName(name));
    emit(ManageProfileUpdated());
  }

  void setEmail(String email) {
    updateUser(user?.setEmail(email));
    emit(ManageProfileUpdated());
  }

  void setGitHub(String githubLink) {
    updateUser(user?.setGitHub(githubLink));
    emit(ManageProfileUpdated());
  }

  void setLinkedIn(String linkedinLink) {
    updateUser(user?.setLinkedIn(linkedinLink));
    emit(ManageProfileUpdated());
  }

  void setPhone(String phone) {
    updateUser(user?.setPhone(phone));
    emit(ManageProfileUpdated());
  }

  Future<void> setImage() async {
    updateUser(await user?.setImage());
    emit(ManageProfileUpdated());
  }

  void setImageUrl(String imageUrl) {
    updateUser(user?.setImageUrl(imageUrl));
    emit(ManageProfileUpdated());
  }

  void setDepartment(DepartmentEntity department) {
    updateUser(user?.setDepartment(department));
    emit(ManageProfileUpdated());
  }

  void setProgram(ProgramEntity program) {
    updateUser(user?.setProgram(program));
    emit(ManageProfileUpdated());
  }

  void setLevel(String level) {
    updateUser(user?.setLevel(level));
    emit(ManageProfileUpdated());
  }

  void setSsn(String ssn) {
    updateUser(user?.setSsn(ssn));
    emit(ManageProfileUpdated());
  }

  void setAcademicTitle(String academicTitle) {
    updateUser(user?.setAcademicTitle(academicTitle));
    emit(ManageProfileUpdated());
  }

  void setBuilding(String building) {
    updateUser(user?.setBuilding(building));
    emit(ManageProfileUpdated());
  }

  void setFloor(String floor) {
    updateUser(user?.setFloor(floor));
    emit(ManageProfileUpdated());
  }

  void setRoom(String room) {
    updateUser(user?.setRoom(room));
    emit(ManageProfileUpdated());
  }

  void setContactInfo(String contactInfo) {
    updateUser(user?.setContactInfo(contactInfo));
    emit(ManageProfileUpdated());
  }

  void setAvailableTime(AvailableTimeEntity availableTime, [int? index]) {
    updateUser(user?.setAvailableTime(availableTime, index));
    emit(ManageProfileUpdated());
  }

  Future<void> update() async {
    emit(const ManageProfileLoading());
    const userRepo = UserRepo();
    if (user?.image != null) {
      await userRepo.uploadImage(user!.image!).then(setImageUrl);
    }
    await userRepo.update(data: user!.toMap(), documentId: user!.id!);
    emit(ManageProfileSuccess(user!));
  }
}
