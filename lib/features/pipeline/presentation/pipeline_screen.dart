// lib/features/pipeline/presentation/pipeline_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import 'widgets/pipeline_column.dart';

class PipelineScreen extends StatelessWidget {
  const PipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Action Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sales Pipeline', style: AppTypography.displayLarge),
                  Text(
                    'Track stage progression and revenue probabilities across active deals.',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Deal'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Kanban Horizontal Workspace
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    PipelineColumn(
                      stageName: 'Lead',
                      totalValue: '\$140,000',
                      count: 3,
                      deals: [
                        {
                          'title': 'SaaS Migration',
                          'company': 'Apex Corp',
                          'value': '\$45,000',
                          'probability': '20%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=1'
                        },
                        {
                          'title': 'Security Audit',
                          'company': 'Cyber Shield',
                          'value': '\$95,000',
                          'probability': '15%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=2'
                        },
                      ],
                    ),
                    PipelineColumn(
                      stageName: 'Qualified',
                      totalValue: '\$320,000',
                      count: 2,
                      deals: [
                        {
                          'title': 'Enterprise Suite',
                          'company': 'LogiTech Solutions',
                          'value': '\$220,000',
                          'probability': '40%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=3'
                        },
                        {
                          'title': 'Cloud Expansion',
                          'company': 'Aero Dynamics',
                          'value': '\$100,000',
                          'probability': '50%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=4'
                        },
                      ],
                    ),
                    PipelineColumn(
                      stageName: 'Proposal',
                      totalValue: '\$580,000',
                      count: 2,
                      deals: [
                        {
                          'title': 'Data Center Deal',
                          'company': 'Nexus Global',
                          'value': '\$450,000',
                          'probability': '75%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=5'
                        },
                        {
                          'title': 'Custom API Integration',
                          'company': 'Fintech Core',
                          'value': '\$130,000',
                          'probability': '80%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=6'
                        },
                      ],
                    ),
                    PipelineColumn(
                      stageName: 'Negotiation',
                      totalValue: '\$210,000',
                      count: 1,
                      deals: [
                        {
                          'title': 'Platform Licensing',
                          'company': 'Horizon Retail',
                          'value': '\$210,000',
                          'probability': '90%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=7'
                        },
                      ],
                    ),
                    PipelineColumn(
                      stageName: 'Won',
                      totalValue: '\$890,000',
                      count: 2,
                      deals: [
                        {
                          'title': 'Mobile Banking App',
                          'company': 'Metro Bank',
                          'value': '\$500,000',
                          'probability': '100%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=8'
                        },
                        {
                          'title': 'Infrastructure Overhaul',
                          'company': 'Alpha Tech',
                          'value': '\$390,000',
                          'probability': '100%',
                          'avatarUrl': 'https://i.pravatar.cc/300?img=9'
                        },
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}