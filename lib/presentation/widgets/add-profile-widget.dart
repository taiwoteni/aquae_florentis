import 'dart:io';

import 'package:aquae_florentis/app/file-manager.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProfileWidget extends StatefulWidget {
  final void Function(XFile? profilePath) onProfileAdded;
  final bool cropProfile;
  final double size;
  final String? mockProfile;
  const AddProfileWidget(
      {super.key,
      this.size = 85,
      this.mockProfile,
      this.cropProfile = true,
      required this.onProfileAdded});

  @override
  State<AddProfileWidget> createState() => _AddProfileWidgetState();
}

class _AddProfileWidgetState extends State<AddProfileWidget> {
  XFile? profile;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: profile == null ? ColorManager.primaryColor : null,
          image: profile == null
              ? widget.mockProfile != null
                  ? widget.mockProfile!.startsWith("http")
                      ? DecorationImage(
                          image: NetworkImage(widget.mockProfile!),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: FileImage(File(widget.mockProfile!)),
                          fit: BoxFit.cover)
                  : null
              : DecorationImage(
                  image: FileImage(
                    File(profile!.path),
                  ),
                  fit: BoxFit.cover)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: () async {
            // ...Pick Image..
            final profile = await FileManager.pickImage();
            if (profile != null) {
              setState(() => this.profile = profile);
            }
            widget.onProfileAdded(profile);
          },
          child: profile != null || widget.mockProfile != null
              ? null
              : SvgIcon(
                  'add-profile',
                  color: Colors.white,
                  size: widget.size * 0.65,
                ),
        ),
      ),
    );
  }
}
