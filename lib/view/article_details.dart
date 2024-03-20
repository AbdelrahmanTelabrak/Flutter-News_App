import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news_app/common/widgets/texts.dart';
import 'package:news_app/model/articles.dart';

class ArticleDetailsActivity extends StatelessWidget {
  final Articles article;
  final String category;
  final int index;
  const ArticleDetailsActivity({super.key, required this.article, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded, 
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.bookmark_border_rounded,
              color: Colors.white,
            ),
          ),IconButton(
            onPressed: (){},
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 0,
              child: Hero(
                tag: 'art_img$index',
                createRectTween: (begin, end) {
                  return MaterialRectCenterArcTween(begin: begin, end: end);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: (article.urlToImage != null)
                      ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                  )
                      : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                    SizedBox(height: 100, child: SvgPicture.asset('assets/images/img_placeholder.svg')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title ---- Category ---- Source ---- Date ---- Links
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      semiBoldText(category.toUpperCase(), fontSize: 14, color: const Color(0xffBDA6F5)),
                      const SizedBox(height: 8),
                      boldText(article.title!, fontSize: 20),
                      const SizedBox(height: 8),
                      mediumText(article.source!.name!, fontSize: 14, color: const Color(0xffB8B8B8)),
                      const SizedBox(height: 12),
                      mediumText(formatDate(article.publishedAt!), fontSize: 12, color: const Color(0xff888888)),
                      const SizedBox(height: 12),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.link_rounded, size: 20, color: Color(0xffCFCFCF)),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  /// Description
                  mediumText(
                      (article.description != null)? article.description! : "...",
                      fontSize: 14,
                      color: const Color(0xffB8B8B8),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMM d, yyyy, hh:mm a "GMT"Z').format(dateTime);
    return formattedDate;
  }
}
