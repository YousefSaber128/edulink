import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/navigations.dart' show profileNavigation;
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    required this.user,
    this.radius,
    this.isHero = false,
    this.hasNavigation = true,
    super.key,
  });
  final UserEntity user;
  final double? radius;
  final bool isHero;
  final bool hasNavigation;
  @override
  Widget build(BuildContext context) {
    final String url =
        user.imageUrl ?? 'https://avatar.iran.liara.run/public/32';
    final circleAvatar = CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(url),
      radius: radius,
    );
    return GestureDetector(
      onTap: hasNavigation
          ? () => profileNavigation(context, extra: user)
          : null,
      child: isHero ? Hero(tag: url, child: circleAvatar) : circleAvatar,
    );
  }
}
