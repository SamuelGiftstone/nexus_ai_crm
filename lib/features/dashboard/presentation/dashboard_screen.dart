// lib/features/dashboard/presentation/dashboard_screen.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import '../../../shared/widgets/status_badge.dart';
import '../data/dashboard_repository.dart';
import '../domain/dashboard_stats.dart';

// --- Dedicated Functional Destination Screens ---

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131316),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C24),
        title: const Text('All Tasks Stream', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          Text('Active Task Queue', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          // Add detailed task list components here
        ],
      ),
    );
  }
}

class ProjectSettingsScreen extends StatelessWidget {
  const ProjectSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131316),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C24),
        title: const Text('VinteX Project Workspace Settings', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Workspace Configuration', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Manage architectural parameters, team permissions, and integrations.', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class CopilotWorkspaceScreen extends StatelessWidget {
  final String initialPrompt;
  const CopilotWorkspaceScreen({super.key, required this.initialPrompt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131316),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C24),
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: AppColors.accentBlue, size: 20),
            SizedBox(width: 10),
            Text('Misso AI Copilot Workspace', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C24),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Context Triggered:', style: TextStyle(color: AppColors.accentBlue, fontSize: 11, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(initialPrompt, style: const TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1C1C24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type instructions for Misso...',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF131316),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: AppColors.accentLime, foregroundColor: Colors.black),
                  icon: const Icon(Icons.send, size: 18),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PdfExportScreen extends StatelessWidget {
  const PdfExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131316),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C24),
        title: const Text('PDF Document Generator', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weekly Summary Document', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Configure layout options and export compiled progress logs.', style: TextStyle(color: Colors.white54, fontSize: 13)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentLime,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PDF compiled and successfully downloaded to local filesystem.')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Download Compiled PDF', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClientProfileScreen extends StatelessWidget {
  final String clientName;
  const ClientProfileScreen({super.key, required this.clientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131316),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C24),
        title: Text(clientName, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client Details: $clientName', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Review deal pipeline, history, and active communication threads.', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

// --- Main Dashboard Screen ---

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardRepository _repository = DashboardRepository();
  late Future<DashboardStats> _statsFuture;

  static const double _cardRadius = 20;

  static final List<BoxShadow> _cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.28),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() {
    setState(() {
      _statsFuture = _repository.getDashboardStats();
    });
  }

  String _formatCurrency(num value) {
    final isNegative = value < 0;
    final digits = value.abs().round().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final remaining = digits.length - i;
      if (i > 0 && remaining % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return '${isNegative ? '-' : ''}\$$buffer';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131316),
      body: FutureBuilder<DashboardStats>(
        future: _statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentLime),
            );
          }

          final stats = snapshot.data ?? DashboardStats.empty();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: FadeSlideTransition(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top Bar: Greeting & Team Avatars
                  _buildHeader(context),
                  const SizedBox(height: 32),

                  // 2. Main 3-Column Desktop Workspace Grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- COLUMN 1: Project Selector, Productivity & Metrics (Width: 320px)
                      SizedBox(
                        width: 320,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProjectSelector(),
                            const SizedBox(height: 28),
                            _buildProductivitySection(stats),
                            const SizedBox(height: 28),
                            _buildProjectActivityCard(stats),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),

                      // --- COLUMN 2: Today's Tasks Stream (Expanded)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Today's Tasks",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const AllTasksScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'View all',
                                    style: TextStyle(color: AppColors.accentBlue, fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            // Task Card 1: Weekly Strategy Sync
                            _buildTaskCard(
                              icon: Icons.phone_in_talk,
                              title: 'Weekly Strategy Sync',
                              tag: 'Meeting',
                              tagColor: Colors.green,
                              details: [
                                _TaskDetailItem('When:', 'Today, 10:00 AM'),
                                _TaskDetailItem('Team:', 'Marketing & Growth'),
                                _TaskDetailItem('Reminder:', '15 min'),
                              ],
                              bottomWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 65,
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            for (int i = 0; i < 3; i++)
                                              Positioned(
                                                left: (i * 15).toDouble(),
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${40 + i}'),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Ready to join?', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2C2C35),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Connecting secure audio bridge for meeting...')),
                                      );
                                    },
                                    child: const Text('Join a meeting', style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Task Card 2: Design Review (High Priority)
                            _buildTaskCard(
                              icon: Icons.design_services,
                              title: 'Design Review',
                              tag: 'High Priority',
                              tagColor: Colors.redAccent,
                              details: [
                                _TaskDetailItem('Topic:', 'VinteX Website'),
                                _TaskDetailItem('Description:', 'Check the design of the main page'),
                                _TaskDetailItem('Deadline:', 'Mar 22'),
                              ],
                              bottomWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Performers: ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                      const SizedBox(width: 6),
                                      SizedBox(
                                        height: 22,
                                        width: 45,
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: const [
                                            Positioned(
                                              left: 0,
                                              child: CircleAvatar(radius: 11, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=50')),
                                            ),
                                            Positioned(
                                              left: 16,
                                              child: CircleAvatar(radius: 11, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=51')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const CopilotWorkspaceScreen(
                                            initialPrompt: 'Initialize design review workspace tools for VinteX Website checklist.',
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.auto_awesome, size: 14, color: AppColors.accentBlue),
                                    label: const Text('Ask AI to start', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),

                      // --- COLUMN 3: Quick Requests & Voice Tasks (Width: 320px)
                      SizedBox(
                        width: 320,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildQuickRequestsCard(),
                            const SizedBox(height: 20),
                            _buildVoiceTasksCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 4. Recent Contacts Table Card (Full Width Integration)
                  _buildRecentContactsCard(stats),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- HEADER BAR ---
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 1.5),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'Hi, Marco!',
              style: AppTypography.headingMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'Team:',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 28,
              width: 70,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  for (int i = 0; i < 3; i++)
                    Positioned(
                      left: (i * 18).toDouble(),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=${20 + i}',
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: const Text(
                '+9',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- PROJECT SELECTOR ---
  Widget _buildProjectSelector() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProjectSettingsScreen()),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C24),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accentLime.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.star, color: AppColors.accentLime, size: 18),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VinteX Project',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Design & Development',
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.settings_outlined, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }

  // --- PRODUCTIVITY SECTION ---
  Widget _buildProductivitySection(DashboardStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '85%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 64,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Today's productivity",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }

  // --- PROJECT ACTIVITY CARD ---
  Widget _buildProjectActivityCard(DashboardStats stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentLime,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Project Activity',
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Statistic',
                  style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _ActivityStat(value: '26h', label: 'Sync Calls'),
              _ActivityStat(value: '11h', label: 'Workshops'),
              _ActivityStat(value: '6h', label: 'Reviews'),
            ],
          ),
        ],
      ),
    );
  }

  // --- TASK CARD BUILDER ---
  Widget _buildTaskCard({
    required IconData icon,
    required String title,
    required String tag,
    required Color tagColor,
    required List<_TaskDetailItem> details,
    required Widget bottomWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C24),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  tag,
                  style: TextStyle(color: tagColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: details.map((d) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                  const SizedBox(height: 4),
                  Text(d.value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.white10, height: 1),
          ),
          bottomWidget,
        ],
      ),
    );
  }

  // --- QUICK REQUESTS CARD ---
  Widget _buildQuickRequestsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C24),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.bolt, color: AppColors.accentLime, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Quick requests',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CopilotWorkspaceScreen(initialPrompt: 'Create a custom task workflow rule...'),
                    ),
                  );
                },
                child: Text(
                  '+ Set Task',
                  style: TextStyle(color: AppColors.accentBlue, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildQuickRequestRow('Analyze the call summary and highlight the main topic points', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CopilotWorkspaceScreen(initialPrompt: 'Analyze the recent team call summaries and extract action items.'),
              ),
            );
          }),
          const Divider(color: Colors.white10, height: 24),
          _buildQuickRequestRow('Create a PDF document with completed tasks for the week', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PdfExportScreen()),
            );
          }),
          const Divider(color: Colors.white10, height: 24),
          _buildQuickRequestRow('Fix the Gantt chart according to the updated task data in project', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CopilotWorkspaceScreen(initialPrompt: 'Review project timeline and adjust the Gantt chart parameters.'),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQuickRequestRow(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }

  // --- VOICE TASKS CARD ---
  Widget _buildVoiceTasksCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C24),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Voice Tasks',
              style: TextStyle(color: AppColors.accentBlue, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Say something\nto Misso!',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(18, (index) {
                  return Container(
                    width: 3,
                    height: (10 + (index % 5) * 6).toDouble(),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CopilotWorkspaceScreen(initialPrompt: 'Listening to live voice transcription stream...'),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.accentLime,
                  child: Icon(Icons.mic, color: Colors.black, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- RECENT CONTACTS TABLE ---
  Widget _buildRecentContactsCard(DashboardStats stats) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C24),
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: Colors.white10),
        boxShadow: _cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Contacts', style: AppTypography.headingMedium.copyWith(color: Colors.white)),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CopilotWorkspaceScreen(initialPrompt: 'Display complete lead roster analytics and client profiles.'),
                    ),
                  );
                },
                child: Text(
                  'View All (${stats.recentLeads.length})',
                  style: AppTypography.bodySmallBold.copyWith(color: AppColors.accentLime),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (stats.recentLeads.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_search_rounded, color: Colors.white24, size: 32),
                    SizedBox(height: 8),
                    Text('No contacts available', style: TextStyle(color: Colors.white38)),
                  ],
                ),
              ),
            )
          else ...[
            _buildContactsHeaderRow(),
            const Divider(color: Colors.white10, height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.recentLeads.length,
              separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 20),
              itemBuilder: (context, index) {
                final lead = stats.recentLeads[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ClientProfileScreen(clientName: lead.fullName)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white10,
                          child: Text(
                            lead.firstName.isNotEmpty ? lead.firstName[0].toUpperCase() : '?',
                            style: const TextStyle(color: AppColors.accentLime, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          flex: 3,
                          child: Text(
                            lead.fullName,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            lead.company ?? 'Individual Contact',
                            style: const TextStyle(color: Colors.white38, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Center(
                            child: StatusBadge(
                              label: lead.status,
                              color: lead.status == 'Won' ? AppColors.success : AppColors.accentBlue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            _formatCurrency(lead.dealValue),
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactsHeaderRow() {
    final headerStyle = AppTypography.bodySmall.copyWith(
      color: Colors.white38,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.4,
    );
    return Row(
      children: [
        const SizedBox(width: 36 + AppSpacing.md),
        Expanded(flex: 3, child: Text('CONTACT', style: headerStyle)),
        Expanded(flex: 2, child: Text('COMPANY', style: headerStyle)),
        SizedBox(width: 90, child: Text('STATUS', style: headerStyle, textAlign: TextAlign.center)),
        SizedBox(width: 90, child: Text('DEAL VALUE', style: headerStyle, textAlign: TextAlign.right)),
      ],
    );
  }
}

class _ActivityStat extends StatelessWidget {
  final String value;
  final String label;

  const _ActivityStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 11),
        ),
      ],
    );
  }
}

class _TaskDetailItem {
  final String label;
  final String value;
  _TaskDetailItem(this.label, this.value);
}