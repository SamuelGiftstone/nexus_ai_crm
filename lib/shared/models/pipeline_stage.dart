// lib/shared/models/pipeline_stage.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum PipelineStage {
  lead('Lead', AppColors.accentBlue),
  qualified('Qualified', AppColors.accentPurple),
  proposal('Proposal', AppColors.warning),
  won('Won', AppColors.success),
  lost('Lost', AppColors.error);

  final String label;
  final Color color;

  const PipelineStage(this.label, this.color);

  static PipelineStage fromString(String stage) {
    return PipelineStage.values.firstWhere(
      (e) => e.label.toLowerCase() == stage.toLowerCase(),
      orElse: () => PipelineStage.lead,
    );
  }
}