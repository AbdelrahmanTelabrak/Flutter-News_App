import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/presentation/bloc/articles/local/local_article_bloc.dart';
import 'package:news_app/ui/widgets/texts.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';

class ArticleDetailsActivity extends StatefulWidget {
  final ArticleEntity article;
  final String category;
  final int index;

  const ArticleDetailsActivity({super.key,
    required this.article,
    required this.category,
    required this.index});

  @override
  State<ArticleDetailsActivity> createState() => _ArticleDetailsActivityState();
}

class _ArticleDetailsActivityState extends State<ArticleDetailsActivity> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocalArticleBloc>(),
      child: Scaffold(
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
              onPressed: () {
                BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article: widget.article));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color(0xff1E1E1E),
                    content: Text('Article saved successfully'),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.bookmark_border_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
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
                  tag: 'art_img${widget.index}',
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: (widget.article.urlToImage != null)
                        ? CachedNetworkImage(
                      imageUrl: widget.article.urlToImage!,
                      fit: BoxFit.cover,
                    )
                        : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                          height: 100,
                          child: SvgPicture.asset(
                              'assets/images/img_placeholder.svg')),
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
                        semiBoldText(widget.category.toUpperCase(),
                            fontSize: 14, color: const Color(0xffBDA6F5)),
                        const SizedBox(height: 8),
                        boldText(widget.article.title!, fontSize: 20),
                        const SizedBox(height: 8),
                        mediumText(
                            widget.article.source ?? widget.article.author!,
                            fontSize: 14,
                            color: const Color(0xffB8B8B8)),
                        const SizedBox(height: 12),
                        mediumText(formatDate(widget.article.publishedAt!),
                            fontSize: 12, color: const Color(0xff888888)),
                        const SizedBox(height: 12),
                        IconButton(
                          icon: const Icon(
                            Icons.link,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              setState(() {
                                launchUrl(
                                  Uri.parse(widget.article.url!),
                                  mode: LaunchMode.inAppBrowserView,
                                );
                              }),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                    /// Description
                    mediumText(
                      (widget.article.description != null)
                          ? widget.article.description!
                          : "...",
                      fontSize: 14,
                      color: const Color(0xffB8B8B8),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate =
    DateFormat('MMM d, yyyy, hh:mm a "GMT"Z').format(dateTime);
    return formattedDate;
  }
}
