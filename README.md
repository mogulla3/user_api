# User API

## 概要

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

| name | default | max | description |
| :-- | :-- | :-- | :-- |
| per_page | 20 | 100 | 取得件数 |
| page | 1 | - | 何ページ目を取得するか |


#### リクエストデータの仕様
- クエリパラメータはGET時のみ利用可能
- クエリパラメータの"fields"に取得したい要素名をカンマ区切りで指定することで、必要なデータのみ取得できる
- クエリパラメータの"method"だけはGET以外でも使用可能。PUTやDELETEに対応していない場合、このパラメータを使う
- GET時にデータを送る際はクエリパラメータを用いる  
- POST, PUT, DELETE時にデータを送る際はリクエストボディを用いる（methodパラメータは例外）
- リクエストボディの形式はJSONのみ許可する（application/json）

#### レスポンスデータの仕様
- JSON形式のみサポートする(その他の形式については2ndフェーズ)
- /users.json, /users.xmlのようにドット以下にファイルフォーマットを指定する

## エラーレスポンス

#### Error Code List
※ 随時追加・更新する  

original error code | http status code | Description
:-- | :-- | :--
u-100 | 400 Bad Request | 不正なユーザーIDが指定された
u-101 | 400 Bad Request | -
u-102 | 401 Unauthorized | -
u-103 | 403 Forbidden | -
u-104 | 405 Method Not Allowed | -
u-201 | 500 Internal Server Error | -
u-202 | 503 Service Unavailable | -

#### Sample Response
```
{
  "error_code": "u-100"
  "status_code": 400,
  "message": "Required parameter is not setted."
}
```

#### Fieldについて
各種フィールドについての説明
* first_name
 * ユーザのファーストネーム
 * 必須パラメータ
 * 1文字以上50文字以下
* last_name
 * ユーザーのラストネーム
 * 必須パラメータ
 * 1文字以上50文字以下
* age
 * ユーザーの年齢
 * 必須パラメータ
 * 0以上200以下
 * 数値のみ許可
* gender
 * ユーザーの性別
 * 必須パラメータ
 * male, female, othersのいずれかのみ
* mail
 * ユーザーのメールアドレス
 * 必須パラメータ
 * メールアドレスとして妥当な文字列のみ許可
 * 100文字以下
* tel
 * ユーザーの電話番号
 * 必須パラメータ
 * 電話番号として妥当な文字列のみ許可
 * ハイフン(−)なし
* hobby
 * ユーザーの趣味
 * 複数指定可能
* status
 * ユーザーのアプリケーション上でのステータス
 * 0: 解約状態
 * 1: 登録済み状態
 * 2: 契約休止状態
 * 上記いずれかのステータスである必要がある
* birth.year
 * ユーザーの誕生年
 * 必須パラメータ
 * 1800 - 現在までの年である必要がある
 * 西暦での指定
* birth.month
 * ユーザーの誕生月
 * 必須パラメータ
 * 1-12のいずれかである必要がある
* birth.day
 * ユーザーの誕生日 
 * 必須パラメータ
 * 1-31のいずれかである必要がある
 * birth.monthに対して妥当な日である必要がある（2/31等を許容しない）
* sns.twitter.id
 * ユーザーのTwitterID
* sns.twitter.url
 * ユーザーのTwitterページのURL
 * URLとして妥当な文字列であること
* sns.facebook.id
 * ユーザーのFacebookID
* sns.facebook.url
 * ユーザーのFacebookページのURL
 * URLとして妥当な文字列であること
* sns.tmblr.id
 * ユーザのtmblrID
* sns.tmblr.url
 *ユーザーのtmblrページのURL
 * URLとして妥当な文字列であること

---

## Get user list
```
GET /users
```
##### Input (Query-Parameter or Request-Body) 
Name | Type | Required | Description
:-- | :-- | :-- | :--
id | integer | ◯ | ユーザID。カンマ区切りで複数ユーザーの指定が可能
fields | string | - | フィールド。カンマ区切りで複数フィールドの指定が可能

##### Sample Request & Response
GET _http://api.sample.jp/v1/users?id=1,2,3&fields=id,age_
```
[
{
  "id": 1,
  "age": 2
},
{
  "id": 2,
  "age": 10
}
]
```

GET _http://api.sample.jp/v1/users?id=1_
```
{
  "id": 1,
  "age": 20,
  "first_name": "Hiroki",
  "last_name": "Sampei",
  .
  .
  . 全フィールドを含む
}
```
GET _http://api.sample.jp/v1/users?fields=id,age_

```
[
{
  "id": 1,
  "age": 20
},
{
  "id": 2,
  "age": 10
}
.
.
.全ユーザ情報を返す
]
```
##### Memo
* 一度に返却可能なユーザー数の設定が必要（ユーザ数が多い場合、全ユーザー返却ではタイムアウトが発生する）

## Get a single user

```
GET /users/:id
```
##### Input (Query-Parameter or Request-Body) 
Name | Type | Required | Description
:-- | :-- | :-- | :--
fields | string | - | - |

#### Sample Request
GET _http://api.sample.jp/v1/uesrs/1?fields=first_name,age_  

```
{
  "first_name": "tarou",
  "age": 12
}
```

## Create a user

```
POST /users
```
##### Input (Query-Parameter or Request-Body) 
Name | Type | Required  | Description
:-- | :-- | :--: | :--
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
hobby|array| - |Hobbies of the user.|
sns|hash| - |SNS infomation of the user.|
sns.twitter|hash| - |Twitter information of the user.|
sns.twitter.id|integer| - |A twitter id of the user.|
sns.twitter.url|string| - |Url of the user's twitter page.|
sns.facebook|hash| - |Facebook information of the user.|
sns.facebook.id|integer| - |A facebook id of the user.|
sns.facebook.url|string| - |Url of the user's facebook page.|
sns.tumblr|hash| - |Tumblr information of the user.|
sns.tumblr.id|integer| - |A Tumblr id of the user.|
sns.tumblr.url|string| - |Url of the user's tumblr page.|
status|integer|◯|Status of the user in this app.|

##### Sample Request
POST _http://api.sample.jp/v1/uesrs_  

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

```
PUT /users/:id
```
##### Input (Query-Parameter or Request-Body) 
Name | Type | Required  | Description
:-- | :-- | :--: | :--
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
