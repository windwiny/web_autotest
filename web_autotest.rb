require 'mechanize'
require 'watir'


def test_mechanize(url)
  ag = Mechanize.new
  pg1= ag.get(url)

  fm0 = pg1.forms[0]

  fm0.texts[0].value = 'abc'
  fm0.texts[1].value = 'DEF'

  puts '---'
  puts fm0.inspect
  puts '----'

  ## mechanize not run javascript, html not has a button
  if fm0.buttons.size != 0
    puts "button value: #{fm0.buttons[0].value}"
  else
    puts "!! mechanize not run javascript, html not has a button"
    puts "!! using Mechanize form.submit"
  end
  pg2 = fm0.submit

  puts pg2.content.include? 'First name: abc'
  puts pg2.content.include? 'Last name: DEF'
  puts '------------end----------'
end

def test_watir(url)
  br = Watir::Browser.new
  br.goto(url)
  fm0 = br.forms[0]
  fm0.text_fields[0].value = 'Abcd'
  fm0.text_fields[1].value = 'EFGH'

  ## web2 javascript add a button
  puts "button value: #{fm0.buttons[0].value}"
  fm0.buttons[0].click

  puts br.text.include? 'First name: Abcd'
  puts br.text.include? 'Last name: EFGH'

  puts '------------end----------'
end


test_mechanize('http://127.0.0.1:3000/web1/hello')  # test mechanize basic form
test_mechanize('http://127.0.0.1:3000/web2/hello')  # test mechanize javascript form
test_watir('http://127.0.0.1:3000/web1/hello')  # test watir basic form
test_watir('http://127.0.0.1:3000/web2/hello')  # test watir javascript form
