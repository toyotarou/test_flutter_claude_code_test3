import 'package:flutter/material.dart';

import '../providers/race_provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.hourseNames,
    required this.onSearch,
    required this.onListTap,
  });

  final TextEditingController searchController;
  final List<String> hourseNames;
  final VoidCallback onSearch;
  final VoidCallback onListTap;

  @override
  State<SearchBarWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  List<String> _suggestions = [];

  void _onTextChanged(String value) {
    final katakana = toKatakana(value.trim());
    if (katakana.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
    final filtered = widget.hourseNames
        .where((name) => name.startsWith(katakana))
        .toList();
    setState(() => _suggestions = filtered);
  }

  void _selectSuggestion(String name) {
    widget.searchController.text = name;
    setState(() => _suggestions = []);
    widget.onSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: '馬名を入力（ひらがなOK）',
                    hintStyle:
                        const TextStyle(color: Colors.white38, fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFF1A1A2E),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: ListenableBuilder(
                      listenable: widget.searchController,
                      builder: (context, _) {
                        if (widget.searchController.text.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white54, size: 20),
                          onPressed: () {
                            widget.searchController.clear();
                            setState(() => _suggestions = []);
                          },
                        );
                      },
                    ),
                  ),
                  onChanged: _onTextChanged,
                  onSubmitted: (_) {
                    setState(() => _suggestions = []);
                    widget.onSearch();
                  },
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _suggestions = []);
                    widget.onSearch();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F3460),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Icon(Icons.search, size: 22),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: widget.onListTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F3460),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: const Size(44, 44),
                  ),
                  child: const Icon(Icons.list, size: 22),
                ),
              ),
            ],
          ),
          if (_suggestions.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final name = _suggestions[index];
                  return InkWell(
                    onTap: () => _selectSuggestion(name),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
