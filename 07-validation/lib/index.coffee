# Uses third party library validator (https://www.npmjs.com/package/validator)
validator = require('validator')

exports.validate = (data) ->
	
	# ----- Validate id -----
	if not data.id? or data.id is ''
		return false											# <---- id is null or empty / mandatory field not provided
	else if not validator.isInt(data.id)
		return false											# <---- id is not an integer
	else if data.id < 0 										
		return false											# <---- id is a negative number

	# ----- Validate name -----
	if not data.name? or data.name is ''	
		return false											# <---- name is null or empty / mandatory field not provided
	else if !/[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]/.test data.name 
		return false											# <---- name has invalid characters
	else if data.name.length > 63
		return false											# <---- name length exceeds maximum character limit (63)

	# ----- Validate email -----
	if not data.email? or data.email is ''
		return false											# <---- email is null or empty / mandatory field not provided						
	else if data.email.length > 255
		return false											# <---- email length exceeds maximum character limit (255)
	else if not validator.isEmail(data.email)
		return false											# <---- email follows an invalid address format
	
	# ----- Validate taxRate -----
	if not data.taxRate? or data.taxRate is ''
		return false											# <---- taxRate is null or empty / mandatory field not provided	
	else if not validator.isFloat(data.taxRate,{min:0,max:1})
		return false											# <---- taxRate is not a float number between 0 and 1

	# ----- Validate favouriteColour -----
	if data.favouriteColour? and data.favouriteColour isnt '' and not validator.isHexColor(data.favouriteColour)
		return false											# <---- favouriteColour provided is not a valid Hex Colour

	# ----- Validate interests -----
	if data.interests? and data.interests isnt ''
		if {}.toString.call(data.interests) isnt '[object Array]'
			return false										# <---- interests provided is not in an Array 
		else if data.interests.length > 4
			return false										# <---- interests provided exceeds maximum number of interests (4) 
		else
			for interest in data.interests
				if interest.length > 31 then return false		# <---- One of the interests exceed maximum character limit (31) 

	# ----- Validate input attributes -----
	validAttributes = [ 'id', 'name', 'email', 'taxRate', 'favouriteColour', 'interests' ]
	attributes = Object.getOwnPropertyNames(data)
	
	for attribute in attributes
		index = validAttributes.indexOf attribute
		if index is -1
			return false										# <---- One of the input attributes is not valid  


	return true
