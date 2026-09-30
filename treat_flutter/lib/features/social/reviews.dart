import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../student/rate_card.dart' show Stars;

/// The treat score: big average, star count and a 5★…1★ bar chart.
class ScoreSummary extends StatelessWidget {
  const ScoreSummary({super.key, required this.rating});
  final ShopRating rating;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final max = rating.distribution.fold<int>(0, (a, b) => b > a ? b : a);
    return TreatCard(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                rating.count == 0 ? '–' : rating.average.toStringAsFixed(1),
                style: context.text.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Stars(value: rating.average.round(), size: 16),
              const SizedBox(height: 2),
              Text(
                l.reviewCount(rating.count),
                style: context.text.labelSmall?.copyWith(
                  color: T.inkSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              children: [
                for (var star = 5; star >= 1; star--)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 14,
                          child: Text(
                            '$star',
                            style: context.text.labelSmall,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: max == 0
                                  ? 0
                                  : rating.distribution[star - 1] / max,
                              minHeight: 6,
                              color: T.star,
                              backgroundColor: T.bgHover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One rated visit. [Review.privateNote] only arrives for the place itself.
class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final note = review.privateNote;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.push('/student/${review.studentId}'),
            borderRadius: BorderRadius.circular(99),
            child: InitialsAvatar(review.studentName),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        review.studentName,
                        style: context.text.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Stars(value: review.rating, size: 14),
                  ],
                ),
                Text(
                  '${l.reviewVerified} · ${review.offerTitle} · '
                  '${istanbulDate(review.ratedAt)}',
                  style: context.text.labelSmall?.copyWith(
                    color: T.inkTertiary,
                  ),
                ),
                if (review.review != null) ...[
                  const SizedBox(height: 4),
                  Text(review.review!, style: context.text.bodyMedium),
                ],
                if (note != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: T.amberSoft,
                      borderRadius: BorderRadius.circular(T.radiusSm),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lock_outline_rounded,
                          size: 14,
                          color: T.amber,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '$note  ·  ${l.dashPrivateNote}',
                            style: context.text.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Score + newest reviews (place page and business panel).
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
    super.key,
    required this.title,
    required this.rating,
    required this.reviews,
  });
  final String title;
  final ShopRating rating;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SectionTitle(title),
      ScoreSummary(rating: rating),
      if (reviews.isEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            context.l.reviewsEmpty,
            style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
          ),
        )
      else
        for (final r in reviews) ReviewTile(review: r),
    ],
  );
}
