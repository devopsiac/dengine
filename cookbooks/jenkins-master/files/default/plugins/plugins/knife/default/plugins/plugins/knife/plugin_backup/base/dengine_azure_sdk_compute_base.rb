require 'chef/knife'
require 'azure_mgmt_compute'

module Engine
  module DengineAzureSdkComputeBase
 
    include Azure::ARM::Compute
    include Azure::ARM::Compute::Models
    
      def self.included(includer)
      includer.class_eval do

        def client

          @client ||= begin
            token_provider = MsRestAzure::ApplicationTokenProvider.new(Chef::Config[:knife][:azure_tenant_id], Chef::Config[:knife][:azure_client_id], Chef::Config[:knife][:azure_client_secret])
            credentials = MsRest::TokenCredentials.new(token_provider)
            client = ComputeManagementClient.new(credentials)
          end
        @client.subscription_id = Chef::Config[:knife][:azure_subscription_id]
        @client
        end
        end
      end
    end
  end
