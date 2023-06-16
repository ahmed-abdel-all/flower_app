import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/widgets/custom_action_appbar.dart';
import 'package:flutter/material.dart';

import '../model/item.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.item});
  final Item? item;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text('Details'),
        actions: const [CustomActionBar()],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(widget.item!.imagePath),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${widget.item!.price}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 141, 141),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'New',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 26),
                    Icon(Icons.star, color: Colors.amber, size: 26),
                    Icon(Icons.star, color: Colors.amber, size: 26),
                    Icon(Icons.star, color: Colors.amber, size: 26),
                    Icon(Icons.star, color: Colors.amber, size: 26),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.edit_location,
                      color: appbarGreen,
                      size: 26,
                    ),
                    Text(
                      widget.item!.location,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Details: ',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Text(
              " Plants are predominantly photosynthetic eukaryotes, forming the kingdom Plantae. Many are multicellular. Historically, the plant kingdom encompassed all living things that were not animals, and included algae and fungi. All current definitions exclude the fungi and some of the algae. By one definition, plants form the clade Viridiplantae (Latin for \"green plants\") which consists of the green algae and the embryophytes or land plants. The latter include hornworts, liverworts, mosses, lycophytes, ferns, conifers and other gymnosperms, and flowering plants. A definition based on genomes includes the Viridiplantae, along with the red algae and the glaucophytes, in the clade Archaeplastida.",
              textAlign: TextAlign.justify,
              maxLines: isShowMore == false ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                isShowMore = !isShowMore;
                setState(() {});
              },
              child: Text(
                isShowMore == false ? 'Show More' : 'Show Less',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
