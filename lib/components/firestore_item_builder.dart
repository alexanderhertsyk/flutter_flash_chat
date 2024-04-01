import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef FromJson<TModel> = TModel Function(Map<String, dynamic> json);
typedef OnItem<TModel, TItem> = TItem Function(TModel model);
typedef OnSucceed<TItem> = Widget Function(List<TItem> children);
typedef OnError = Widget Function();

class FirestoreItemBuilder {
  static Widget build<TModel, TItem>(
    BuildContext context,
    AsyncSnapshot<QuerySnapshot> snapshot, {
    required FromJson<TModel> fromJson,
    required OnItem<TModel, TItem> onItem,
    required OnSucceed<TItem> onSucceed,
    required OnError onError,
  }) {
    if (snapshot.hasData) {
      return onSucceed(
        snapshot.data!.docs
            .map((d) => d.data())
            .whereType<Map<String, dynamic>>()
            .map((m) => onItem(fromJson(m)))
            .toList(),
      );
    } else {
      return onError();
    }
  }
}

class FirestoreStreamBuilder {
  static Widget build<TModel, TItem>({
    required BuildContext context,
    required Stream<QuerySnapshot<Map<String, dynamic>>> stream,
    required FromJson<TModel> fromJson,
    required OnItem<TModel, TItem> onItem,
    required OnSucceed<TItem> onSucceed,
    required OnError onError,
  }) =>
      StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return onSucceed(
                snapshot.data!.docs
                    .map((d) => d.data())
                    .whereType<Map<String, dynamic>>()
                    .map((m) => onItem(fromJson(m)))
                    .toList(),
              );
            } else {
              return onError();
            }
          });
}
