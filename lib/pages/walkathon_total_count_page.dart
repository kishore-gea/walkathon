import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/animater_text.dart';

import '../style/text_style.dart';

class WalkathonTotalStepCountPage extends StatefulWidget {
  const WalkathonTotalStepCountPage({super.key, required this.targetValue});

  /// Grand total (Season 1 + Season 2) — kept for backward compat.
  final int targetValue;

  @override
  State<WalkathonTotalStepCountPage> createState() =>
      _WalkathonTotalStepCountPageState();
}

class _WalkathonTotalStepCountPageState
    extends State<WalkathonTotalStepCountPage> {
  int _selectedSeason = StepCountData.currentSeason;

  /// Compute the total steps for a season by summing the relevant fields.
  int _computeSeasonTotal(int season) {
    int total = 0;
    final months = StepCountData.getSeasonMonths(season);
    for (final participant in StepCountData.originalData) {
      for (final m in months) {
        final code = m['code'] as int;
        total += int.tryParse(StepCountData.getMonthValue(participant, code)) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final season1Total = _computeSeasonTotal(1);
    final season2Total = _computeSeasonTotal(2);
    final displayTotal = _selectedSeason == 1 ? season1Total : season2Total;

    final seasonLabel = _selectedSeason == 1
        ? "Season 1  ( Mar'25 – Feb'26 )"
        : "Season 2  ( Mar'26 onwards )";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OVERALL STATUS',
          style: AppTextStyles.headline.copyWith(
            color: AppTextStyles.primaryBlue,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Logos ────────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/ge.png', width: 120, height: 150),
                  kIsWeb
                      ? Image.asset('assets/images/wwlogo.png',
                          width: 150, height: 175)
                      : const SizedBox(),
                  Image.asset('assets/images/wellwithin.png',
                      width: 120, height: 150),
                ],
              ),

              // ── Title ─────────────────────────────────────────────────
              Text(
                'WELLNESS WALKATHON',
                textAlign: TextAlign.center,
                style: AppTextStyles.headline.copyWith(
                  color: AppTextStyles.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),

              // ── Season toggle ─────────────────────────────────────────
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: AppTextStyles.primaryBlue, width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final entry in const [
                      {'season': 1, 'label': "Season 1\nMar'25 – Feb'26"},
                      {'season': 2, 'label': "Season 2\nMar'26 onwards"},
                    ])
                      GestureDetector(
                        onTap: () => setState(
                            () => _selectedSeason = entry['season'] as int),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedSeason == entry['season']
                                ? AppTextStyles.primaryBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            entry['label'] as String,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.headline.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _selectedSeason == entry['season']
                                  ? Colors.white
                                  : AppTextStyles.primaryBlue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ── Season subtitle ───────────────────────────────────────
              const SizedBox(height: 16),
              Text(
                'TOTAL STEP COUNT  •  $seasonLabel',
                textAlign: TextAlign.center,
                style: AppTextStyles.headline.copyWith(
                  color: AppTextStyles.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),

              // ── Animated counter ──────────────────────────────────────
              const SizedBox(height: 40),
              AnimatedCounter(
                key: ValueKey(_selectedSeason),
                targetValue: displayTotal.toDouble(),
                duration: const Duration(seconds: 20),
                style: TextStyle(
                  color: AppTextStyles.primaryBlue,
                  fontSize: 130,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // ── Season breakdown chips ────────────────────────────────
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _seasonChip("Season 1", season1Total, 1),
                  _seasonChip("Season 2", season2Total, 2),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seasonChip(String label, int total, int season) {
    final isSelected = _selectedSeason == season;
    return GestureDetector(
      onTap: () => setState(() => _selectedSeason = season),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTextStyles.primaryBlue : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTextStyles.primaryBlue, width: 2),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppTextStyles.primaryBlue,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppTextStyles().formatIndianNumber(total),
              style: AppTextStyles.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppTextStyles.primaryBlue,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
