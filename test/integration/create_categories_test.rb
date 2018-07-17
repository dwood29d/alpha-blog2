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
end
