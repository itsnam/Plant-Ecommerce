import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String name = 'Cactus geg egerg er gerg ergerg ref ds fdsgsdg gdsgs fs sdg';
  String content =
      'fsdgsd gsdigdsgd gdgdsg gkdsghkdsg gkdhsghkdshgk shdgkghkdshg kgskdgh ksdghk sdhgk hsdkgh kdsgh kdshgk sdhkg hdskg hkdshg kdshkg hdskgh kdshgk hdskg hkdshg khdskg hkds';

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 25, 10),
        child: Column(
          children: [
            LimitedBox(
              maxWidth: screenSize,
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 24),
            LimitedBox(
              maxWidth: screenSize,
              child: Text(
                content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFD9E1E1)),
            const SizedBox(height: 14),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Size",
                        style: TextStyle(
                            color: Color(0xFFAEB3AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Text("Medium",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))
                  ],
                ),
                SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type",
                        style: TextStyle(
                            color: Color(0xFFAEB3AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Text("Outdoor",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("đ89.000",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xFFD9E1E1), // your color here
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {},
                        child: const Text("-"),
                      ),
                    ),
                    const SizedBox(
                        width: 30,
                        child: Center(
                          child: Text("1"),
                        )
                    ),
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xFFD9E1E1), // your color here
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {},
                        child: const Text("+"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
