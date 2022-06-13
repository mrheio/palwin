import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/game/views/add_game_view/add_game_state.dart';
import 'package:styles/styles.dart';

class AddGameView extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  AddGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addGameStateProvider);
    final notifier = ref.read(addGameStateProvider.notifier);
    ref.watch(addGameEffectProvider(context));

    Future<void> pickImage() async {
      final res = await _imagePicker.pickImage(source: ImageSource.gallery);
      notifier.setIcon(res);
    }

    if (state.loading) {
      return const Loading();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: StyledColumn(
            gap: AppSpacing.m,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyledTextField(
                label: 'Nume joc',
                controller: state.nameController,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledTextField(
                label: 'Capacitate maxima echipa',
                controller: state.teamSizeController,
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
                  if (state.icon != null) ...[
                    Image.file(
                      File(state.icon!.path),
                      width: 56,
                      height: 56,
                    ),
                    StyledButtonCircle(
                      onPressed: notifier.removeIcon,
                      outlined: true,
                      child: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ],
              ),
              StyledButtonFluid(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    notifier.addGame();
                  }
                },
                child: const StyledText('Adauga joc'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
