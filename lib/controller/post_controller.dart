import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:cybehawks/models/news.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class PostController extends ChangeNotifier {
  static const _MONTHS = {
    'Jan': '01',
    'Feb': '02',
    'Mar': '03',
    'Apr': '04',
    'May': '05',
    'Jun': '06',
    'Jul': '07',
    'Aug': '08',
    'Sep': '09',
    'Oct': '10',
    'Nov': '11',
    'Dec': '12',
  };

  DateTime? parseRfc822(String input) {
    input = input.replaceFirst('GMT', '+0000');

    final splits = input.split(' ');

    final splitYear = splits[3];

    final splitMonth = _MONTHS[splits[2]];
    if (splitMonth == null) return null;

    var splitDay = splits[1];
    if (splitDay.length == 1) {
      splitDay = '0$splitDay';
    }

    final splitTime = splits[4], splitZone = splits[5];

    var reformatted = '$splitYear-$splitMonth-$splitDay $splitTime $splitZone';

    return DateTime.tryParse(reformatted);
  }

  List<News>? _allNews;
  List<News>? get allNews => _allNews;

  List<News>? firebaseNews;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<News>> getAllNews() async {
    final url = Uri.parse('https://portswigger.net/daily-swig/rss');
    final response = await http.get(url);
    var raw = xml.XmlDocument.parse(response.body);
    Iterable<xml.XmlElement> channel = raw.findAllElements('channel');
    var item = channel.first.findAllElements('item');
    _allNews = item
        .map(
          (e) => News(
            title: e.findElements('title').first.text,
            description: e.findElements('description').first.text,
            publishedDate: parseRfc822(e.findElements('pubDate').first.text),
            link: e.findElements('link').first.text,
            image: e.getElement('media:thumbnail')!.getAttribute('url'),
          ),
        )
        .toList();

    notifyListeners();
    return _allNews!;
  }


  Future<void> checkdatainiFirestore() async {
    await getAllNews();
    List? allLinks = [];
    await _firestore
        .collection('news')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        // Map<String, dynamic>? data  = doc.data() as Map<String, dynamic>?;
        Map data = doc.data() as Map;
        print(data['link']);
        allLinks.add(data['link']);
        // print(allLinks.length);
      }
    });
    print(allLinks.length);
    print('news ${allNews?.length}');
    for (var element in allNews!) {
      // print(element.title);
      if (!allLinks.contains(element.link)) {
        postNews(element);
      }
    }
  }

  Stream<List<News>> getAllNewsFromFirebase() {
    return _firestore
        .collection('news')
        .orderBy('publishedDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => News.fromJson(e.data())).toList());
  }

  Future<void> postNews(News news) async {
    final docNews = _firestore.collection('news').doc();
    final toPostNews = News(
      id: docNews.id,
      description: news.description,
      like: news.like,
      link: news.link,
      image: news.image,
      publishedDate: news.publishedDate,
      title: news.title,
    );
    await sendNotification(news.title!,news.description!,news.image!);
    docNews.set(toPostNews.toJson());
  }

  Future sendNotification (String title,String detail,String image) async{
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAA-EMUP80:APA91bHYTIaCNkxJXDqpkiwXbitc2wvVF16Qu4DaiNKmaqCE3Do4YtMZfbp-MSu7Y6YY2n7tyx5w_mlTMgi0T0NhGB-vc0tdWp49yRmfXZ1eRjku4txM4R1_Eg6r0rWS4FJkQ1Wx96CD',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': detail,
            'title': title,
            'image': image,
            'sound':'default'
          },
          'priority': 'normal',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "/topics/all",
        },
      ),
    );
  }






  Future<void> deleteNews(String id) async {
    _firestore.collection('news').doc(id).delete();
  }

  Future<void> postComment(String id, Comment comment) async {
    await _firestore.collection("news").doc(id).set({
      "comment": FieldValue.arrayUnion([
        comment.toJson(),
      ])
    }, SetOptions(merge: true));
  }

  Future<void> toggleLike(String id, String userId) async {
    var x = await _firestore.collection('news').doc(id).get();
    List<dynamic> like = x['like'];
    debugPrint(like.toString());
    if (!like.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(id).set({
        "like": FieldValue.arrayUnion([userId])
      }, SetOptions(merge: true));
    } else {
      await FirebaseFirestore.instance.collection("news").doc(id).set({
        "like": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    }
  }
}
