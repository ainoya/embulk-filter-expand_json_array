# Expand Json Array filter plugin for Embulk [![Gem Version](https://badge.fury.io/rb/embulk-filter-expand_json_array.svg)](https://badge.fury.io/rb/embulk-filter-expand_json_array)

## Overview

* **Plugin type**: filter

This is a embulk plugin for expanding record which has json column includes `N`-size array to `N` records.

For example, plugin expands below record which has json column `json_value` includes size-3 array value as `latest_receipt_info` to 3 records.

Before:

```
+-------------------------+---------+-------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|          time:timestamp | id:long | name:string |       score:double |                                                                                                                                                                                                                                 json_payload:string |
+-------------------------+---------+-------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 2015-10-11 00:00:00 UTC |       0 |   Avis Lind | -3256.869635206057 | {"phone_numbers":"1-276-220-7263","app_id":0,"point":-1601.6890336884562,"created_at":"2015-10-07 20:23:57 +0900","profile":{"like_words":["maiores","eum","aut"],"anniversary":{"voluptatem":"dolor","et":"ullam"}},"latest_receipt_info":[1,2,3]} |
+-------------------------+---------+-------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

Filtered:

```
+-------------------------+---------+-------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------+
|          time:timestamp | id:long | name:string |       score:double |                                                                                                                                                                                                                                 json_payload:string | latest_receipt_info:string |
+-------------------------+---------+-------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------+
| 2015-10-11 00:00:00 UTC |       0 |   Avis Lind | -3256.869635206057 | {"phone_numbers":"1-276-220-7263","app_id":0,"point":-1601.6890336884562,"created_at":"2015-10-07 20:23:57 +0900","profile":{"like_words":["maiores","eum","aut"],"anniversary":{"voluptatem":"dolor","et":"ullam"}},"latest_receipt_info":[1,2,3]} |                          1 |
| 2015-10-11 00:00:00 UTC |       0 |   Avis Lind | -3256.869635206057 | {"phone_numbers":"1-276-220-7263","app_id":0,"point":-1601.6890336884562,"created_at":"2015-10-07 20:23:57 +0900","profile":{"like_words":["maiores","eum","aut"],"anniversary":{"voluptatem":"dolor","et":"ullam"}},"latest_receipt_info":[1,2,3]} |                          2 |
| 2015-10-11 00:00:00 UTC |       0 |   Avis Lind | -3256.869635206057 | {"phone_numbers":"1-276-220-7263","app_id":0,"point":-1601.6890336884562,"created_at":"2015-10-07 20:23:57 +0900","profile":{"like_words":["maiores","eum","aut"],"anniversary":{"voluptatem":"dolor","et":"ullam"}},"latest_receipt_info":[1,2,3]} |                          3 |
+-------------------------+---------+-------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------+
```

## Configuration

- **json_column_name**: column name of json value in record (string , required)
- **root**: pointer of array value in json, specified as [jsonpath](https://github.com/joshbuddy/jsonpath)(string , required)
- **expanded_column_name**: column name after parsing target array value in json (string , required)

## Example

```yaml
filters:
  - type: expand_json_array
    json_column_name: json_payload
    root: "$.latest_receipt_info"
    expanded_column_name: latest_receipt_info
```


## Build

```
$ rake
```

## Reference

- [civitaspo/embulk-filter-expand_json](https://github.com/civitaspo/embulk-filter-expand_json)
