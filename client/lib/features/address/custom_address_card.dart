import 'package:flutter/material.dart';

class CustomAddressCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomAddressCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Row(
        children: [
          Radio(
            value: null,  // Use a unique value or null based on your requirements
            groupValue: null,  // Use a unique value or null based on your requirements
            onChanged: (value) {
              // Handle radio button selection if needed
            },
          ),
          Expanded(
            child: Card(
              shadowColor: Colors.transparent,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: Color(0xFF9AA09A),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Chỉnh sửa'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Xoá'),
                        ),
                      ],
                      onSelected: (String choice) {
                        if (choice == 'edit') {
                          // Xử lý sự kiện chỉnh sửa ở đây
                        } else if (choice == 'delete') {
                          // Xử lý sự kiện xoá ở đây
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
