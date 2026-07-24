// lib/features/copilot/presentation/copilot_screen.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../data/copilot_repository.dart';
import '../domain/copilot_message.dart';
import 'widgets/ai_response_card.dart';
import 'widgets/prompt_input_box.dart';
import 'widgets/quick_action_grid.dart';

class CopilotScreen extends StatefulWidget {
  final CopilotRepository? repository;

  const CopilotScreen({super.key, this.repository});

  @override
  State<CopilotScreen> createState() => _CopilotScreenState();
}

class _CopilotScreenState extends State<CopilotScreen> {
  late final CopilotRepository _repository;
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<CopilotMessage> _messages = [];
  bool _isProcessing = false;
  int _messageCounter = 0;
  String _selectedSidebarAction = 'Pipeline';

  static const List<_SidebarAction> _sidebarActions = [
    _SidebarAction(Icons.analytics_outlined, 'Pipeline', 'Analyze Pipeline'),
    _SidebarAction(Icons.cleaning_services_outlined, 'Duplicates', 'Check Duplicates'),
    _SidebarAction(Icons.insights_outlined, 'Insights', 'Find Stale Leads'),
  ];

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? CopilotRepository();
    _seedWelcomeMessage();
  }

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _seedWelcomeMessage() {
    _messages.add(
      CopilotMessage(
        id: 'welcome',
        content:
            "Hello! I am your AI CRM Copilot. I analyze your local SQLite contact database, provide pipeline intelligence, and help clean duplicate records.",
        sender: CopilotSender.assistant,
        timestamp: DateTime.now(),
        suggestedActions: const [
          'Analyze Pipeline',
          'Find Stale Leads',
          'Check Duplicates',
        ],
      ),
    );
  }

  /// Generates a collision-safe id even if multiple messages are created
  /// within the same millisecond.
  String _nextMessageId(String prefix) {
    _messageCounter += 1;
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}_$_messageCounter';
  }

  void _resetChat() {
    setState(() {
      _messages.clear();
      _promptController.clear();
      _isProcessing = false;
      _seedWelcomeMessage();
    });
  }

  Future<void> _handleSend([String? presetPrompt]) async {
    final query = presetPrompt ?? _promptController.text.trim();
    if (query.isEmpty || _isProcessing) return;

    _promptController.clear();

    final userMessage = CopilotMessage(
      id: _nextMessageId('msg_user'),
      content: query,
      sender: CopilotSender.user,
      timestamp: DateTime.now(),
    );

    final thinkingId = _nextMessageId('msg_thinking');
    final thinkingMessage = CopilotMessage(
      id: thinkingId,
      content: '',
      sender: CopilotSender.assistant,
      timestamp: DateTime.now(),
      isThinking: true,
    );

    setState(() {
      _messages.add(userMessage);
      _messages.add(thinkingMessage);
      _isProcessing = true;
    });

    _scrollToBottom();

    try {
      final response = await _repository.processPrompt(query);

      if (!mounted) return;
      setState(() {
        _messages.removeWhere((msg) => msg.id == thinkingId);
        _messages.add(response);
        _isProcessing = false;
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages.removeWhere((msg) => msg.id == thinkingId);
        _messages.add(
          CopilotMessage(
            id: _nextMessageId('msg_error'),
            content: "Error interacting with Gemma model: $e",
            sender: CopilotSender.assistant,
            timestamp: DateTime.now(),
          ),
        );
        _isProcessing = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final showQuickActions = _messages.length <= 1;

    return Scaffold(
      backgroundColor: const Color(0xFF090A0F),
      body: Row(
        children: [
          // 1. Sidebar
          _buildUltraSlimSidebar(),

          // Vertical divider line between sidebar and chat
          Container(width: 1, color: Colors.white.withOpacity(0.06)),

          // 2. Centered Chat Panel Workspace
          Expanded(
            child: Column(
              children: [
                _buildHeader(),

                // Message Stream Space (Centered, lazily built)
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        itemCount: _messages.length + (showQuickActions ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (showQuickActions && index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.auto_awesome,
                                        size: 12,
                                        color: AppColors.accentBlue,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'QUICK WORKFLOWS',
                                        style: AppTypography.bodySmallBold.copyWith(
                                          color: Colors.white38,
                                          fontSize: 9,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  QuickActionGrid(onActionSelected: _handleSend),
                                ],
                              ),
                            );
                          }

                          final msgIndex = showQuickActions ? index - 1 : index;
                          final msg = _messages[msgIndex];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: AiResponseCard(
                              message: msg,
                              onSuggestionTap: _handleSend,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // 3. Dense Input Bar (Centered)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111319),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.08)),
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: PromptInputBox(
                        controller: _promptController,
                        onSubmitted: () => _handleSend(),
                        isLoading: _isProcessing,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUltraSlimSidebar() {
    return Container(
      width: 170,
      color: const Color(0xFF111319),
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Title Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.bolt,
                    color: AppColors.accentBlue,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'CRM Copilot',
                  style: AppTypography.labelBold.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // New Chat Button
          SizedBox(
            width: double.infinity,
            height: 28,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _isProcessing ? null : _resetChat,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: _isProcessing
                        ? Colors.white10
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 14,
                        color: _isProcessing ? Colors.white38 : Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'New Chat',
                        style: TextStyle(
                          color: _isProcessing ? Colors.white38 : Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Sidebar Category Label
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              'SHORTCUTS',
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white38,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),

          // Action Items
          for (final action in _sidebarActions)
            _compactItem(
              action.icon,
              action.label,
              _selectedSidebarAction == action.label,
              onTap: () {
                setState(() => _selectedSidebarAction = action.label);
                _handleSend(action.prompt);
              },
            ),
        ],
      ),
    );
  }

  Widget _compactItem(
    IconData icon,
    String label,
    bool selected, {
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 26,
          margin: const EdgeInsets.symmetric(vertical: 1.5),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accentBlue.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: selected
                ? const Border(
                    left: BorderSide(color: AppColors.accentBlue, width: 2.5),
                  )
                : null,
          ),
          child: Row(
            children: [
              SizedBox(width: selected ? 6 : 8),
              Icon(
                icon,
                color: selected ? AppColors.accentBlue : Colors.white54,
                size: 13,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.white60,
                    fontSize: 10.5,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF111319),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Engine Status Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.accentLime.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accentLime.withOpacity(0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentLime,
                        blurRadius: 4,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'GEMMA 2B ENGINE',
                  style: AppTypography.bodySmallBold.copyWith(
                    color: AppColors.accentLime,
                    fontSize: 9,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Database Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.storage_outlined,
                  size: 11,
                  color: Colors.white54,
                ),
                const SizedBox(width: 4),
                Text(
                  'SQLite DB Connected',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white60,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarAction {
  final IconData icon;
  final String label;
  final String prompt;

  const _SidebarAction(this.icon, this.label, this.prompt);
}