require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Test User', email: 'user@example.com')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '      '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 65
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '      '
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 245 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid emails' do
    valid_emails = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                      first.last@foo.jp alice+bob@baz.cn)
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid emails' do
    invalid_emails = %w(user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar..baz foo@bar+baz.com)
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should not be valid"
    end
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'user email is saved as lowercase' do
    @user.email = @user.email.upcase
    @user.save
    assert_equal @user.reload.email, @user.email.downcase

  end
end
