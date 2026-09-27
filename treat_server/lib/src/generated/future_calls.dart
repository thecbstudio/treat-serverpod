/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../future_calls/expire_claim_call.dart' as _ilqcuh3m;
import '../future_calls/verify_proof_call.dart' as _ipj1b90x;
import 'future_calls_generated_models/expire_claim_call_expire_model.dart'
    as _iizahf83;
import 'future_calls_generated_models/verify_proof_call_verify_model.dart'
    as _idz7zgl8;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'ExpireClaimCallExpireFutureCall': ExpireClaimCallExpireFutureCall(),
      'VerifyProofCallVerifyFutureCall': VerifyProofCallVerifyFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final expireClaimCall = _ExpireClaimCallFutureCallDispatcher(
    _invokeFutureCall,
  );

  late final verifyProofCall = _VerifyProofCallFutureCallDispatcher(
    _invokeFutureCall,
  );
}

class _ExpireClaimCallFutureCallDispatcher {
  _ExpireClaimCallFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> expire(int claimId) {
    var object = _iizahf83.ExpireClaimCallExpireModel(claimId: claimId);
    return _invokeFutureCall(
      'ExpireClaimCallExpireFutureCall',
      object,
    );
  }
}

class _VerifyProofCallFutureCallDispatcher {
  _VerifyProofCallFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> verify(int claimId) {
    var object = _idz7zgl8.VerifyProofCallVerifyModel(claimId: claimId);
    return _invokeFutureCall(
      'VerifyProofCallVerifyFutureCall',
      object,
    );
  }
}

class ExpireClaimCallExpireFutureCall
    extends _is.FutureCall<_iizahf83.ExpireClaimCallExpireModel>
    implements _is.InvokableFutureCall<_iizahf83.ExpireClaimCallExpireModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _iizahf83.ExpireClaimCallExpireModel? object,
  ) async {
    if (object != null) {
      await _ilqcuh3m.ExpireClaimCall().expire(
        session,
        object.claimId,
      );
    }
  }
}

class VerifyProofCallVerifyFutureCall
    extends _is.FutureCall<_idz7zgl8.VerifyProofCallVerifyModel>
    implements _is.InvokableFutureCall<_idz7zgl8.VerifyProofCallVerifyModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _idz7zgl8.VerifyProofCallVerifyModel? object,
  ) async {
    if (object != null) {
      await _ipj1b90x.VerifyProofCall().verify(
        session,
        object.claimId,
      );
    }
  }
}
