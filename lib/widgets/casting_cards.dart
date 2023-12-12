import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: double.infinity,
        height: 180,
        child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastingCard()));
  }
}

class _CastingCard extends StatelessWidget {
  const _CastingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage('https://picsum.photos/300/500'),
                height: 120,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Commodo esse dolor et.",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            )
          ],
        ));
  }
}
