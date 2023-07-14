import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lms/model/artwork_model.dart';
import 'package:lms/views/AddArtWork.dart';
import 'package:lms/widgets/coursetile.dart';

class ArtWorks extends StatefulWidget {
  const ArtWorks({super.key});

  @override
  State<ArtWorks> createState() => _ArtWorksState();
}

class _ArtWorksState extends State<ArtWorks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddArtWork(),
                ));
          },
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          title: Text("Art Works"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("artworks").snapshots(),
          builder: (context, snapshot) {
            if (!(snapshot.connectionState == ConnectionState.waiting)) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Art Works Found"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    var artwork = ArtWorkModel.fromSnapshot(data);
                    return InkWell(
                      onDoubleTap: () async {
                        FirebaseFirestore.instance
                            .collection("artworks")
                            .doc(artwork.id)
                            .update({
                          "likes": artwork.likes + 1,
                        });
                      },
                      child: CourseTile(
                          imageURL: artwork.artWorkUrl,
                          title: artwork.author,
                          courseURL: "",
                          successRate: artwork.likes.toString()),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
