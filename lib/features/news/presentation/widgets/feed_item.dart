import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/ui/widgets/texts.dart';
import '../../../../data_layer/model/articles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedItem extends StatelessWidget {
  final ArticleEntity article;
  final int index;
  const FeedItem({super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff1E1E1E),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                //image
                Hero(
                  tag: 'art_img$index',
                  child: Container(
                    width: 80,
                    height: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: (article.urlToImage != null)
                        ? CachedNetworkImage(
                            imageUrl: article.urlToImage!,
                            fit: BoxFit.cover,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:
                                SvgPicture.asset('assets/images/img_placeholder.svg'),
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                //source, title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText(article.source??article.author!,
                          color: Colors.grey, fontSize: 12),
                      const SizedBox(height: 4),
                      Expanded(
                        child: semiBoldText(article.title!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mediumText(formatDate(article.publishedAt!),
                    color: Colors.grey, fontSize: 10),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.grey,
                          size: 18,
                        )),
                    IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: Colors.grey,
                          size: 18,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
    return formattedDate;
  }
}
