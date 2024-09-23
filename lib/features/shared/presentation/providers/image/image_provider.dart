import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poke_radar/core/core.dart';

final imageProvider = StateNotifierProvider<ImageNotifier, File?>((ref) {
  return ImageNotifier(
    imagePicker: ServiceLocator().get(),
  );
});

class ImageNotifier extends StateNotifier<File?> {
  final ImagePicker _imagePicker;
  ImageNotifier({
    required ImagePicker imagePicker,
  })  : _imagePicker = imagePicker,
        super(null);

  Future<void> setImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state = File(image.path);
  }
}
