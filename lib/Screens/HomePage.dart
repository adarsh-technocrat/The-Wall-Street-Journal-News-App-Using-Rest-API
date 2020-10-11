import 'package:flutter/material.dart';
import 'package:newsapp/Models/newsInfo.dart';
import 'package:newsapp/services/apiManager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiManager apiManager = ApiManager();

  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = apiManager.getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "THE WALL STREER JOURNAL",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
            future: _newsModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, int index) {
                    var article = snapshot.data.articles[index];
                    return Card(
                      elevation: 10,
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    article.urlToImage != null
                                        ? article.urlToImage
                                        : "https://medifactia.com/wp-content/uploads/2018/01/placeholder.pn",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  // color: Colors.black,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          article.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          article.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {})
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
