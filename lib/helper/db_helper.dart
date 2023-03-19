import 'package:sqflite/sqflite.dart';
import 'package:untitled/model/ship_data.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._constructor();

  static const _databaseName = "ship.db";
  static const _databaseVersion = 3;
  static const tableShipData = 'shipMasterData';

  static const keyShipName = 'shipName';
  static const keyShipId = 'shipId';
  static const keyShipModel = 'shipModel';
  static const keyShipBuildYear = 'shipBuildYear';
  static const keyShipType = 'shipType';
  static const keyShipPort = 'shipPortName';
  static const keyShipImage = 'shipImage';

  static const _createUserMasterTable =
      'CREATE TABLE IF NOT EXISTS $tableShipData ($keyShipId TEXT NOT Null,'
      '$keyShipName TEXT NOT NULL, $keyShipModel TEXT NOT NULL,$keyShipBuildYear INTEGER NOT NULL,'
      '$keyShipType TEXT NOT NULL,$keyShipPort TEXT NOT NULL,$keyShipImage TEXT NOT NULL)';

  static const _dropShipMaster = 'DROP TABLE IF EXISTS $tableShipData';

  static final DatabaseHelper _instance = DatabaseHelper._constructor();

  factory DatabaseHelper() => _instance;

  static final DatabaseHelper instance = DatabaseHelper();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(_createUserMasterTable);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute(_dropShipMaster);

    _onCreate(db, newVersion);
  }

  deleteData() async {
    Database db = await (instance.database);
    await db.delete(tableShipData);
  }

  Future addShipData(List<ShipsData> data) async {
    Database db = await (instance.database);
    for (var model in data) {
      var row = {
        keyShipName: model.shipName ?? '',
        keyShipModel: model.shipModel ?? 'Marmac 303',
        keyShipBuildYear: model.yearBuilt ?? 1974,
        keyShipId: model.shipId ?? '',
        keyShipPort: model.homePort ?? '',
        keyShipType: model.shipType ?? '',
        keyShipImage: model.image ?? 'https://i.imgur.com/ngYgFnn.jpg',
      };
      await db.insert(tableShipData, row);
    }
  }

  Future<List<ShipsData>> getShipDataFromDb() async {
    List<ShipsData> list = [];
    try {
      Database db = await (instance.database);
      var data = await db.query(tableShipData);

      for (var model in data) {
        list.add(
          ShipsData(
            yearBuilt: model['shipBuildYear'] as int,
            shipId: model['shipId'].toString(),
            shipName: model['shipName'].toString(),
            shipModel: model['shipModel'].toString(),
            shipType: model['shipType'].toString(),
            homePort: model['shipPortName'].toString(),
            image: model['shipImage'].toString(),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    return list.toSet().toList();
  }
}
