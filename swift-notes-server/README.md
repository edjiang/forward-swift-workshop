# SwiftNotes Server

This server is an example server running express-stormpath for the Forward Swift workshop. Based off the [Stormpath Notes](https://stormpath.com/blog/tutorial-build-rest-api-mobile-apps-using-node-js) tutorial. 

This is hosted at: https://swiftnotes.herokuapp.com

This API stores notes for a user. Install dependencies with `npm install`.

# Endpoints

## /register

```http
POST /register
Accept: application/json
Content-Type: application/json
{
  "givenName": "Edward",
  "surname": "Jiang",
  "email": "edward@stormpath.com",
  "password": "TestTest1"
}
```

## /oauth/token

```http
POST /oauth/token
Accept: application/json
Content-Type: application/json
{
  "grant_type": "password",
  "username": "edward@stormpath.com",
  "password": "TestTest1"
}

200 OK
{
  "access_token": "eyJra...",
  "refresh_token": "eyJra...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "stormpath_access_token_href": "https://api.stormpath.com/v1/accessTokens/5rL..."
}
```

## /notes

All notes endpoints need authorization, otherwise will respond with `401 Unauthorized`. This is via a Bearer header with an access token. 

`Authorization: Bearer eyJra...`

```http
GET /notes
Authorization: Bearer eyJra...

200 OK
{
  "notes": [
    "Don't forget this!",
    "This is another note!",
    "This is a new note!"
  ]
}
```

```http
POST /notes
Authorization: Bearer eyJra...
{
  "notes": "Yet another note"
}

201 Created
Location: /notes/3
{
  "notes": "Yet another note"
}
```

## /notes/:id

IDs are 0-indexed based on the location of the note in the array. 

```http
GET /notes/3
Authorization: Bearer eyJra...

200 OK
{
  "notes": "Yet another note"
}
```

```http
POST /notes/3
Authorization: Bearer eyJra...
{
  "notes": "We edited this note!"
}

200 OK
{
  "notes": "We edited this note!"
}
```