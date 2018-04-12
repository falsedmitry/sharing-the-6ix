require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "average_rating is 0.0 if one review with 0 rating" do
    user = FactoryBot.create(:user)
    tool = FactoryBot.create(:tool, owner: user)
    review = FactoryBot.create(:review, user: user, tool: tool)
    rating = FactoryBot.create(:rating, score: 0, review: review)

    expected = 0.0
    actual = tool.average_rating
    assert_equal(expected, actual)
  end

  test "average_rating is 5.0 if two reviews with 5 rating" do
    user = FactoryBot.create(:user)
    tool = FactoryBot.create(:tool, owner: user)

    review1 = FactoryBot.create(:review, user: user, tool: tool)
    rating1 = FactoryBot.create(:rating, score: 5, review: review1)

    review2 = FactoryBot.create(:review, user: user, tool: tool)
    rating2 = FactoryBot.create(:rating, score: 5, review: review2)

    expected = 5.0
    actual = tool.average_rating
    assert_equal(expected, actual)
  end

  test "average_rating is 2.5 if two reviews with 0, 5 rating" do
    user = FactoryBot.create(:user)
    tool = FactoryBot.create(:tool, owner: user)

    review1 = FactoryBot.create(:review, user: user, tool: tool)
    rating1 = FactoryBot.create(:rating, score: 0, review: review1)

    review2 = FactoryBot.create(:review, user: user, tool: tool)
    rating2 = FactoryBot.create(:rating, score: 5, review: review2)

    expected = 2.5
    actual = tool.average_rating
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
