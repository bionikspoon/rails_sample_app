require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full_title' do
    assert_equal full_title, 'Rails Sample App'
    assert_equal full_title('Help'), 'Help | Rails Sample App'
  end
end
