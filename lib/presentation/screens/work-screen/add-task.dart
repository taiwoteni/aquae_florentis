import 'dart:io';

import 'package:aquae_florentis/app/file-manager.dart';
import 'package:aquae_florentis/presentation/providers/work-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/work-screen/select-map-widget.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/dropdown-widget.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/page-header.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/community-model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  bool forceShow = false;
  final TextEditingController remarkController =
      TextEditingController(text: MockWorkData.remark);
  final buttonKey = const Key("task-post-button");
  TaskType? taskType = MockWorkData.taskType;
  String? formattedAddress;
  String? image;

  @override
  void dispose() {
    remarkController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Scaffold(
        backgroundColor: ColorManager.background,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: null,
            padding: EdgeInsets.only(
              left: isMobile ? SizeManager.medium : SizeManager.extralarge,
              right: isMobile ? SizeManager.medium : SizeManager.extralarge,
              top: SizeManager.large,
            ),
            child: Column(
              children: [
                const PageHeader(
                  text: "Create Task",
                ),
                extraLargeSpacer(),
                SelectMapWidget(
                  onMapSelect: (json) {
                    LatLng latlng = json["latlng"] as LatLng;
                    MockWorkData.lat = latlng.latitude;
                    MockWorkData.long = latlng.longitude;

                    setState(() {
                      formattedAddress = json["place name"];
                    });
                  },
                ),
                if (formattedAddress != null) mediumSpacer(),
                Text(
                  formattedAddress ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: FontSizeManager.medium * 0.8,
                      color: ColorManager.secondary,
                      fontWeight: FontWeightManager.medium),
                ),
                extraLargeSpacer(),
                if (image != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: SizeManager.large * 0.8),
                      child: HeaderText(
                        "Visual Description",
                        headerTextStyle: HeaderTextStyle.subheader,
                        color: ColorManager.primary,
                        fontSize: FontSizeManager.medium,
                      ),
                    ),
                  ),
                if (image != null) mediumSpacer(),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeManager.large * 0.8),
                    child: GestureDetector(
                      onTap: () {
                        if (forceShow) {
                          return;
                        }
                        setState(() {
                          forceShow = true;
                        });
                        Future.delayed(const Duration(seconds: 3))
                            .then((value) {
                          setState(() {
                            forceShow = false;
                          });
                        });
                      },
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: double.maxFinite,
                          maxWidth: double.maxFinite,
                          minHeight: 100,
                          maxHeight: 250,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeManager.large),
                            image: DecorationImage(
                              image: FileImage(File(image!)),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                if (image != null) mediumSpacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeManager.large * 0.8),
                  child: DropdownWidget(
                    'Type',
                    items: TaskType.values
                        .map((e) =>
                            TaskTypeConverter.convertToString(taskType: e))
                        .toList(),
                    prefixIcon: CupertinoIcons.person_3,
                    prefixSvg: "work-fill",
                    value: taskType == null
                        ? ""
                        : TaskTypeConverter.convertToString(
                            taskType: taskType!),
                    onChanged: (value) => setState(() => taskType =
                        TaskTypeConverter.convertToType(
                            taskType: value.toString())),
                  ),
                ),
                mediumSpacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeManager.large * 0.8),
                  child: InputTextField(
                      controller: remarkController,
                      hint: "Write about the situation",
                      maxLines: 6,
                      prefixIcon: CupertinoIcons.doc_append,
                      textInputType: TextInputType.text,
                      textFieldStyle: TextFieldStyle.normal),
                ),
                extraLargeSpacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeManager.large * 0.8),
                  child: Button(
                      isLoadable: true,
                      buttonColor: ColorManager.primaryColor,
                      key: buttonKey,
                      onTap: null,
                      label: "Post Task"),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: image == null || forceShow
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: takePickture,
                    heroTag: "camera-hero-tag",
                    backgroundColor: Colors.red,
                    child: const Icon(
                      Icons.add_a_photo_rounded,
                      size: IconSizeManager.regular,
                      color: Colors.white,
                    ),
                  ),
                  mediumSpacer(),
                  FloatingActionButton(
                    onPressed: pickImage,
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.add_photo_alternate,
                      size: IconSizeManager.regular,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Future<void> pickImage() async {
    await FileManager.pickImage(imageSource: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          this.image = image.path;
        });
      }
    });
  }

  Future<void> takePickture() async {
    await FileManager.pickImage(imageSource: ImageSource.camera).then((image) {
      if (image != null) {
        setState(() {
          this.image = image.path;
        });
      }
    });
  }
}
