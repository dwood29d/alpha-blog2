require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new' # Verify that we have a new route
    assert_difference 'Category.count', 1 do # Create a new category via post and see if the number of categories changes
      post categories_path, params: { category: {name: "sports"}}
      follow_redirect!
    end
    assert_template 'categories/index' # Verify that we're now on the index page of categories
    assert_match "sports", response.body # Verify that the string sports shows on this page now (in the body)
  end

  test "invalid category submission results in failure" do
    get new_category_path
    assert_template 'categories/new' # Verify that we have a new route
    assert_no_difference 'Category.count' do # Create a new category via post and see if the number of categories changes (it shouldn't)
      post categories_path, params: { category: {name: " "}}
      # follow_redirect! It's not redirecting since we're staying on the new page, so no need for follow redirect
    end
    assert_template 'categories/new' # Verify that we're now on the index page of categories
    assert_select 'h2.panel-title' # These are from the errors partial. Do they exist on the page when the errors show?
    assert_select 'div.panel-body'
  end
end
