require 'capybara/rspec'
Capybara.default_driver = :selenium

RSpec.feature "Lab4" do
  scenario '' do
    visit 'http://pma.fpm.kpi.ua'
    click_on 'Викладачі'

    teacher_number_20 = find(:xpath, '//tr[20]/td[1]/p/a')
    teacher_name = teacher_number_20.text
    puts teacher_name

    teacher_number_20.click

    puts page.title

    save_and_open_screenshot
  end
end
