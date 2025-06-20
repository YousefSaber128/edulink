import 'package:edu_link/core/domain/entities/location_entity.dart';
import 'package:edu_link/core/domain/entities/office_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart'
    show ProfilePanal;
import 'package:flutter/material.dart';

class ThirdPanal extends StatelessWidget {
  const ThirdPanal({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final OfficeEntity? office = user.office;
    final LocationEntity? location = office?.location;
    final String? allTimes = office?.availability?.times
        ?.expand<String?>((e) => [e.toFormattedString(context)])
        .join('\n');
    return ProfilePanal(
      child: Column(
        spacing: 8,
        children: [
          if (location?.isValid() ?? false)
            _ListTile(
              title: 'Office Location',
              subtitle:
                  '${location?.room}, ${location?.building}, ${location?.floor}\n'
                  '${location?.department} Department',
              icon: Icons.location_on_rounded,
            ),
          const Divider(indent: 16, endIndent: 16),
          if (allTimes != null)
            _ListTile(
              title: 'Office Hours',
              subtitle: allTimes,
              icon: Icons.watch_later_rounded,
            ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) => ListTile(
    minVerticalPadding: 0,
    minTileHeight: 0,
    trailing: Icon(icon),
    title: EText(
      title,
      style: TextStyle(
        fontSize: 13,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
      ),
    ),
    subtitle: EText(
      subtitle,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );
}
