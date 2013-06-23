assert  = require 'assert'
request = require 'request'
app     = require '../../app'

Browser = require 'zombie'

test_uri = "http://localhost:3000/login"

describe "authentication", ->
  describe "GET /login", ->
    body = null

    before (done) ->
      options =
        uri: test_uri

      request options, (err, response, _body) ->
        body = _body
        done()

    it "has user field", ->
      assert.ok /user/.test(body)

# Integration tests with Zombie
describe "browser test", ->

  browser = null
  uri = test_uri

  before (done) ->
    browser = Browser.create()
    browser.visit(uri, done)

  describe "GET /login", ->
    it "can request the page successfully", ->
      assert.ok browser.success

    it "has 3 input fields", ->
      nodes = browser.queryAll('input')
      assert.equal nodes.length, 3

    it "has an input field for a username", ->
      node = browser.query('#username')
      assert.equal node.tagName, "INPUT"

    it "has an input field for a password", ->
      node = browser.query('#password')
      assert.equal node.tagName, "INPUT"

    it "has a button to login", ->
      node = browser.query('#login-button')
      assert.equal node.tagName, "INPUT"

