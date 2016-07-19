const express = require('express')
const stormpath = require('express-stormpath')
const bodyParser = require('body-parser')

const app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

app.use(stormpath.init(app, {
  expand: {
    customData: true,
  },
  web: {
    produces: ['application/json']
  }
}))

app.use(stormpath.apiAuthenticationRequired)

// Endpoint for getting a user's notes. 
app.get('/notes', function(req, res) {
  res.json({notes: req.user.customData.notes || []})
})

// Endpoint for creating a new note. 
app.post('/notes', validateNotePost, function(req, res) {
  if(!Array.isArray(req.user.customData.notes)) {
    req.user.customData.notes = []
  }

  const id = req.user.customData.notes.length
  req.user.customData.notes.push(req.body.notes)
  req.user.customData.save()

  res.location('/notes/' + id).status(201).json({notes: req.body.notes})
})

// Middleware for loading current note id
app.all('/notes/:id', function(req, res, next) {
  const id = parseInt(req.params.id)
  if(!Number.isInteger(id) || !req.user.customData.notes[id]) {
    return res.status(404).json({error: '404 Not Found'})
  }
  req.id = id
  next()
})

// Endpoint for getting a single note
app.get('/notes/:id', function(req, res) {
  res.json({notes: req.user.customData.notes[req.id]})
})

// Endpoint for updating a single note
app.post('/notes/:id', validateNotePost, function(req, res) {
  req.user.customData.notes[req.id] = req.body.notes
  req.user.customData.save()

  res.json({notes: req.user.customData.notes[req.id]})
})

// Once Stormpath has initialized itself, start your web server!
app.on('stormpath.ready', function () {
  app.listen(process.env.PORT || 3000)
})

function validateNotePost(req, res, next) {
  if(!req.body.notes || typeof req.body.notes != 'string') {
    return res.status(400).json({error: '400 Bad Request'})
  }
  next()
}