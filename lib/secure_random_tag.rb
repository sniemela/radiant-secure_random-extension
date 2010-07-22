require 'active_support/secure_random'

module SecureRandomTag
  include Radiant::Taggable

  class TagError < StandardError; end

  desc %{
    Renders a random string or number with a given secure method.
    The default method is <code>hex</code> and length is <code>16</code>.
    
    *Usage:*
    
    <pre><code><r:secure_random [method="base64|hex|random_bytes|random_number"] [length="10"] /></code></pre>
  }
  tag 'secure_random' do |tag|
    method = tag.attr['method'] || 'hex'
    length = tag.attr['length'] || '16'

    unless ['base64', 'hex', 'random_bytes', 'random_number'].include?(method)
      raise TagError, "Invalid method '#{method}' for ActiveSupport::SecureRandom"
    end

    ActiveSupport::SecureRandom.send(method, length.to_i)
  end
end