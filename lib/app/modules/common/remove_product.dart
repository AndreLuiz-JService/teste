import 'package:flutter/material.dart';

import '../home/models/product_model.dart';

class RemoveProductDialog extends StatelessWidget {
  const RemoveProductDialog({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Remover ${product.title}'),
      content: const Text('Esta ação não pode ser desfeita'),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'voltar',
                  style: TextStyle(
                      color: Colors.white,)
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  product.remove();
                  Navigator.pop(context);
                },
                child: const  Text(
                  'Remover produto',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
