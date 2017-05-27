# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid users(:superman)
  end

  test "superman can be authenticated with password 'password'" do
    assert users(:superman).try(:authenticate, 'password')
  end
end
