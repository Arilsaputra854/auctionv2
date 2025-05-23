class ProductsModel {
  final String uid;
  final String name;
  final String category;
  final String collection;
  final String subCollection;
  final String image1;
  final String image2;
  final String image3;
  final String unitname1;
  final String unitname2;
  final String unitname3;
  final String unitname4;
  final String unitname5;
  final String unitname6;
  final String unitname7;
  final num unitPrice1;
  final num unitPrice2;
  final num unitPrice3;
  final num unitPrice4;
  final num unitPrice5;
  final num unitPrice6;
  final num unitPrice7;
  final num unitOldPrice1;
  final num unitOldPrice2;
  final num unitOldPrice3;
  final num unitOldPrice4;
  final num unitOldPrice5;
  final num unitOldPrice6;
  final num unitOldPrice7;
  final num percantageDiscount;
  final String vendorId;
  final String brand;
  // final String marketID;
  final String vendorName;
  final String description;
  final String productID;
  final num totalRating;
  final num totalNumberOfUserRating;
  final int quantity;
  final String? endFlash;
  final int returnDuration;
  final DateTime timeCreated;

  ProductsModel({
    this.endFlash,
    required this.returnDuration,
    required this.timeCreated,
    required this.totalRating,
    required this.quantity,
    required this.totalNumberOfUserRating,
    required this.productID,
    required this.description,
    // required this.marketID,
    required this.vendorName,
    required this.uid,
    required this.name,
    required this.category,
    required this.collection,
    required this.subCollection,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.unitname1,
    required this.unitname2,
    required this.unitname3,
    required this.unitname4,
    required this.unitname5,
    required this.unitname6,
    required this.unitname7,
    required this.unitPrice1,
    required this.unitPrice2,
    required this.unitPrice3,
    required this.unitPrice4,
    required this.unitPrice5,
    required this.unitPrice6,
    required this.unitPrice7,
    required this.unitOldPrice1,
    required this.unitOldPrice2,
    required this.unitOldPrice3,
    required this.unitOldPrice4,
    required this.unitOldPrice5,
    required this.unitOldPrice6,
    required this.unitOldPrice7,
    required this.percantageDiscount,
    required this.vendorId,
    required this.brand,
  });
  Map<String, dynamic> toMap() {
    return {
      'timeCreated':timeCreated,
      'returnDuration': returnDuration,
      'endFlash': endFlash,
      'totalRating': totalRating,
      'totalNumberOfUserRating': totalNumberOfUserRating,
      'vendorName': vendorName,
      //  'marketID': marketID,
      'quantity': quantity,
      'name': name,
      'description': description,
      'category': category,
      'collection': collection,
      'subCollection': subCollection,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'unitname1': unitname1,
      'unitname2': unitname2,
      'unitname3': unitname3,
      'unitname4': unitname4,
      'unitname5': unitname5,
      'unitname6': unitname6,
      'unitname7': unitname7,
      'unitPrice1': unitPrice1,
      'unitPrice2': unitPrice2,
      'unitPrice3': unitPrice3,
      'unitPrice4': unitPrice4,
      'unitPrice5': unitPrice5,
      'unitPrice6': unitPrice6,
      'unitPrice7': unitPrice7,
      'unitOldPrice1': unitOldPrice1,
      'unitOldPrice2': unitOldPrice2,
      'unitOldPrice3': unitOldPrice3,
      'unitOldPrice4': unitOldPrice4,
      'unitOldPrice5': unitOldPrice5,
      'unitOldPrice6': unitOldPrice6,
      'unitOldPrice7': unitOldPrice7,
      'percantageDiscount': percantageDiscount,
      'vendorId': vendorId,
      'brand': brand,
      'productID': productID
    };
  }

  ProductsModel.fromMap(data, this.uid)
      : name = 'HYUNDAI PALISADE LX2 2.2',
      timeCreated = data['timeCreated'].toDate(),
        returnDuration = data['returnDuration'],
        totalNumberOfUserRating = data['totalNumberOfUserRating'],
        totalRating = data['totalRating'],
        description = data['description'],
        vendorName = data['vendorName'],
        endFlash = data['endFlash'],
        productID = data['productID'],
        quantity = data['quantity'],
        //  marketID = data['marketID'],
        category = data['category'],
        collection = data['collection'],
        subCollection = data['subCollection'],
        image1 = "https://tunasauction.s3.ap-southeast-1.amazonaws.com/bastk/22c95b490feee0556535ea97bafb1319_1725507078.jpg",
        image2 = "https://tunasauction.s3.ap-southeast-1.amazonaws.com/bastk/920dcd7a5a8e7d5cafb7ae27f3783966_1725507079.jpg",
        image3 = "https://tunasauction.s3.ap-southeast-1.amazonaws.com/bastk/ea5250104950beb07a8d2381d98560f1_1725507079.jpg",
        unitname1 = data['unitname1'],
        unitname2 = data['unitname2'],
        unitname3 = data['unitname3'],
        unitname4 = data['unitname4'],
        unitname5 = data['unitname5'],
        unitname6 = data['unitname6'],
        unitname7 = data['unitname7'],
        unitPrice1 = 450000000,
        unitPrice2 = data['unitPrice2'],
        unitPrice3 = data['unitPrice3'],
        unitPrice4 = data['unitPrice4'],
        unitPrice5 = data['unitPrice5'],
        unitPrice6 = data['unitPrice6'],
        unitPrice7 = data['unitPrice7'],
        unitOldPrice1 = data['unitOldPrice1'],
        unitOldPrice2 = data['unitOldPrice2'],
        unitOldPrice3 = data['unitOldPrice3'],
        unitOldPrice4 = data['unitOldPrice4'],
        unitOldPrice5 = data['unitOldPrice5'],
        unitOldPrice6 = data['unitOldPrice6'],
        unitOldPrice7 = data['unitOldPrice7'],
        percantageDiscount = data['percantageDiscount'],
        vendorId = data['vendorId'],
        brand = data['brand'];
}
