require 'fog/core/collection'
require 'fog/openstack/models/compute/tenant'

module Fog
  module Compute
    class OpenStack
      class Tenants < Fog::Collection
        model Fog::Compute::OpenStack::Tenant

        def all
          load(connection.list_tenants.body['tenants'])
        end

        def find_by_id(id)
          self.find {|tenant| tenant.id == id} ||
            Fog::Compute::OpenStack::Tenant.new(
              connection.get_tenant(id).body['tenant'])
        end

        def usages(start_date = nil, end_date = nil, details = false)
          connection.list_usages(start_date, end_date, details).body['tenant_usages']
        end 
      end # class Tenants
    end # class OpenStack
  end # module Compute
end # module Fog
