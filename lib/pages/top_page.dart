import 'package:flutter_bloc/flutter_bloc.dart';
import '../../import.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => TopPageState();
}

class TopPageState extends State<TopPage> {
  @override
  void initState() {
    context.read<TopNftBloc>().add(GetSaveTopNFTEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNftBloc, TopNftState>(
      buildWhen: (previous, current) => previous.topNft != current.topNft,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top',
                            style: thirtyFourStyte,
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 10),
                    ),
                    SliverToBoxAdapter(
                      child: Builder(
                        builder: (context) {
                          if (state.topNft.isEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: SizedBox(
                                height: 300,
                                child: Center(
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            'assets/images/top_empty.png'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Empty',
                                                  style: twentyTwoStyle),
                                              Expanded(
                                                child: Text(
                                                  "You haven't added any top NFT yet",
                                                  style: fifteenStyle,
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
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    SliverList.builder(
                      itemCount: state.topNft.length,
                      itemBuilder: (context, index) {
                        return NftTopItem(
                          nft: state.topNft[index],
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primary,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            showModalSheetTopNFTAdd(
                              context: context,
                              descController: TextEditingController(),
                              priceController: TextEditingController(),
                              nameController: TextEditingController(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/plus.png'),
                              const SizedBox(width: 8),
                              const Text(
                                'Add Popular NFT',
                                style: seventeenStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
