import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cybehawks/auth/auth_bloc.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/models/news.dart';
import 'package:cybehawks/pages/comments_screen.dart';
import 'package:cybehawks/pages/login.dart';
import 'package:cybehawks/pages/news_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewsDetails(
              url: news.link!,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            news.image != null
                ? Hero(
                    tag: news.title!,
                    child: Image.network(
                      news.image!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.publishedDate.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffD6DDE2),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    news.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    news.description!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              if(FirebaseAuth.instance.currentUser == null) {
                                context.read<AuthBloc>().add(AuthLoginEvent());
                                return;
                              }
                              Share.share(
                                '''CybeHawks Cyber Update you may be interested in ''' +
                                    news.link!,
                                subject:
                                    'CybeHawks Cyber Update you may be interested in',
                              );
                            },
                            icon: Icon(
                              Icons.share,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              if(FirebaseAuth.instance.currentUser == null) {
                                context.read<AuthBloc>().add(AuthLoginEvent());
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CommentsScreen(news: news),
                                ),
                              );
                            },
                            icon: Icon(Icons.mode_comment_outlined),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor,
                              ),
                            ),
                            label: (news.comment!.length > 0)
                                ? Text(
                                    news.comment!.length.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox(),
                          )
                        ],
                      ),
                      const Spacer(),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('news')
                            .doc(news.id)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          bool liked = false;
                          if (snapshot.hasData) {
                            if (snapshot.data['like'].contains(
                                FirebaseAuth.instance.currentUser?.uid)) {
                              liked = true;
                            } else {
                              liked = false;
                            }
                          }
                          if (snapshot.hasData) {
                            return Container(
                              decoration: BoxDecoration(
                                color: liked
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  if(FirebaseAuth.instance.currentUser == null) {
                                    context.read<AuthBloc>().add(AuthLoginEvent());
                                    return;
                                  }
                                  await Provider.of<PostController>(context,
                                      listen: false)
                                      .toggleLike(
                                    news.id!,
                                    FirebaseAuth.instance.currentUser!.uid,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        snapshot.data['like'].length.toString(),
                                        style: TextStyle(
                                          color: liked
                                              ? Colors.white
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.thumb_up_alt_outlined,
                                        size: 20,
                                        color: liked
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }

                          else
                            return CircularProgressIndicator();
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
