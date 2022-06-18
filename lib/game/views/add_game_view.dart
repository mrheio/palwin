import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:input_validator/input_validator.dart';
import 'package:palwin/common/styles/app_spacing.dart';
import 'package:palwin/common/utils.dart';
import 'package:palwin/common/widgets/loading.dart';
import 'package:styles/styles.dart';

import '../providers.dart';

class AddGameView extends ConsumerStatefulWidget {
  const AddGameView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddGameState();
  }
}

class _AddGameState extends ConsumerState<AddGameView> {
  final ImagePicker _imagePicker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final teamSizeController = TextEditingController();
  File? icon;

  @override
  void dispose() {
    nameController.dispose();
    teamSizeController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final imageRes = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageRes != null) {
      setState(() {
        icon = File(imageRes.path);
      });
    }
  }

  void removeIcon() {
    setState(() {
      icon = null;
    });
  }

  Future<void> addGame() async {
    if (formKey.currentState!.validate()) {
      await ref.read(gamesStateProvider.notifier).addGame(
          name: getText(nameController),
          teamSize: getText(teamSizeController),
          icon: icon);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status =
        ref.watch(gamesStateProvider.select((value) => value.status));

    if (status is LoadingStatus) {
      return const Loading();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: StyledColumn(
            gap: AppSpacing.m,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyledTextField(
                label: 'Nume joc',
                controller: nameController,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledTextField(
                label: 'Capacitate maxima echipa',
                controller: teamSizeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: const InputValidator().notEmpty().numeric().create(),
              ),
              StyledRow(
                gap: AppSpacing.l,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StyledButtonCircle(
                    onPressed: pickImage,
                    outlined: true,
                    child: const Icon(Icons.image_search_rounded),
                  ),
                  if (icon != null) ...[
                    Image.file(
                      File(icon!.path),
                      width: 56,
                      height: 56,
                    ),
                    StyledButtonCircle(
                      onPressed: removeIcon,
                      outlined: true,
                      child: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ],
              ),
              StyledButtonFluid(
                onPressed: addGame,
                child: const StyledText('Adauga joc'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
