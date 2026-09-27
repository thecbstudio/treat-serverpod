import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Counter view: scan the student's QR or type the backup code.
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final _code = TextEditingController();
  MobileScannerController? _camera;
  bool _busy = false;
  RedeemResult? _result;
  String? _error;

  @override
  void dispose() {
    _camera?.dispose();
    _code.dispose();
    super.dispose();
  }

  void _toggleCamera() {
    if (_camera == null) {
      setState(() {
        _camera = MobileScannerController(
          formats: const [BarcodeFormat.qrCode],
          detectionSpeed: DetectionSpeed.noDuplicates,
        );
        _result = null;
        _error = null;
      });
    } else {
      _camera!.dispose();
      setState(() => _camera = null);
    }
  }

  void _onDetect(BarcodeCapture capture) {
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null || _busy) return;
    _redeem(raw);
  }

  /// One request at a time: the camera keeps firing while the QR is in view.
  Future<void> _redeem(String input) async {
    if (_busy || input.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await client.shop.redeem(input);
      HapticFeedback.mediumImpact();
      _camera?.dispose();
      setState(() {
        _camera = null;
        _result = result;
        _code.clear();
      });
    } catch (e) {
      if (mounted) setState(() => _error = errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      body: SafeArea(
        child: AppWidth(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l.scanTitle, style: context.text.headlineMedium),
              const SizedBox(height: 4),
              Text(
                l.scanHint,
                style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
              ),
              const SizedBox(height: 16),
              if (_result != null)
                _ResultCard(
                  result: _result!,
                  onNext: () => setState(() => _result = null),
                )
              else ...[
                if (_camera != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(T.radiusLg),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MobileScanner(
                        controller: _camera,
                        onDetect: _onDetect,
                        errorBuilder: (context, error) => Container(
                          color: T.bgSecondary,
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Text(
                            l.scanCameraFail,
                            textAlign: TextAlign.center,
                            style: context.text.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _toggleCamera,
                  icon: Icon(
                    _camera == null
                        ? Icons.qr_code_scanner_rounded
                        : Icons.videocam_off_outlined,
                  ),
                  label: Text(
                    _camera == null ? l.scanCameraStart : l.scanCameraStop,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _code,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 6,
                  style: context.text.headlineSmall?.copyWith(letterSpacing: 6),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: l.scanManualLabel,
                    counterText: '',
                  ),
                  onSubmitted: _redeem,
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: _busy ? null : () => _redeem(_code.text),
                  child: _busy
                      ? const SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        )
                      : Text(l.scanCheck),
                ),
              ],
              if (_error != null) ...[
                const SizedBox(height: 12),
                Notice(_error!, tone: PillTone.red, icon: Icons.error_outline),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.onNext});
  final RedeemResult result;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final view = result.view;
    final already = result.alreadyRedeemed;
    return TreatCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: already ? T.amberSoft : T.greenSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(
              already ? Icons.info_outline_rounded : Icons.check_rounded,
              color: already ? T.amber : T.green,
              size: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            already ? l.scanAlready : l.scanSuccess,
            style: context.text.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InitialsAvatar(view.claim.studentName),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      view.claim.studentName,
                      style: context.text.titleMedium,
                    ),
                    Text(
                      view.offer.title,
                      style: context.text.bodyMedium?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onNext,
            icon: const Icon(Icons.qr_code_scanner_rounded),
            label: Text(l.scanNext),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          ),
        ],
      ),
    );
  }
}
