import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelect});

  final Function(File) onImageSelect;

  final ImagePicker _picker = ImagePicker();

  void editImage(
    BuildContext context,
    String path,
  ) async {
    final File? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Image',
        initAspectRatio: CropAspectRatioPreset.ratio16x9,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: const IOSUiSettings(
          title: 'Editar Image',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir'),
    );
    if (croppedFile != null) onImageSelect(croppedFile);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Container(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () async {
                          final XFile? file = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (file != null) editImage(context, file.path);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple[600],
                                ),
                                child:const  Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: const  Icon(Icons.camera_alt,
                                      size: 30,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                'Camera',
                                style: TextStyle(
                                    color:Colors.white),
                              ),
                            ],
                          ),
                        )),
                    TextButton(
                        onPressed: () async {
                          final XFile? file = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (file != null) editImage(context, file.path);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple[600],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(Icons.photo,
                                      size: 30,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Galeria',
                                style: TextStyle(
                                    color:
                                        Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ));
    else
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CupertinoActionSheet(
            title: const Text('Selecionar Foto para o item'),
            message: const Text('Escolha a origem da foto'),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'cancelar',
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  final XFile? file =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (file != null) editImage(context, file.path);
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  final XFile? file =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (file != null) editImage(context, file.path);
                },
                child: const Text(
                  'Galeria',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
