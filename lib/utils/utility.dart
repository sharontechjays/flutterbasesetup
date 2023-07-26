import 'package:flutter/material.dart';

Image buildImage(String url) {
  return Image.network(
    url,
    cacheWidth: 100,
    cacheHeight: 100,
    fit: BoxFit.cover,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

