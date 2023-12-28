import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../import.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetNFTFavorite({
  required BuildContext context,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.8)),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Center(child: Image.asset('assets/images/tire.png')),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Favorites',
                          style: seventeenStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                BlocBuilder<NftBloc, NftState>(
                  buildWhen: (previous, current) =>
                      previous.favoritenft != current.favoritenft ||
                      previous.nft != current.nft,
                  builder: (context, state) {
                    if (state.favoritenft.isEmpty) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 500,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/nft_empty.png',
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Empty',
                                            style: twentyTwoStyle,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                "You have not added NFT to your favorites yet",
                                                style: fifteenStyle,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverGrid.builder(
                        itemCount: state.favoritenft.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 173 / 280,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return NFTItem(
                            nft: state.favoritenft[index],
                          );
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
