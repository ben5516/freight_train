Given /^I have the following to\-do items:$/ do |table|
  table.hashes.each do |hash|
    ToDoItem.create!(hash)
  end
end


# Extended Web Steps

When /^I fill in the "([^"]*)" of the edited item with "([^"]*)"$/ do |field, new_description|
  with_scope("#edit_row.to_do_item") do
    fill_in("to_do_item[#{field.downcase}]", :with => new_description)
  end
end

When /^I click on the to\-do item "([^"]*)"$/ do |description|
  to_do_item = ToDoItem.find_by_description(description)
  selector = "#to_do_item_#{to_do_item.id}"
  find(selector).click
end

When /^I follow "([^"]*)" within the to\-do item "([^"]*)"$/ do |link, description|
  to_do_item = ToDoItem.find_by_description(description)
  evaluate_script('window.confirm = function() { return true; }') # confirm the modal
  with_scope("#to_do_item_#{to_do_item.id}") do
    click_link(link)
  end
end

Then /^there should be (\d+) To Do Items?$/ do |n|
  sleep(1.0/5.0)
  with_scope("#to_do_items") do
    assert_equal n.to_i, all('.to_do_item').length
  end
  assert_equal n.to_i, ToDoItem.count
end
