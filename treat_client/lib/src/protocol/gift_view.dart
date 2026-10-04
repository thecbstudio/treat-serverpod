/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:treat_client/src/protocol/protocol.dart' as _iu07tsrf;
import 'gift.dart' as _ihguimva;

/// A gift for one viewer: the sender never sees the code; `mine` tells which
/// side the viewer is.
abstract class GiftView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GiftView._({
    required this.gift,
    required this.viewerIsSender,
    required this.refundPending,
  });

  factory GiftView({
    required _ihguimva.Gift gift,
    required bool viewerIsSender,
    required bool refundPending,
  }) = _GiftViewImpl;

  factory GiftView.fromJson(Map<String, dynamic> jsonSerialization) {
    return GiftView(
      gift: _iu07tsrf.Protocol().deserialize<_ihguimva.Gift>(
        jsonSerialization['gift'],
      ),
      viewerIsSender: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['viewerIsSender'],
      ),
      refundPending: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['refundPending'],
      ),
    );
  }

  _ihguimva.Gift gift;

  bool viewerIsSender;

  /// Cancelled/expired and the refund hasn't gone through yet.
  bool refundPending;

  /// Returns a shallow copy of this [GiftView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GiftView copyWith({
    _ihguimva.Gift? gift,
    bool? viewerIsSender,
    bool? refundPending,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GiftView',
      'gift': gift.toJson(),
      'viewerIsSender': viewerIsSender,
      'refundPending': refundPending,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GiftView',
      'gift': gift.toJsonForProtocol(),
      'viewerIsSender': viewerIsSender,
      'refundPending': refundPending,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _GiftViewImpl extends GiftView {
  _GiftViewImpl({
    required _ihguimva.Gift gift,
    required bool viewerIsSender,
    required bool refundPending,
  }) : super._(
         gift: gift,
         viewerIsSender: viewerIsSender,
         refundPending: refundPending,
       );

  /// Returns a shallow copy of this [GiftView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GiftView copyWith({
    _ihguimva.Gift? gift,
    bool? viewerIsSender,
    bool? refundPending,
  }) {
    return GiftView(
      gift: gift ?? this.gift.copyWith(),
      viewerIsSender: viewerIsSender ?? this.viewerIsSender,
      refundPending: refundPending ?? this.refundPending,
    );
  }
}
