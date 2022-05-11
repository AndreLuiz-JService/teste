import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../home/models/product_model.dart';
import 'image_source_sheet.dart';

class ImagesForm extends StatefulWidget {
  final Product product;
  const ImagesForm({Key? key, required this.product}) : super(key: key);

  @override
  State<ImagesForm> createState() => _ImagesFormState();
}

class _ImagesFormState extends State<ImagesForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return FormField<dynamic>(
      initialValue: widget.product.image,
      validator: (image) {
        if (image == null) return 'Insira uma imagem';
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
      onSaved: (image) {
        if (image != widget.product.image) {
          widget.product.newImage = image;
        }
      },
      builder: (state) {
        void onImageSelected(File file) {
          state.setValue(file);
          state.didChange(state.value);
          print(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            if (state.value is String)
              Container(
                width: size * 0.7,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        state.value,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              )
            else if (state.value != null)
              Container(
                width: size * 0.7,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        state.value as File,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 24,
            ),
            Material(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple.withAlpha(70),
              child: Container(
                width: size * 0.4,
                child: TextButton(
                    style: TextButton.styleFrom(
                        primary:
                            Theme.of(context).colorScheme.secondaryContainer),
                    onPressed: () {
                      if (Platform.isAndroid)
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                                  onImageSelect: onImageSelected,
                                ));
                      else
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                                  onImageSelect: onImageSelected,
                                ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 50,
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                state.errorText!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
