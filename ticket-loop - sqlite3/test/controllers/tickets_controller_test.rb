require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tickets_show_url
    assert_response :success
  end

end
