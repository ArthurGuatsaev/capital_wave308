import '../../import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NFTItem extends StatelessWidget {
  final NFTModel nft;
  const NFTItem({super.key, required this.nft});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 173 / 140,
              child: Stack(
                children: [
                  FutureBuilder<FileImage?>(
                    future: nft.productImage,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        );
                      }
                      return AspectRatio(
                        aspectRatio: 173 / 140,
                        child: Image(
                          image: snapshot.data!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, right: 10),
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: !nft.isFavorite!
                                ? Colors.black.withOpacity(0.13)
                                : primary),
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              context.read<NftBloc>().add(SaveNFTEvent(
                                  model: nft.copyWith(
                                      isFavorite: !nft.isFavorite!)));
                            },
                            child: Center(
                                child: !nft.isFavorite!
                                    ? Image.asset('assets/images/star.png')
                                    : Image.asset(
                                        'assets/images/star_fill.png')),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            nft.name!,
            style: seventeenStyle,
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Text(
              nft.desc!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: thirdteenStyle,
            ),
          ),
          const SizedBox(height: 2),
          CalcButton(
            function: () {
              context.read<NoteBloc>().add(ChangeCurrentIdEvent(id: nft.id!));
              context.read<NftBloc>().add(ChangeIndexEvent(index: nft));
              return showModalSheetNFTOpen(
                  context: context, textController: TextEditingController());
            },
            text: 'Open',
            gradic: gradientButtonOff,
          )
        ],
      ),
    );
  }
}
