import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// A shared post: the screenshot, who posted it and their thank-you note.
class WallPostTile extends StatelessWidget {
  const WallPostTile({super.key, required this.post, this.showShop = false});
  final WallPost post;
  final bool showShop;

  @override
  Widget build(BuildContext context) => Material(
    color: T.card,
    borderRadius: BorderRadius.circular(T.radiusMd),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => showWallPost(context, post),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              post.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: T.bgSecondary,
                child: const Icon(Icons.image_outlined, color: T.inkTertiary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  showShop ? post.shopName : post.studentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelLarge,
                ),
                Text(
                  post.thanksNote ?? post.proofType.label(context.l),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showWallPost(BuildContext context, WallPost post) =>
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 760),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: InteractiveViewer(
                  child: Image.network(post.imageUrl, fit: BoxFit.contain),
                ),
              ),
              ListTile(
                leading: InitialsAvatar(post.studentName),
                title: Text(post.studentName),
                subtitle: Text(
                  '${post.university} · ${post.shopName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/student/${post.studentId}');
                },
              ),
              if (post.thanksNote != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Notice(
                    '“${post.thanksNote}”',
                    tone: PillTone.accent,
                    icon: Icons.favorite_border_rounded,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

/// Grid of posts (place page, student profile).
class WallGrid extends StatelessWidget {
  const WallGrid({super.key, required this.posts, this.showShop = false});
  final List<WallPost> posts;
  final bool showShop;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Text(
        context.l.wallEmpty,
        style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, i) =>
          WallPostTile(post: posts[i], showShop: showShop),
    );
  }
}

/// Discover's "Fresh on the wall" row: the latest shared posts anywhere.
class FreshWallStrip extends StatefulWidget {
  const FreshWallStrip({super.key});

  @override
  State<FreshWallStrip> createState() => _FreshWallStripState();
}

class _FreshWallStripState extends State<FreshWallStrip> {
  late final Future<List<WallPost>> _future = client.social.recentPosts();

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _future,
    builder: (context, snap) {
      final posts = snap.data;
      // Optional extra: stay quiet on errors and while empty.
      if (posts == null || posts.isEmpty) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l.wallFreshTitle, style: context.text.titleLarge),
          const SizedBox(height: 10),
          SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, i) => SizedBox(
                width: 140,
                child: WallPostTile(post: posts[i], showShop: true),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    },
  );
}
