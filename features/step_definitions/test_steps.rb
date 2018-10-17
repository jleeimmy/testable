def close_new_tabs
  window = page.driver.browser.window_handles
  return nil unless window.size > 1

  page.driver.browser.switch_to.window(window.last)
  page.driver.browser.close
  page.driver.browser.switch_to.window(window.first)
end

Given(/^I am signed up on the Zeachable website$/) do
  password = 'testj12345'
  time = Time.now.to_i.to_s
  name = 'jtest' + time
  email = name + '@mailinator.com'
  visit '/'
  click_link('Sign Up')
  fill_in 'user[name]', with: name
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password
  fill_in 'user[password_confirmation]', with: 'testj12345'
  check 'user[agreed_to_terms]'
  click_button('Sign Up')
  # Assert Elements of logged in page
  expect(page).to have_content 'take home test'
  expect(page).to have_content 'Category'
  expect(page).to have_content 'Author'
end

When(/^I take a course$/) do
  click_link('take home test')
  expect(page).to have_content 'Find a course'
  expect(page).to have_content 'Your Instructor'
  expect(page).to have_content 'artash'
  click_button('Enroll in Course for', match: :first)
  expect(page).to have_content 'Thanks for enrolling in this course!'
  expect(page).to have_content 'Your order ID'
  expect(page).to have_content 'You will shortly receive an email confirmation at '
  click_on(class: 'btn btn-hg btn-primary btn-inline-block goto-course') # continue to course button
  expect(page).to have_current_path('/courses/enrolled/188336', ignore_query: true)
  expect(page).to have_content 'Class Curriculum'
  expect(page).to have_content 'Start next lecture'
  expect(page).to have_content 'Section 1'
  expect(page).to have_content 'Lecture with text'
  # take first lecture
  click_on(class: 'btn btn-primary start-next-lecture') #  start next lecture button
  expect(page).to have_current_path('/courses/188336/lectures/2862496', ignore_query: true)
  expect(page).to have_content 'Download'
  expect(page).to have_content 'test_image.png'
  click_link('test_image.png')
  window = page.driver.browser.window_handles
  page.driver.browser.switch_to.window(window.last)
  # assert filepicker uri
  expect(page).to have_current_path('https://www.filepicker.io/api/file/MRIQ1dMHRfyngkiQDTsr', url: true)
  page.driver.browser.switch_to.window(window.first)
  close_new_tabs # call our method to close tab
  click_link('lecture_complete_button')
  # take 2nd lecture
  expect(page).to have_current_path('/courses/188336/lectures/2862497', ignore_query: true)
  # assert on wistia player css
  expect(page).to have_css '#lecture-attachment-5516102'
  click_link('lecture_complete_button')
  # take 3rd lecture
  expect(page).to have_current_path('/courses/188336/lectures/2862498', ignore_query: true)
  # assert on PDF title
  expect(page).to have_content 'Test PDF file.pdf'
  # assert iframe
  expect(page).to have_css '#pdfViewer-6YxIXWdLQ6S1eEm3NTDk'
  click_link('lecture_complete_button')
  # take 4th lecture
  expect(page).to have_current_path('/courses/188336/lectures/2862499', ignore_query: true)
  expect(page).to have_content 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores'
  click_link('lecture_complete_button')
  expect(page).to have_current_path('/courses/enrolled/188336', ignore_query: true)
end

Then(/^the course should be set completed$/) do
  # this is a slight workaround since there is currently a bug on the last page
  click_on(class: 'nav-icon-back') # back button
  expect(page).to have_current_path('/courses/', ignore_query: true)
  expect(page).to have_content'COMPLETE'
  expect(page).to have_content'100%'
end
