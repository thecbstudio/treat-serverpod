import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../client.dart';
import '../features/auth/onboarding_screen.dart';
import '../features/auth/sign_in_screen.dart';
import '../features/auth/welcome_screen.dart';
import '../features/shop/dashboard_screen.dart';
import '../features/shop/offer_form_screen.dart';
import '../features/shop/scan_screen.dart';
import '../features/shop/shop_offers_screen.dart';
import '../features/shop/shop_profile_screen.dart';
import '../features/student/claim_screen.dart';
import '../features/student/discover_screen.dart';
import '../features/student/leaderboard_screen.dart';
import '../features/student/my_claims_screen.dart';
import '../features/student/offer_detail_screen.dart';
import '../features/student/profile_screen.dart';
import '../ui/widgets.dart';
import 'session.dart';

const _publicPaths = {'/welcome', '/sign-in'};

final router = GoRouter(
  initialLocation: '/discover',
  refreshListenable: appSession,
  redirect: (context, state) {
    final path = state.uri.path;
    final isPublic = _publicPaths.contains(path);
    // Where the user was heading before a gate screen (deep links, refresh).
    final from = state.uri.queryParameters['from'];
    String gate(String to) => Uri(
      path: to,
      queryParameters: {'from': from ?? state.uri.toString()},
    ).toString();
    String? resume(String fallback, bool Function(String) allowed) {
      if (from != null) {
        final target = Uri.parse(from).path;
        if (!_isGate(target) &&
            !_publicPaths.contains(target) &&
            allowed(target)) {
          return from;
        }
      }
      return fallback;
    }

    switch (appSession.status) {
      case SessionStatus.loading:
        return path == '/loading' ? null : gate('/loading');
      case SessionStatus.error:
        return path == '/session-error' ? null : gate('/session-error');
      case SessionStatus.signedOut:
        return isPublic ? null : '/welcome';
      case SessionStatus.needsRole:
        return path == '/onboarding' ? null : '/onboarding';
      case SessionStatus.student:
        if (isPublic || _isGate(path)) {
          return resume('/discover', (p) => !_isShopPath(p));
        }
        return _isShopPath(path) ? '/discover' : null;
      case SessionStatus.shop:
        // Shops can still open offer pages (e.g. to preview their own).
        if (isPublic || _isGate(path)) {
          return resume('/shop/scan', (p) => !_isStudentOnly(p));
        }
        return _isStudentOnly(path) ? '/shop/scan' : null;
    }
  },
  routes: [
    GoRoute(path: '/', redirect: (_, _) => '/discover'),
    GoRoute(path: '/loading', builder: (_, _) => const SplashScreen()),
    GoRoute(
      path: '/session-error',
      builder: (context, _) => Scaffold(
        body: ErrorView(
          error: appSession.error ?? 'unknown',
          onRetry: appSession.refresh,
        ),
      ),
    ),
    GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
    GoRoute(
      path: '/sign-in',
      builder: (_, state) =>
          SignInScreen(register: state.uri.queryParameters['mode'] != 'login'),
    ),
    GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
    ShellRoute(
      builder: (context, state, child) => _NavShell(
        location: state.uri.path,
        tabs: const [
          _Tab('/discover', Icons.explore_outlined, Icons.explore),
          _Tab(
            '/claims',
            Icons.confirmation_number_outlined,
            Icons.confirmation_number,
          ),
          _Tab(
            '/leaderboard',
            Icons.emoji_events_outlined,
            Icons.emoji_events,
          ),
          _Tab('/me', Icons.person_outline_rounded, Icons.person_rounded),
        ],
        child: child,
      ),
      routes: [
        GoRoute(path: '/discover', builder: (_, _) => const DiscoverScreen()),
        GoRoute(path: '/claims', builder: (_, _) => const MyClaimsScreen()),
        GoRoute(
          path: '/leaderboard',
          builder: (_, _) => const LeaderboardScreen(),
        ),
        GoRoute(path: '/me', builder: (_, _) => const ProfileScreen()),
      ],
    ),
    GoRoute(
      path: '/claim/:id',
      builder: (_, state) =>
          ClaimScreen(claimId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/offer/:id',
      builder: (_, state) =>
          OfferDetailScreen(offerId: int.parse(state.pathParameters['id']!)),
    ),
    ShellRoute(
      builder: (context, state, child) => _NavShell(
        location: state.uri.path,
        tabs: const [
          _Tab(
            '/shop/scan',
            Icons.qr_code_scanner_rounded,
            Icons.qr_code_scanner_rounded,
          ),
          _Tab('/shop/panel', Icons.insights_outlined, Icons.insights),
          _Tab('/shop/offers', Icons.local_offer_outlined, Icons.local_offer),
          _Tab('/shop/profile', Icons.storefront_outlined, Icons.storefront),
        ],
        child: child,
      ),
      routes: [
        GoRoute(path: '/shop/scan', builder: (_, _) => const ScanScreen()),
        GoRoute(
          path: '/shop/panel',
          builder: (_, _) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/shop/offers',
          builder: (_, _) => const ShopOffersScreen(),
        ),
        GoRoute(
          path: '/shop/profile',
          builder: (_, _) => const ShopProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/shop/offers/new',
      builder: (_, _) => const OfferFormScreen(),
    ),
    GoRoute(
      path: '/shop/offers/:id/edit',
      builder: (_, state) => state.extra is Offer
          ? OfferFormScreen(offer: state.extra as Offer)
          : _EditOfferLoader(int.parse(state.pathParameters['id']!)),
    ),
  ],
);

bool _isShopPath(String p) => p.startsWith('/shop');
bool _isStudentOnly(String p) =>
    p == '/discover' ||
    p == '/me' ||
    p == '/claims' ||
    p == '/leaderboard' ||
    p.startsWith('/claim/');
bool _isGate(String p) =>
    p == '/loading' || p == '/session-error' || p == '/onboarding';

class _Tab {
  const _Tab(this.path, this.icon, this.selectedIcon);
  final String path;
  final IconData icon;
  final IconData selectedIcon;
}

class _NavShell extends StatelessWidget {
  const _NavShell({
    required this.location,
    required this.tabs,
    required this.child,
  });

  final String location;
  final List<_Tab> tabs;
  final Widget child;

  String _label(BuildContext context, String path) => switch (path) {
    '/discover' => context.l.navDiscover,
    '/me' => context.l.navProfile,
    '/claims' => context.l.navMyTreats,
    '/shop/scan' => context.l.navScan,
    '/shop/panel' => context.l.navPanel,
    '/leaderboard' => context.l.navLeaderboard,
    '/shop/offers' => context.l.navOffers,
    _ => context.l.navBusiness,
  };

  @override
  Widget build(BuildContext context) {
    final index = tabs.indexWhere((t) => location.startsWith(t.path));
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index < 0 ? 0 : index,
        onDestinationSelected: (i) => context.go(tabs[i].path),
        destinations: [
          for (final t in tabs)
            NavigationDestination(
              icon: Icon(t.icon),
              selectedIcon: Icon(t.selectedIcon),
              label: _label(context, t.path),
            ),
        ],
      ),
    );
  }
}

/// Deep link / refresh on the edit page: `extra` is gone, so fetch the offer.
class _EditOfferLoader extends StatefulWidget {
  const _EditOfferLoader(this.offerId);
  final int offerId;

  @override
  State<_EditOfferLoader> createState() => _EditOfferLoaderState();
}

class _EditOfferLoaderState extends State<_EditOfferLoader> {
  late Future<Offer> _future = _load();

  Future<Offer> _load() async {
    final cards = await client.shopOffers.listMine();
    return cards.firstWhere((c) => c.offer.id == widget.offerId).offer;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _future,
    builder: (context, snap) {
      if (snap.hasError) {
        return Scaffold(
          body: ErrorView(
            error: snap.error!,
            onRetry: () => setState(() => _future = _load()),
          ),
        );
      }
      if (!snap.hasData) return const Scaffold(body: LoadingView());
      return OfferFormScreen(offer: snap.data);
    },
  );
}
