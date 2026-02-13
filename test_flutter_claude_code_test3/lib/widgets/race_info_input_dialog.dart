import 'package:flutter/material.dart';

import 'race_analysis_result_dialog.dart';

class RaceInfoInputDialog extends StatefulWidget {
  const RaceInfoInputDialog({super.key});

  @override
  State<RaceInfoInputDialog> createState() => _RaceInfoInputDialogState();
}

class _RaceInfoInputDialogState extends State<RaceInfoInputDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F3460), Color(0xFF16213E)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Text(
              'レース情報入力',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'レース情報を入力...',
                  hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                  filled: true,
                  fillColor: const Color(0xFF16213E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final names = _controller.text
                      .split('\n')
                      .map((l) => l.trim())
                      .where((l) => l.isNotEmpty)
                      .toList();
                  if (names.isEmpty) return;
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => RaceAnalysisResultDialog(horseNames: names),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3460),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '入力',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
