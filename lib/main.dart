import 'package:news_by_dax/api_manager.dart';
import 'package:news_by_dax/json_model.dart';
import 'package:flutter/material.dart';

import 'json_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TopUsNews(),
    );
  }
}

class TopUsNews extends StatefulWidget {
  const TopUsNews({Key? key}) : super(key: key);

  @override
  State<TopUsNews> createState() => _TopUsNewsState();
}

class _TopUsNewsState extends State<TopUsNews> {
  late Future<News> _news;

  @override
  void initState() {
    _news = apiManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News by DACHI'),
      ),
      body: Container(
        color: Colors.white60,
        child: FutureBuilder<News>(
          future: apiManager().getNews(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.articles.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 15,
                    // height: height * 0.2,
                    child: Row(
                      children: [
                        Image.network(
                          snapshot.data!.articles[index].urlToImage,
                          height: height * 0.08,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.articles[index].title,
                                softWrap: true,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                color: Colors.black,
                                height: 2,
                              ),
                              Text(
                                snapshot.data!.articles[index].content,
                                softWrap: true,
                                overflow: null,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
