assert = require 'assert'
test = require 'selenium-webdriver/testing'
webdriver = require 'selenium-webdriver'


test.describe 'Adslot website', ->

  # Browser (or driver) instance
  browser = null

  # Init browser before we begin
  test.before -> browser = new webdriver.Builder().usingServer().withCapabilities({browserName: 'chrome'}).build()

  # Close browser after all tests
  test.after -> browser.quit()

  test.it 'should have 8 offices on careers page - Sydney, Melbourne, London, New York, Auckland, San Francisco, Hamburg, and Shanghai', ->

    browser.get 'http://adslot.com/careers' 
    
    browser.findElements(webdriver.By.css('.ui-tabs-nav h4, .wpb_heading.wpb_tour_heading')).then (menuItems) ->
      
      validOffices = ['Sydney', 'Melbourne', 'London', 'New York', 'Auckland', 'San Francisco', 'Hamburg','Shanghai']
      
      assert.equal menuItems.length, validOffices.length, 'Invalid Number of offices : '+menuItems.length
      for menuItem in menuItems
        menuItem.getAttribute('innerText').then (officename) ->
          index = validOffices.indexOf officename
          assert index isnt -1, 'Invalid office: '+officename
          validOffices.splice(index, 1)


  test.it 'should contain a form on "contact us" page', ->

    browser.get 'http://www.adslot.com/contact-us'

    browser.findElement(webdriver.By.id('first_name')).isDisplayed()
    browser.findElement(webdriver.By.id('last_name')).isDisplayed()
    browser.findElement(webdriver.By.id('company')).isDisplayed()
    browser.findElement(webdriver.By.id('email')).isDisplayed()
    browser.findElement(webdriver.By.id('website')).isDisplayed()
    browser.findElement(webdriver.By.id('00N90000004oGQH')).isDisplayed()
    browser.findElement(webdriver.By.id('message')).isDisplayed()
    browser.findElement(webdriver.By.css('button[type=submit]')).isDisplayed()   


  test.it 'When search "Adslot" in google and follow first link, title should be "Adslot" ', ->

    browser.get 'https://www.google.com.au'
      
    browser.findElement(webdriver.By.name('q')).then (searchbox) ->
      searchbox.sendKeys('Adslot',webdriver.Key.ENTER)
      browser.wait(webdriver.until.elementLocated(webdriver.By.id('rso')), 10000).then () ->
        oldTitle = 'Not Set'
        browser.getTitle().then (title) ->
          oldTitle = title
        
        browser.findElement(webdriver.By.xpath("//*[@id='rso']/div/div/div/h3/a")).then (firstLink) ->
          firstLink.click()

          newTitle = oldTitle
          browser.wait( () ->
            browser.getTitle().then (title) ->
              newTitle = title

            return oldTitle isnt newTitle
          ,10000).then () ->
            assert.equal newTitle, 'Adslot'

  test.it 'Verify office addresses in "Contact us" page', ->

    browser.get 'http://www.adslot.com/contact-us'

    #browser.wait(webdriver.until.elementLocated(webdriver.By.css('.wpb_wrapper p')),10000).then () ->
    browser.findElements(webdriver.By.css('.wpb_wrapper p')).then (elements) ->
      
      i = 0
      contents = []

      browser.wait( () ->
        for element in elements
          element.getAttribute('innerText').then (content) ->
            contents[i]=content
            i++
            return i is 26
      ,10000).then () ->
      
        # Verify address and phone number of 'Head Office'
        index = contents.indexOf 'Head Office'
        assert index isnt -1, 'Head Office cannot be found on page'
        assert.equal contents[index+1], 'Level 2, 85 Coventry St\nSouth Melbourne Vic 3205\nAustralia'
        assert.equal contents[index+2], '+61 3 8695 9100'

        # Verify address and phone number of 'New York'
        index = contents.indexOf 'New York'
        assert index isnt -1, 'New York cannot be found on page'
        assert.equal contents[index+1], '41 E 11th St, 10th Floor\nNew York, NY 10003\nUnited States of America'
        assert.equal contents[index+2], '212-699-3640'

        # Verify address and phone number of 'San Francisco'
        index = contents.indexOf 'San Francisco'
        assert index isnt -1, 'San Francisco cannot be found on page'
        assert.equal contents[index+1], '156 2nd St\nSan Francisco, CA 94105\nUnited States of America'
        assert.equal contents[index+2], '+1 800 853 146'

        # Verify address and phone number of 'United Kingdom'
        index = contents.indexOf 'United Kingdom'
        assert index isnt -1, 'United Kingdom cannot be found on page'
        assert.equal contents[index+1], '79 Wardour St\nSoho, London W1D 6QB,\nUnited Kingdom'
        assert.equal contents[index+2], '+44 7 432 637 446'

        # Verify address and phone number of 'Germany'
        index = contents.indexOf 'Germany'
        assert index isnt -1, 'Germany cannot be found on page'
        assert.equal contents[index+1], 'Hamburg Business Center\nPoststrasse 33\n20354 Hamburg\nGermany'
        assert.equal contents[index+2], '+49 (0) 40 3508 5730'

        # Verify address and phone number of 'Sydney'
        index = contents.indexOf 'Sydney'
        assert index isnt -1, 'Sydney cannot be found on page'
        assert.equal contents[index+1], 'Level 6, 241 Commonwealth St\nSurry Hills NSW 2010\nPO Box 1721 Darlinghurst NSW 1300\nAustralia'
        assert.equal contents[index+2], '+61 (0)2 9690 3900'

        # Verify address and phone number of 'Shanghai'
        index = contents.indexOf 'Shanghai'
        assert index isnt -1, 'Shanghai cannot be found on page'
        assert.equal contents[index+1], '1-231, Shanghai 1933\nNo 10 Shajing Road\nShanghai. 200080\nChina'
        assert.equal contents[index+2], '+86 21 6467 9909'

        # Verify address and phone number of 'Auckland'
        index = contents.indexOf 'Auckland'
        assert index isnt -1, 'Auckland cannot be found on page'
        assert.equal contents[index+1], 'Level 1, 1 Anzac Avenue\nAuckland, 1010\nNew Zealand'
        assert.equal contents[index+2], '+ 64 (0) 7 808 2291' 