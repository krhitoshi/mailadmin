# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

# All assets are served from the app itself (Propshaft + importmap),
# so every directive is restricted to :self with no external origins.
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src    :self
    policy.img_src     :self, :data
    policy.object_src  :none
    policy.script_src  :self
    policy.style_src   :self
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  # The importmap <script> tags and the Turbo progress bar <style> rely on these.
  # On the very first request the session id is not generated yet, so fall
  # back to a random per-request nonce to avoid blocking scripts with an
  # empty nonce
  config.content_security_policy_nonce_generator = ->(request) do
    request.session.id.to_s.presence || SecureRandom.base64(16)
  end
  config.content_security_policy_nonce_directives = %w(script-src style-src)
end
