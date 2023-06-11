import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweetapp/constants/collections_names.dart';

class TweetOperations {
  Future<void> editTweet(Map<String, dynamic> tweets) async {
    await FirebaseFirestore.instance
        .collection(tweetsCollect)
        .doc(tweetsDoc)
        .update(tweets);
  }

  Future<void> deleteTweet(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection(tweetsCollect)
        .doc(doc.id)
        .delete();
  }
}
