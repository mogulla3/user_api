# User API
---

## 概要
---
※ WebAPIの設計、実装のサンプル(練習)プロジェクト  
ユーザ情報を操作するAPI

#### エンドポイント
http://api.sample.jp/v1

#### HTTPメソッド
GET, POST, PUT, DELETE

#### 利用制限
なし

#### 認証
無し

#### ページネーション
複数のデータを返すAPIの場合、デフォルトで10件返却する。  
以下2つのパラメータで取得範囲を指定することが可能

name | default | max | description
:- | :- | :- | :-
per_page | 20 | 100 | 取得件数
page | 1 | - | 何ページ目を取得するか


#### リクエストデータの仕様
- クエリパラメータはGET時のみ利用可能
- クエリパラメータの"fields"に取得したい要素名をカンマ区切りで指定することで、必要なデータのみ取得できる
- クエリパラメータの"method"だけはGET以外でも使用可能。PUTやDELETEに対応していない場合、このパラメータを使う
- GET時にデータを送る際はクエリパラメータを用いる  
- POST, PUT, DELETE時にデータを送る際はリクエストボディを用いる（methodパラメータは例外）
- リクエストボディの形式はJSONのみ許可する（application/json）

#### レスポンスデータの仕様
- JSONとXML形式をサポートする
- /users.json, /users.xmlのようにドット以下にファイルフォーマットを指定する

## エラーレスポンス
---
#### Error Code List
original error code | http status code | Description
:- | :- | :-
u-100 | 400 Bad Request | -
u-101 | 401 Unauthorized | -
u-102 | 403 Forbidden | -
u-103 | 405 Method Not Allowed | -
u-201 | 500 Internal Server Error | -
u-202 | 503 Service Unavailable | -


#### Sample Response
```
{
  "status_code": 400,
  "message": "Required parameter is not setted."
}
```

## Get user list
---
```
GET /users
```
##### Input (Query-Parameter or Request-Body) 
hogehoge

##### Sample Request
GET _http://api.sample.jp/v1/users_  

```
{
  id: "hoge",
  age: 2
}
```
##### Sample Response
hoge

## Get a single user
---
```
GET /users/:id
```
##### Input (Query-Parameter or Request-Body) 
None
#### Sample
GET _http://api.sample.jp/v1/uesrs/1?fields=first_name,age_  

```
{
  "first_name": "tarou",
  "age": 12
}
```

## Create a user
---
```
POST /users
```
##### Input (Query-Parameter or Request-Body) 
Name | Type | Required  | Description
:- | :- | :-: | :-
first_name|string|◯| A first name of the user.|
last_name|string|◯|A last name of the user.|
age|integer|◯|A age of the user.|
gender|string|◯|A gender of the user. You can set only 'male' or 'female'|
birth|hash|◯|A birthdate of the user.|
birth.year|integer|◯|A birth year of the user.|
birth.month|integer|◯|A birth month of the user.|
birth.day|integer|◯|A birth day of the user.|
mail|string|◯|A mail address of the user.|
tel|string|◯|A tel number of the user.|
hobby|array|◯|Hobbies of the user.|
sns|hash|◯|SNS infomation of the user.|
sns.twitter|hash|◯|Twitter information of the user.|
sns.twitter.id|integer|◯|A twitter id of the user.|
sns.twitter.url|string|◯|Url of the user's twitter page.|
sns.facebook|hash|◯|Facebook information of the user.|
sns.facebook.id|integer|◯|A facebook id of the user.|
sns.facebook.url|string|◯|Url of the user's facebook page.|
sns.tumblr|hash|◯|Tumblr information of the user.|
sns.tumblr.id|integer|◯|A Tumblr id of the user.|
sns.tumblr.url|string|◯|Url of the user's tumblr page.|
status|integer|◯|Status of the user in this app.|

##### Sample Request
```
{
  "first_name": "Tarou",
  "last_name": "Yamada",
  "age": 20,
  "gender": "male",
  "birth": {
    "year": 1990,
    "month": 10,
    "day": 1
  },
  "mail": "tyamada@mail.com",
  "tel": "090-9999-9999",
  "hobby": ["handball", "programming", "take a trip"],
  "sns": {
    "twitter": {
      "id": "tw10000",
      "url": "http://twitter.com/hoge"
    },
    "facebook": {
      "id": "fb10000",
      "url": "http://facebook.com/hoge"
    },
    "tumblr": {
      "id": "tb10000",
      "url": "http://tumblr.com/hoge"
    }
  },
  "status": 1
}
```
##### Sample Response
201 Created

```
{
  "id": "1",
  "created_at": "2010-10-10 10:10:10"
}
```


## Edit a user
---
```
PUT /users/:id
```
##### Input (Query-Parameter or Request-Body) 
Name | Type | Required  | Description
:- | :- | :-: | :-
first_name|string|| A first name of the user.|
last_name|string||A last name of the user.|
age|integer||A age of the user.|
gender|string||A gender of the user. You can set only 'male' or 'female'|
birth|hash||A birthdate of the user.|
birth.year|integer||A birth year of the user.|
birth.month|integer||A birth month of the user.|
birth.day|integer||A birth day of the user.|
mail|string||A mail address of the user.|
tel|string||A tel number of the user.|
hobby|array||Hobbies of the user.|
sns|hash||SNS infomation of the user.|
sns.twitter|hash||Twitter information of the user.|
sns.twitter.id|integer||A twitter id of the user.|
sns.twitter.url|string||Url of the user's twitter page.|
sns.facebook|hash||Facebook information of the user.|
sns.facebook.id|integer||A facebook id of the user.|
sns.facebook.url|string||Url of the user's facebook page.|
sns.tumblr|hash||Tumblr information of the user.|
sns.tumblr.id|integer||A Tumblr id of the user.|
sns.tumblr.url|string||Url of the user's tumblr page.|
status|integer||Status of the user in this app.|

##### Sample Request
PUT _http://api.sample.jp/users/1_

```
{
  "first_name": "Tarou",
  "sns": {
    "twitter": {
      "id": "tw10000",
      "url": "http://twitter.com/hoge"
    }
  },
}
```

##### Sample Response
200 OK

```
{
  "id": 1,
  "updated_at": "2012-10-10 10:10:10"
}
```

## Delete a user
---
```
DELETE /users/:id
```
##### Input (Query-Parameter or Request-Body) 
None

##### Sample Request
DELETE _http://api.sample.jp/delete/1_

##### Sample Response
200 OK

```
{
  "id": 1,
  "deleted_at": "2013-10-10 10:10:10"
}
```
