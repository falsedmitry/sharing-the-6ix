require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "rating is 0.0 if under 5 reviews" do
    user = FactoryBot.create(:user)

    4.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
      FactoryBot.create(:review, tool_id: tool.id, user_id: user.id)
    end

    expected = 0.0
    actual = user.rating
    assert_equal(expected, actual)
  end

  test "rating is 1.0 if 5 reviews, all 1 stars" do
    user = FactoryBot.create(:user)

    5.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
      FactoryBot.create(:review, rating: 1, tool_id: tool.id, user_id: user.id)
    end

    expected = 1.0
    actual = user.rating
    assert_equal(expected, actual)
  end

  test "rating is 3.0 if 10 reviews, all 3 stars" do
    user = FactoryBot.create(:user)

    10.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
      FactoryBot.create(:review, rating: 3, tool_id: tool.id, user_id: user.id)
    end

    expected = 3.0
    actual = user.rating
    assert_equal(expected, actual)
  end

  test "rating is 4.0 if 10 reviews, 5 5 stars, 5 3 stars" do
    user = FactoryBot.create(:user)

    5.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
      FactoryBot.create(:review, rating: 5, tool_id: tool.id, user_id: user.id)
    end

    5.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
      FactoryBot.create(:review, rating: 3, tool_id: tool.id, user_id: user.id)
    end

    expected = 4.0
    actual = user.rating
    assert_equal(expected, actual)
  end

  test "tools_out_on_loan_is_empty_if_no_tools_out_on_loan" do
    user = FactoryBot.create(:user)

    5.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
    end

    expected = []
    actual = user.tools_out_on_loan
    assert_equal(expected, actual)
  end

  test "tools_out_on_loan_contains_tools_if_they_are_on_loan" do
    user = FactoryBot.create(:user)

    3.times do
      tool = FactoryBot.create(:tool, user_id: user.id, on_loan: true)
    end

    2.times do
      tool = FactoryBot.create(:tool, user_id: user.id)
    end

    expected = 3
    actual = user.tools_out_on_loan.size
    assert_equal(expected, actual)
  end
end
