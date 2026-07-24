// lib/features/contacts/presentation/contacts_screen.dart

import 'package:flutter/material.dart';
import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import '../../../shared/models/customer_model.dart';
import '../../../shared/widgets/status_badge.dart';
import '../data/contacts_repository.dart';
import '../domain/contact_filter.dart';
import 'widgets/contact_detail_drawer.dart';
import 'widgets/create_contact_dialog.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late final ContactsRepository repository;
  final TextEditingController _searchController = TextEditingController();

  ContactFilter _filter = const ContactFilter();
  List<CustomerModel> _contacts = [];
  CustomerModel? _selectedCustomer;
  bool _isLoading = true;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'label': 'All Contacts', 'icon': Icons.people_outline_rounded},
    {'label': 'Subscribers', 'icon': Icons.mail_outline_rounded},
    {'label': 'Unsubscribed', 'icon': Icons.block_rounded},
    {'label': 'All customers', 'icon': Icons.star_outline_rounded},
  ];

  @override
  void initState() {
    super.initState();
    repository = ContactsRepository(AppDatabase());
    _loadContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    setState(() => _isLoading = true);

    final contacts = await repository.getFilteredContacts(
      query: _filter.searchQuery,
      statusFilter: _filter.status,
    );

    if (mounted) {
      setState(() {
        _contacts = contacts.map((c) => CustomerModel(
          id: c.id,
          firstName: c.firstName,
          lastName: c.lastName,
          email: c.email,
          phone: c.phone,
          company: c.company,
          status: c.status,
          dealValue: c.dealValue,
          createdAt: c.createdAt,
        )).toList();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    _filter = _filter.copyWith(searchQuery: query);
    _loadContacts();
  }

  Future<void> _deleteContact(CustomerModel contact) async {
    if (contact.id != null) {
      await repository.deleteContact(contact.id!);
      setState(() => _selectedCustomer = null);
      _loadContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Navigation Bar & Global Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Contacts', style: AppTypography.displayLarge),
                          const SizedBox(width: AppSpacing.lg),
                          SizedBox(
                            width: 220,
                            height: 38,
                            child: TextField(
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              style: AppTypography.bodySmall,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textMuted,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  size: 18,
                                  color: AppColors.textMuted,
                                ),
                                suffixText: '⌘K',
                                suffixStyle: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textMuted,
                                ),
                                filled: true,
                                fillColor: AppColors.surfaceCard,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderSubtle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.notifications_none_rounded,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: const BorderSide(
                                color: AppColors.borderSubtle,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Text('Actions'),
                            label: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: const BorderSide(
                                color: AppColors.borderSubtle,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Text('Import'),
                            label: const Icon(
                              Icons.arrow_downward_rounded,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textPrimary,
                              foregroundColor: AppColors.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => CreateContactDialog(
                                  repository: repository,
                                  onContactCreated: _loadContacts,
                                ),
                              );
                            },
                            child: const Text('Create Contact'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // View Tabs Header Row
                  Row(
                    children: [
                      ..._tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tab = entry.value;
                        final isSelected = _selectedTab == index;

                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: InkWell(
                            onTap: () => setState(() => _selectedTab = index),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.sm,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.surfaceCard
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.borderSubtle
                                      : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    tab['icon'],
                                    size: 16,
                                    color: isSelected
                                        ? AppColors.textPrimary
                                        : AppColors.textMuted,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text(
                                    tab['label'],
                                    style: AppTypography.bodySmallBold.copyWith(
                                      color: isSelected
                                          ? AppColors.textPrimary
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textMuted,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add view (4/5)'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Filter Toolbar Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        _buildFilterDropdown('Contact owner'),
                        const SizedBox(width: AppSpacing.sm),
                        _buildFilterDropdown('Create data'),
                        const SizedBox(width: AppSpacing.sm),
                        _buildFilterDropdown('Last activity date'),
                        const SizedBox(width: AppSpacing.sm),
                        _buildFilterDropdown('Lead status', isHighlighted: true),
                        const SizedBox(width: AppSpacing.sm),
                        IconButton(
                          icon: const Icon(Icons.add, size: 16),
                          onPressed: () {},
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list, size: 16),
                          label: const Text('Filter'),
                        ),
                        const VerticalDivider(),
                        IconButton(
                          icon: const Icon(Icons.import_export, size: 16),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.view_column, size: 16),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Contacts Table Grid Container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: Column(
                        children: [
                          // Table Header
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.borderSubtle,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 24,
                                  child: Checkbox(value: false, onChanged: null),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  flex: 3,
                                  child: Text('Name',
                                      style: AppTypography.bodySmallBold),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('Email',
                                      style: AppTypography.bodySmallBold),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('Phone No',
                                      style: AppTypography.bodySmallBold),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('Company',
                                      style: AppTypography.bodySmallBold),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('Lead Status',
                                      style: AppTypography.bodySmallBold),
                                ),
                                const SizedBox(width: 40),
                              ],
                            ),
                          ),
                          // Table Rows
                          Expanded(
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.accentLime,
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: _contacts.length,
                                    separatorBuilder: (_, __) => const Divider(
                                      color: AppColors.borderSubtle,
                                      height: 1,
                                    ),
                                    itemBuilder: (context, index) {
                                      final contact = _contacts[index];
                                      final isSelected =
                                          _selectedCustomer?.id == contact.id;

                                      return InkWell(
                                        onTap: () => setState(() =>
                                            _selectedCustomer = contact),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppSpacing.lg,
                                            vertical: AppSpacing.sm,
                                          ),
                                          color: isSelected
                                              ? AppColors.accentLime
                                                  .withOpacity(0.08)
                                              : Colors.transparent,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 24,
                                                child: Checkbox(
                                                    value: false,
                                                    onChanged: null),
                                              ),
                                              const SizedBox(
                                                  width: AppSpacing.md),
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 14,
                                                      backgroundColor:
                                                          AppColors.surfaceDark,
                                                      child: Text(
                                                        contact.firstName
                                                                .isNotEmpty
                                                            ? contact.firstName[
                                                                    0]
                                                                .toUpperCase()
                                                            : '?',
                                                        style: AppTypography
                                                            .bodySmallBold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        width: AppSpacing.sm),
                                                    Text(
                                                      contact.fullName,
                                                      style: AppTypography
                                                          .bodySmallBold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  contact.email ?? '—',
                                                  style: AppTypography
                                                      .bodySmall
                                                      .copyWith(
                                                    color: AppColors
                                                        .textMuted,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  contact.phone ?? '—',
                                                  style: AppTypography
                                                      .bodySmall,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  contact.company ?? '—',
                                                  style: AppTypography
                                                      .bodySmall,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: StatusBadge(
                                                  label: contact.status,
                                                  color: contact.status ==
                                                          'Open Deal'
                                                      ? AppColors.success
                                                      : contact.status ==
                                                              'Negotiation'
                                                          ? AppColors.warning
                                                          : AppColors
                                                              .surfaceDark,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                  size: 16,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_selectedCustomer != null)
            FadeSlideTransition(
              child: ContactDetailDrawer(
                contact: _selectedCustomer!,
                onClose: () => setState(() => _selectedCustomer = null),
                onDelete: _deleteContact,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.surfaceDark.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isHighlighted ? AppColors.borderSubtle : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.bodySmall),
          const SizedBox(width: AppSpacing.xs),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 14),
        ],
      ),
    );
  }
}