assert   = require 'assert'
{validate} = require '../lib'


describe '07-validation', ->

  it 'should return `true` for valid data', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: name', ->
    assert !validate
      id: 1
      name: 2 # <--- problem
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ff6'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: email', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar@baz.com' # <--- problem
      taxRate: 0.1
      favouriteColour: '#ff6'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: id', ->
    assert !validate
      id: -5 # <--- problem
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ff6'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: favouriteColour', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccffx' # <--- problem
      interests: ["cycling", "programming"]


  # !!!!!
  # --------------------- Additional tests for data validation --------------------- 
  it 'should return `false` for invalid data: id attribute is not provided', ->
    assert !validate
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: id is null', ->
    assert !validate
      id: '' # <--- problem
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: id is not an integer (string) ', ->
    assert !validate
      id: 'Twenty' # <--- problem
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: id is not an integer (float) ', ->
    assert !validate
      id: 20.1 # <--- problem
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: name attribute is not provided', ->
    assert !validate
      id: 21
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: name is null', ->
    assert !validate
      id: 21 
      name: '' # <--- problem
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: name exceeds maximum character limit of 63', ->
    assert !validate
      id: 1
      name: 'Captain Leone Sextus Denys Oswolf Fraudatifilius Tollemache-Tollemache de Orellana Plantagenet Tollemache-Tollemache'  # <--- problem
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `true` for valid data: name with special characters', ->
    assert validate
      id: 1
      name: 'Montagu-Stuart Ponce de León, Jr.'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: email attribute is not provided', ->
    assert !validate
      id: 21
      name: 'John Denver'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: email is null', ->
    assert !validate
      id: 21 
      name: 'John Denver' 
      email: '' # <--- problem
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: email exceeds maximum character limit of 255', ->
    assert !validate
      id: 21 
      name: 'John Denver' 
      email: 'captainleonesextusdenyssswolffraudatifiliustollemache-tollemachedeorellanaplantagenettollemache-tollemache1234567890123456789012345678901234567890@ captainleonesextusdenyssswolffraudatifiliustollemache-tollemachedeorellanaplantagenettollemache-tollemache.com' # <--- problem
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: taxRate attribute is not provided', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]
  
  it 'should return `false` for invalid data: taxRate is null', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: '' # <--- problem
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]
  
  it 'should return `false` for invalid data: taxRate is not a number (string)', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: '10 percent' # <--- problem
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: taxRate is a negative number', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: -0.1 # <--- problem
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `false` for invalid data: taxRate is > 1 ', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 1.01 # <--- problem
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]

  it 'should return `true` for valid data (optional attributes not provided: favouriteColour, interests)', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1

  it 'should return `true` for valid data (optional attributes null: favouriteColour, interests)', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: ''
      interests: []

  it 'should return `true` for valid data (optional attribute not provided: favouriteColour)', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      interests: ["cycling", "programming"]

  it 'should return `true` for valid data (optional attribute null: favouriteColour)', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: ''
      interests: ["cycling", "programming"]

  it 'should return `true` for valid data (Optional attribute not provided: interests)', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'

  it 'should return `true` for valid data (Optional attribute null: interests)', ->
    assert validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: []

  it 'should return `false` for invalid data: interests exceed maximum allowed number (4)', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming","swimming","dancing","reading"]

  it 'should return `false` for invalid data: interests contains an interest exceeding maximum character limit (31)', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming","swimming","Singing and dancing to my own singing"]

  it 'should return `false` for invalid attribute in input data', ->
    assert !validate
      id: 1
      name: 'John Doe'
      email: 'foo@bar.com'
      taxRate: 0.1
      favouriteColour: '#ccccff'
      interests: ["cycling", "programming"]
      myattribute: "Invalid Attribute"
  # ------------------------------------------ --------------------- --------------
  # !!!!!