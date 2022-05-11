import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Product {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Reference get storageRef => storage.ref().child('products').child(id!);

  String? id;
  String? title;
  String? type;
  String? description;
  String? image;
  int? height;
  int? width;
  File? newImage;
  num? price;
  double? rating;
  Timestamp? updateProduct;
  DocumentReference? reference;
  String get formattedDate {
    if(updateProduct == null){
      return '';
    }else{
      return DateFormat('dd/MM/yyy H:m').format(updateProduct!.toDate());
    }
  }
      
  Product(
      {this.title = '',
      this.type = '',
      this.description = '',
      this.image,
      this.height = 0,
      this.width = 0,
      this.price = 0.0,
      this.rating,
      this.updateProduct,
      this.newImage,
      this.id,
      this.reference});

  Product clone() {
    return Product(
      title: title,
      type: type,
      description: description,
      image: image,
      height: height,
      price: price,
      rating: rating,
      width: width,
      updateProduct: updateProduct,
      reference: reference,
      id: id,
    );
  }

  factory Product.FromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map;
    return Product(
        id: doc.id,
        title: data['title'],
        type: data['type'],
        description: data['description'],
        image: data['images'],
        height: data['height']?.toInt(),
        width: data['width']?.toInt(),
        price: data['price'],
        rating: double.tryParse(data['rating'].toString()) ?? 0.0,
        updateProduct: data['updateProduct'],
        reference: doc.reference);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'height': height,
      'width': width,
      'price': price,
      'rating': rating,
      'updateProduct': FieldValue.serverTimestamp(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    String baseUrl =
        'https://raw.githubusercontent.com/AndreLuiz-JService/DataBase2/main/assets/images/';
    return Product(
      title: json['title'],
      type: json['type'],
      description: json['description'],
      image: baseUrl + json['filename'],
      height: json['height']?.toInt(),
      width: json['width']?.toInt(),
      price: json['price'],
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }

  Future<void> saveRating() async {
    await reference!.update({'rating': rating});
  }

  Future<void> save() async {
    if (reference == null) {
      reference = await firebase.collection('products').add(toMap());
      id = reference!.id;
      if (newImage == null) {
        await reference!.update({'images': image});
      } else {
        final UploadTask task =
            storageRef.child(const Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        await reference!.update({'images': url});
      }
    } else {
      await reference!.update(toMap());

      try {
        if (newImage != null) {
          final UploadTask task =
              storageRef.child(const Uuid().v1()).putFile(newImage as File);

          final TaskSnapshot snapshot = await task;

          final String url = await snapshot.ref.getDownloadURL();
          await reference!.update({'images': url});
          if (image!.contains('firebase')) {
            final refImg = storage.refFromURL(image!);
            await refImg.delete();
          }
        }
      } catch (e) {
        debugPrint('falha ao deletar $image');
      }
    }
  }

  Future<void> remove() async {
    reference!.delete();
  }
}
