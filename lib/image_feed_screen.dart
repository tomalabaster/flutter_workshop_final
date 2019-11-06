import 'package:flutter/material.dart';
import 'package:flutter_workshop/futures.dart';
import 'package:flutter_workshop/images.dart';

class ImageFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ImageFeedItem>>(
        future: getImageFeedItemsRandomEmptyAndRandomLoadTimesAndRandomErrors(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            if (snapshot.data.isEmpty) {
              return Text('No images');
            } else {
            return this.getGrid(snapshot.data);
            }
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return CircularProgressIndicator();
        }
      ),
    );
  }

  Widget getGrid(List<ImageFeedItem> items) {
    return GridView.builder(
        itemCount: images.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          var item = images[index];

          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Stack(children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(item.imageUrl, fit: BoxFit.cover),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      color: Colors.black.withAlpha(128),
                      child: Text(
                        item.title,
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ]),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/image_screen', arguments: item);
            },
          );
        },
      );
  }
}
