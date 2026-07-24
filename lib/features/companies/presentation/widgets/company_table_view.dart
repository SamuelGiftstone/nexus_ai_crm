import 'package:flutter/material.dart';
import '../../domain/models/company_model.dart';

class CompanyTableView extends StatefulWidget {
  final List<CompanyModel> companies;
  final Function(CompanyModel)? onCompanyTap;
  final Function(CompanyModel)? onEditCompany;
  final Function(CompanyModel)? onDeleteCompany;

  const CompanyTableView({
    super.key,
    required this.companies,
    this.onCompanyTap,
    this.onEditCompany,
    this.onDeleteCompany,
  });

  @override
  State<CompanyTableView> createState() => _CompanyTableViewState();
}

class _CompanyTableViewState extends State<CompanyTableView> {
  int? _hoveredIndex;
  String? _selectedCompanyId;

  @override
  Widget build(BuildContext context) {
    if (widget.companies.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141419),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF24242D)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            // Table Column Headers
            _buildTableHeader(),
            const Divider(color: Color(0xFF24242D), height: 1),

            // Scrollable Data Rows
            Expanded(
              child: ListView.separated(
                itemCount: widget.companies.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: Color(0xFF1F1F28), height: 1),
                itemBuilder: (context, index) {
                  final company = widget.companies[index];
                  final isHovered = _hoveredIndex == index;
                  final isSelected = _selectedCompanyId == company.id;

                  return MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = index),
                    onExit: (_) => setState(() => _hoveredIndex = null),
                    child: InkWell(
                      onTap: () {
                        setState(() => _selectedCompanyId = company.id);
                        if (widget.onCompanyTap != null) {
                          widget.onCompanyTap!(company);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        color: isSelected
                            ? const Color(0xFF2F66FF).withOpacity(0.12)
                            : isHovered
                                ? const Color(0xFF1B1B22)
                                : Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            // Company Name & Domain
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  _buildCompanyAvatar(company.name),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          company.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          company.domain,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Industry Tag
                            Expanded(
                              flex: 2,
                              child: Text(
                                company.industry,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            // Contact Count
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.people_outline_rounded,
                                    size: 14,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${company.contactCount}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Status Badge
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _buildStatusBadge(company.status),
                              ),
                            ),

                            // Annual Revenue
                            Expanded(
                              flex: 2,
                              child: Text(
                                company.revenue,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            // Quick Actions Menu
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  color: isHovered
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  size: 18,
                                ),
                                color: const Color(0xFF1B1B22),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xFF282833),
                                  ),
                                ),
                                onSelected: (value) {
                                  if (value == 'edit' &&
                                      widget.onEditCompany != null) {
                                    widget.onEditCompany!(company);
                                  } else if (value == 'delete' &&
                                      widget.onDeleteCompany != null) {
                                    widget.onDeleteCompany!(company);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    height: 36,
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_outlined,
                                            size: 16, color: Colors.white70),
                                        SizedBox(width: 10),
                                        Text('Edit',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    height: 36,
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline_rounded,
                                            size: 16, color: Color(0xFFFF5252)),
                                        SizedBox(width: 10),
                                        Text('Delete',
                                            style: TextStyle(
                                                color: Color(0xFFFF5252),
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFF1B1B22),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _headerCell('COMPANY NAME', flex: 3),
          _headerCell('INDUSTRY', flex: 2),
          _headerCell('CONTACTS', flex: 1),
          _headerCell('STATUS', flex: 2),
          _headerCell('REVENUE', flex: 2),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6E6E7E),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildCompanyAvatar(String name) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'C';
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF282833),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF343444)),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: Color(0xFF2F66FF),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor = const Color(0xFF2F66FF);
    if (status == 'Enterprise') badgeColor = const Color(0xFFA8FF53);
    if (status == 'Prospect') badgeColor = const Color(0xFFFFB020);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: badgeColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF141419),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF24242D)),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.domain_disabled_rounded,
            size: 40,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 12),
          const Text(
            'No companies found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try adjusting your search query or status filter.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}