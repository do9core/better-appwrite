import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class Collection {
  Collection(
    this.database, {
    required this.collectionId,
  });

  final Database database;
  final String collectionId;

  Future<models.DocumentList> listDocuments({List<String>? queries}) {
    return database.listDocuments(collectionId, queries: queries);
  }

  Future<models.Document> createDocument({
    required Map data,
    String? documentId,
    List<String>? permissions,
  }) {
    return database.createDocument(
      collectionId: collectionId,
      documentId: documentId ?? ID.unique(),
      data: data,
      permissions: permissions,
    );
  }

  Future<models.Document> getDocument(
    String documentId, {
    List<String>? queries,
  }) {
    return database.getDocument(
      collectionId: collectionId,
      documentId: documentId,
      queries: queries,
    );
  }

  Future<models.Document> updateDocument(
    String documentId, {
    Map? data,
    List<String>? permissions,
  }) {
    return database.updateDocument(
      collectionId: collectionId,
      documentId: documentId,
      data: data,
      permissions: permissions,
    );
  }

  Future deleteDocument(String documentId) {
    return database.deleteDocument(
      collectionId: collectionId,
      documentId: documentId,
    );
  }
}

class Database {
  Database(this.databases, this.databaseId);

  final Databases databases;
  final String databaseId;

  Collection collection(String collectionId) {
    return Collection(this, collectionId: collectionId);
  }

  Future<models.DocumentList> listDocuments(
    String collectionId, {
    List<String>? queries,
  }) {
    return databases.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
  }

  Future<models.Document> createDocument({
    required String collectionId,
    required Map data,
    String? documentId,
    List<String>? permissions,
  }) {
    return databases.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId ?? ID.unique(),
      data: data,
      permissions: permissions,
    );
  }

  Future<models.Document> getDocument({
    required String collectionId,
    required String documentId,
    List<String>? queries,
  }) {
    return databases.getDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
      queries: queries,
    );
  }

  Future<models.Document> updateDocument({
    required String collectionId,
    required String documentId,
    Map? data,
    List<String>? permissions,
  }) {
    return databases.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
      data: data,
      permissions: permissions,
    );
  }

  Future deleteDocument({
    required String collectionId,
    required String documentId,
  }) {
    return databases.deleteDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );
  }
}

extension DatabaseFromDatabases on Databases {
  Database database(String databaseId) => Database(this, databaseId);
}
