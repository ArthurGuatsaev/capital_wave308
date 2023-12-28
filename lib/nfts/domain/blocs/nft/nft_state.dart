// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nft_bloc.dart';

class NftState {
  final List<NFTModel> nft;
  final XFile? image;
  final int current;
  final int currentFavorite;
  const NftState(
      {this.nft = const [],
      this.current = 0,
      this.currentFavorite = 0,
      this.image});

  NftState copyWith({
    List<NFTModel>? nft,
    int? current,
    int? currentFavorite,
    XFile? image,
  }) {
    return NftState(
      image: image,
      nft: nft ?? this.nft,
      current: current ?? this.current,
      currentFavorite: currentFavorite ?? this.currentFavorite,
    );
  }

  List<NFTModel> get favoritenft =>
      nft.where((element) => element.isFavorite!).toList();
  int get summNFT {
    if (nft.isEmpty) return 0;
    return nft
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value! + element!)!
        .toInt();
  }
}
