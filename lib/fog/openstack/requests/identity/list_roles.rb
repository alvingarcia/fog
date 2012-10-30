module Fog
  module Identity
    class OpenStack
      class Real

        def list_roles
          request(
            :expects => 200,
            :method => 'GET',
            :path   => '/OS-KSADM/roles'
          )
        end

      end

      class Mock

        def list_roles
          response = Excon::Response.new
          response.status = 200
          if self.data[:roles].empty?
            ['admin', 'project_manager', 'Member'].each do |name|
              id = Fog::Mock.random_hex(32)
              self.data[:roles][id] = {'id' => id, 'name' => name}
            end
          end
          response.body = { 'roles' => self.data[:roles].values }
          response
        end

      end
    end
  end
end

