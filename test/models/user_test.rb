# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid users(:simon)
  end

  test "simon can be authenticated with password 'password'" do
    assert users(:simon).try(:authenticate, 'password')
  end
  end
end
