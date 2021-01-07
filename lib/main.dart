import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => NewsBloc()..add(FetchNews()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          BlocBuilder<NewsBloc, NewsState>(
            builder: (_, newsState) {
              if (newsState is NewsLoaded) {
                List<News> newsData = newsState.news.sublist(0, 1);
                return Center(
                  child: NewsCard(
                    urlToImg: newsData[0].urlToImage,
                    title: newsData[0].title,
                  ),
                );
              }
            },
          ),
          Center(
            child: Wrap(
              children: [
                CategoryChip(
                  categoryText: 'Bisnis',
                ),
                CategoryChip(
                  categoryText: 'Entertainment',
                ),
                CategoryChip(
                  categoryText: 'Kesehatan',
                ),
                CategoryChip(
                  categoryText: 'Science',
                ),
                CategoryChip(
                  categoryText: 'Olahraga',
                ),
                CategoryChip(
                  categoryText: 'Technology',
                ),
              ],
            ),
          ),
          BlocBuilder<NewsBloc, NewsState>(
            builder: (_, newsState) {
              if (newsState is NewsLoaded) {
                List<News> newsData = newsState.news.sublist(2, 20);
                return ListView.builder(
                  itemCount: newsData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        newsData[index].urlToImage),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    newsData[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    newsData[index].description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    newsData[index].publishedAt,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String urlToImg;
  final String title;

  const NewsCard({Key key, this.urlToImg, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(urlToImg), fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 120, 15, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String categoryText;

  CategoryChip({this.categoryText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Chip(
        label: Text(
          categoryText,
          style: TextStyle(color: Colors.lightBlue),
        ),
        backgroundColor: Colors.lightBlue.withOpacity(0.3),
      ),
    );
  }
}
