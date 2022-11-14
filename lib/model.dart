class NewsModel {
  late String newsHead;
  late String newsDes;
  late String newsImg;
  late String newsUrl;
  NewsModel(
      {this.newsHead = "NEWS HEADLINE",
      this.newsDes = "SOME NEWS",
      this.newsImg = "SOME IMAGE",
      this.newsUrl = "SOME URL"});

  factory NewsModel.fromMap(Map news) {
    return NewsModel(
        newsHead: news["title"],
        newsDes: news["description"],
        newsImg: news["urlToImage"],
        newsUrl: news["url"]);
  }
}
