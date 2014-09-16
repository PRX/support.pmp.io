require 'active_support/concern'

module PmpAdmin
  extend ActiveSupport::Concern

  # admin interface to the API
  def admin_pmp(host)
    @admin_pmp_clients ||= {}
    unless @admin_pmp_clients[host]
      admin_pmp_cfg = {
        client_id:     Rails.application.secrets.pmp_hosts[host]['client_id']     || '',
        client_secret: Rails.application.secrets.pmp_hosts[host]['client_secret'] || '',
        endpoint:      Rails.application.secrets.pmp_hosts[host]['host']          || 'https://api-foobar.pmp.io',
      }
      unless admin_pmp_cfg[:endpoint].match(/\/$/)
        admin_pmp_cfg[:endpoint] << '/' # TODO: pmp gem shouldn't require this slash
      end
      @admin_pmp_clients[host] = PMP::Client.new(admin_pmp_cfg)
    end
    @admin_pmp_clients[host]
  end

end
