import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../l10n/app_localizations.dart';
import 'labels.dart';

extension L10nX on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
  TextTheme get text => Theme.of(this).textTheme;

  void toast(String message) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));

  /// Laptop/desktop: side navigation, grids, two-column pages.
  bool get isWide => MediaQuery.sizeOf(this).width >= T.wideBreakpoint;
}

/// Centers content at the app's max width. Forms and single-thing screens
/// stay phone-width; [wide] screens (lists of cards, dashboards) use more of
/// a laptop screen.
class AppWidth extends StatelessWidget {
  const AppWidth({super.key, required this.child, this.wide = false});
  final Widget child;
  final bool wide;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: wide ? T.appWide : T.appMax),
      child: child,
    ),
  );
}

int _gridColumns(double width, double minTileWidth, double spacing) =>
    ((width + spacing) / (minTileWidth + spacing)).floor().clamp(1, 3);

Widget _gridRow(
  BuildContext context, {
  required int row,
  required int columns,
  required int itemCount,
  required double spacing,
  required IndexedWidgetBuilder itemBuilder,
}) => IntrinsicHeight(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var c = 0; c < columns; c++) ...[
        if (c > 0) SizedBox(width: spacing),
        Expanded(
          child: row * columns + c < itemCount
              ? itemBuilder(context, row * columns + c)
              : const SizedBox.shrink(),
        ),
      ],
    ],
  ),
);

/// Box version of [SliverCardGrid] for pages built as a single column.
class CardGrid extends StatelessWidget {
  const CardGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.minTileWidth = 330,
    this.spacing = 12,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double minTileWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = _gridColumns(
        constraints.maxWidth,
        minTileWidth,
        spacing,
      );
      final rows = (itemCount / columns).ceil();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var r = 0; r < rows; r++) ...[
            if (r > 0) SizedBox(height: spacing),
            if (columns == 1)
              itemBuilder(context, r)
            else
              _gridRow(
                context,
                row: r,
                columns: columns,
                itemCount: itemCount,
                spacing: spacing,
                itemBuilder: itemBuilder,
              ),
          ],
        ],
      );
    },
  );
}

/// Cards in as many columns (1–3) as fit [minTileWidth]; one column on a
/// phone. Tiles in a row share the tallest tile's height.
class SliverCardGrid extends StatelessWidget {
  const SliverCardGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.minTileWidth = 330,
    this.spacing = 14,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double minTileWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) => SliverLayoutBuilder(
    builder: (context, constraints) {
      final columns = _gridColumns(
        constraints.crossAxisExtent,
        minTileWidth,
        spacing,
      );
      if (columns == 1) {
        return SliverList.separated(
          itemCount: itemCount,
          separatorBuilder: (_, _) => SizedBox(height: spacing),
          itemBuilder: itemBuilder,
        );
      }
      return SliverList.separated(
        itemCount: (itemCount / columns).ceil(),
        separatorBuilder: (_, _) => SizedBox(height: spacing),
        itemBuilder: (context, row) => _gridRow(
          context,
          row: row,
          columns: columns,
          itemCount: itemCount,
          spacing: spacing,
          itemBuilder: itemBuilder,
        ),
      );
    },
  );
}

class TreatCard extends StatelessWidget {
  const TreatCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: T.card,
      borderRadius: BorderRadius.circular(T.radiusLg),
      border: Border.all(color: T.border),
      boxShadow: T.cardShadow,
    ),
    clipBehavior: Clip.antiAlias,
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    ),
  );
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(32),
      child: CircularProgressIndicator(color: T.accent),
    ),
  );
}

/// Error state with a retry button. Used on every screen that loads data.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_rounded, size: 40, color: T.inkTertiary),
          const SizedBox(height: 12),
          Text(context.l.errorTitle, style: context.text.titleMedium),
          const SizedBox(height: 6),
          Text(
            errorMessage(error, context.l),
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(context.l.retry),
          ),
        ],
      ),
    ),
  );
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    this.hint,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? hint;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: T.accentSoft,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: T.accent, size: 30),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: context.text.titleMedium,
          textAlign: TextAlign.center,
        ),
        if (hint != null) ...[
          const SizedBox(height: 6),
          Text(
            hint!,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
          ),
        ],
        if (action != null) ...[const SizedBox(height: 16), action!],
      ],
    ),
  );
}

enum PillTone { neutral, accent, green, amber, red }

class Pill extends StatelessWidget {
  const Pill(this.label, {super.key, this.tone = PillTone.neutral, this.icon});

  final String label;
  final PillTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      PillTone.neutral => (T.bgSecondary, T.inkSecondary),
      PillTone.accent => (T.accentSoft, T.accentInk),
      PillTone.green => (T.greenSoft, T.green),
      PillTone.amber => (T.amberSoft, T.amber),
      PillTone.red => (T.redSoft, T.red),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: context.text.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

/// Inline notice box (info / warning).
class Notice extends StatelessWidget {
  const Notice(this.text, {super.key, this.tone = PillTone.amber, this.icon});

  final String text;
  final PillTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      PillTone.green => (T.greenSoft, T.green),
      PillTone.red => (T.redSoft, T.red),
      PillTone.accent => (T.accentSoft, T.accentInk),
      _ => (T.amberSoft, T.amber),
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(T.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? Icons.info_outline_rounded, size: 18, color: fg),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: context.text.bodyMedium?.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section heading used inside screens.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(
      text.toUpperCase(),
      style: context.text.labelMedium?.copyWith(
        color: T.inkTertiary,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),
    ),
  );
}

/// Round avatar with initials, tinted per name.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.name, {super.key, this.size = 40});
  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    final hue = (name.codeUnits.fold<int>(0, (a, b) => a + b) * 37) % 360;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: HSLColor.fromAHSL(1, hue.toDouble(), 0.55, 0.9).toColor(),
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: size * 0.36,
          color: HSLColor.fromAHSL(1, hue.toDouble(), 0.5, 0.3).toColor(),
        ),
      ),
    );
  }
}
