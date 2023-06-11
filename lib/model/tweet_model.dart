import 'dart:convert';

TweetsModel tweetsModelFromJson(String str) =>
    TweetsModel.fromJson(json.decode(str));

String tweetsModelToJson(TweetsModel data) => json.encode(data.toJson());

class TweetsModel {
  final List<TweetItem>? tweetItems;

  TweetsModel({
    this.tweetItems,
  });

  TweetsModel copyWith({
    List<TweetItem>? tweetItems,
  }) =>
      TweetsModel(
        tweetItems: tweetItems ?? this.tweetItems,
      );

  factory TweetsModel.fromJson(Map<String, dynamic> json) => TweetsModel(
        tweetItems: json["tweetsList"] == null
            ? []
            : List<TweetItem>.from(
                json["tweetsList"]!.map((x) => TweetItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tweetsList": tweetItems == null
            ? []
            : List<dynamic>.from(tweetItems!.map((x) => x.toJson())),
      };
}

class TweetItem {
  String? userId;
  String? tweet;
  String? date;
  num? id;

  TweetItem({
    this.userId,
    this.tweet,
    this.date,
    this.id,
  });

  TweetItem copyWith({
    String? userId,
    String? tweet,
    String? date,
    num? id,
  }) =>
      TweetItem(
        userId: userId ?? this.userId,
        tweet: tweet ?? this.tweet,
        date: date ?? this.date,
        id: id ?? this.id,
      );

  factory TweetItem.fromJson(Map<String, dynamic> json) => TweetItem(
        userId: json["userId"],
        tweet: json["tweet"],
        date: json["date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "tweet": tweet,
        "date": date,
        "id": id,
      };
}
