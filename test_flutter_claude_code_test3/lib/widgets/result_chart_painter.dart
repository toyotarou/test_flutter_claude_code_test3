import 'package:flutter/material.dart';

class ResultChartPainter extends CustomPainter {
  ResultChartPainter({
    required this.data,
    required this.maxVal,
    required this.dates,
  });

  final List<int> data;
  final int maxVal;
  final List<String> dates;

  @override
  void paint(Canvas canvas, Size size) {
    final chartTop = 8.0;
    final chartBottom = size.height;
    final chartHeight = chartBottom - chartTop;

    // Y座標を計算（1が上、20が下）
    double yFor(int result) {
      return chartTop + (result - 1) / (maxVal - 1) * chartHeight;
    }

    // X座標を計算
    double xFor(int index) {
      if (data.length == 1) return size.width / 2;
      return index / (data.length - 1) * size.width;
    }

    // グリッド線（横）
    final gridPaint = Paint()
      ..color = const Color(0x1AFFFFFF)
      ..strokeWidth = 1;

    for (var v = 1; v <= maxVal; v++) {
      final y = yFor(v);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);

      final tp = TextPainter(
        text: TextSpan(
          text: '$v',
          style: const TextStyle(color: Color(0x61FFFFFF), fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(-24, y - tp.height / 2));
    }

    // 折れ線
    final linePaint = Paint()
      ..color = const Color(0xFF53C0F0)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final linePath = Path();
    for (var i = 0; i < data.length; i++) {
      final x = xFor(i);
      final y = yFor(data[i]);
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
    }
    canvas.drawPath(linePath, linePaint);

    // ドット＋下部日付ラベル
    final showDateInterval =
        data.length <= 10 ? 1 : (data.length / 8).ceil();

    for (var i = 0; i < data.length; i++) {
      final x = xFor(i);
      final y = yFor(data[i]);
      final place = data[i];

      Color dotColor;
      if (place == 1) {
        dotColor = const Color(0xFFFFD700);
      } else if (place == 2) {
        dotColor = const Color(0xFFC0C0C0);
      } else if (place == 3) {
        dotColor = const Color(0xFFCD7F32);
      } else {
        dotColor = const Color(0xFF53C0F0);
      }

      canvas.drawCircle(
        Offset(x, y),
        5,
        Paint()..color = dotColor,
      );
      canvas.drawCircle(
        Offset(x, y),
        5,
        Paint()
          ..color = const Color(0x3DFFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

      // 日付ラベル（2行: 年 + 月-日）
      if (i % showDateInterval == 0 || i == data.length - 1) {
        final dateStr = i < dates.length ? dates[i] : '';
        final dateTp = TextPainter(
          text: TextSpan(
            text: dateStr,
            style: const TextStyle(color: Color(0x61FFFFFF), fontSize: 9, height: 1.3),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )..layout();
        dateTp.paint(
          canvas,
          Offset(x - dateTp.width / 2, chartBottom + 4),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
