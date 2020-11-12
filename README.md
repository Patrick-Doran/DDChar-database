# DDChar-database

This is a project for UC Merced's CSE 111 Database Systems. We will be creating a database to manage a character and to add/lookup spells

## Requirements
Make sure to have Node JS and npm installed/updated.
You can get Node JS [here.](https://nodejs.org/en/about/) 
NPM should be included with Node JS, to check use
```
node -v
npm -v
```

## Dependencies
Need to install Express API to create the webserver, sqlite3 for the database, and MD5 for password encryption (This may or may not be needed)
```
npm install express
npm install sqlite3
npm install md5
```

### Running the Web Server
`npm run start`

The web server will run on http://localhost:8000/ by default.

#### References
UC Merced CSE 111 lectures

Developer How-To: [Build a REST API with Node.js SQLite and Express JS](https://developerhowto.com/2018/12/29/build-a-rest-api-with-node-js-and-express-js/)
