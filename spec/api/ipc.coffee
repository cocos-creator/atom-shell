assert = require 'assert'
ipc = require 'ipc'
path = require 'path'
remote = require 'remote'

describe 'ipc', ->
  describe 'remote.require', ->
    it 'should returns same object for the same module', ->
      dialog1 = remote.require 'dialog'
      dialog2 = remote.require 'dialog'
      assert.equal dialog1, dialog2

    it 'should work when object contains id property', ->
      a = remote.require path.join(__dirname, '..', 'fixtures', 'module', 'id.js')
      assert.equal a.id, 1127

  describe 'ipc.send', ->
    it 'should work when sending an object containing id property', (done) ->
      obj = id: 1, name: 'ly'
      ipc.on 'message', (message) ->
        assert.deepEqual message, obj
        done()
      ipc.send obj
