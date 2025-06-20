import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_app_bar.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_bottom_app_bar.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({required this.user, super.key});
  final UserEntity user;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: ProfileAppBar(user: user),
    body: ProfileViewBody(user: user),
    bottomNavigationBar: ProfileBottomAppBar(user: user),
  );
}
