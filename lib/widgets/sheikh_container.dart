import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShikhContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int id;
  final Function onTap;

  const ShikhContainer({this.title, this.imageUrl, this.id, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(id, context);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: 185,
        height: 185,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.red[200],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider),
                    ),
                  ),
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GridTileBar(
                      backgroundColor: Colors.white70,
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
