require File.dirname(__FILE__) + '/../spec_helper'
require 'active_support/secure_random'

describe 'Secure random tag' do
  before do
    @page = Factory.create(:page)
  end

  it '<r:secure_random /> should render default' do
    ActiveSupport::SecureRandom.should_receive('hex').with(16).and_return('test')
    @page.should render('<r:secure_random />').as('test')
  end

  it '<r:secure_random /> should raise if method is not supported' do
     @page.should render('<r:secure_random method="invalid_method" />').with_error("Invalid method 'invalid_method' for ActiveSupport::SecureRandom")
  end

  it '<r:secure_random method="word" /> should render pronounceable password' do
    @page.should_receive('pronounceable_password').with(16).and_return('test')
    @page.should render('<r:secure_random method="word" />').as('test')
  end

  ['base64', 'hex', 'random_bytes', 'random_number'].each do |secure_method|
    it "<r:secure_random method='#{secure_method}' length='10' /> should render something" do
      ActiveSupport::SecureRandom.should_receive(secure_method).with(10).and_return('test')
      @page.should render("<r:secure_random method='#{secure_method}' length='10' />").as('test')
    end
  end
end