require 'active_support/secure_random'

module SecureRandomTag
  include Radiant::Taggable

  class TagError < StandardError; end

  desc %{
    Renders a random string or number with a given secure method.
    The default method is <code>hex</code> and length is <code>16</code>.
    
    *Usage:*
    
    <pre><code><r:secure_random [method="base64|hex|random_bytes|random_number|word"] [length="10"] /></code></pre>
  }
  tag 'secure_random' do |tag|
    method = tag.attr['method'] || 'hex'
    length = tag.attr['length'] || '16'

    return pronounceable_password(length.to_i) if method == 'word'

    unless ['base64', 'hex', 'random_bytes', 'random_number'].include?(method)
      raise TagError, "Invalid method '#{method}' for ActiveSupport::SecureRandom"
    end

    ActiveSupport::SecureRandom.send(method, length.to_i)
  end

  def pronounceable_password(len = 16)
    c = %w(b c d f g h j k l m n p qu r s t v w x z) +
                 %w(ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr)
    v = %w(a e i o u y)

    f, r = true, ''
    len.times { r << (f ? c[rand * c.size] : v[rand * v.size]); f = !f }
    2.times { r << (rand(9) + 1).to_s }

    r
  end
end