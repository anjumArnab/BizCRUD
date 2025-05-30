import 'package:flutter/material.dart';

class ExpandableSearchWithStats extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onClearSearch;
  final int businessCount;
  final bool showStatistics;

  const ExpandableSearchWithStats({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.businessCount,
    required this.showStatistics,
  });

  @override
  State<ExpandableSearchWithStats> createState() =>
      _ExpandableSearchWithStatsState();
}

class _ExpandableSearchWithStatsState extends State<ExpandableSearchWithStats>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _searchExpandAnimation;
  late Animation<double> _statsOpacityAnimation;

  FocusNode searchFocusNode = FocusNode();
  bool isSearchExpanded = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _searchExpandAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _statsOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    searchFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (searchFocusNode.hasFocus && !isSearchExpanded) {
      _expandSearch();
    } else if (!searchFocusNode.hasFocus &&
        isSearchExpanded &&
        widget.searchController.text.isEmpty) {
      _collapseSearch();
    }
  }

  void _expandSearch() {
    setState(() {
      isSearchExpanded = true;
    });
    _animationController.forward();
  }

  void _collapseSearch() {
    setState(() {
      isSearchExpanded = false;
    });
    _animationController.reverse();
  }

  void _onSearchIconTap() {
    if (!isSearchExpanded) {
      searchFocusNode.requestFocus();
      _expandSearch();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            children: [
              // Statistics Section (Business registered text) - Gets max width when collapsed
              if (widget.showStatistics && !isSearchExpanded)
                Expanded(
                  child: Opacity(
                    opacity: _statsOpacityAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade100,
                            Colors.blue.shade50,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.business_center,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${widget.businessCount}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                Text(
                                  widget.businessCount == 1
                                      ? "Business registered"
                                      : "Businesses registered",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Gap between stats and search icon when collapsed
              if (widget.showStatistics && !isSearchExpanded)
                const SizedBox(width: 8),

              // Search Icon (when collapsed) or Expanded Search Bar
              if (!isSearchExpanded)
                GestureDetector(
                  onTap: _onSearchIconTap,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.blue.shade600,
                      size: 24,
                    ),
                  ),
                )
              else
                // Expanded Search Bar
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: widget.searchController,
                      focusNode: searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search businesses...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        prefixIcon: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.blue.shade600,
                            size: 16,
                          ),
                        ),
                        suffixIcon: widget.searchController.text.isNotEmpty
                            ? IconButton(
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () {
                                  widget.searchController.clear();
                                  widget.onClearSearch();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.grey[400],
                                  size: 16,
                                ),
                              )
                            : IconButton(
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () {
                                  searchFocusNode.unfocus();
                                  _collapseSearch();
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.blue.shade600,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                        widget.onSearchChanged(value);
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
