# frozen_string_literal: true

module VersionOne
  module Resources
    # The ApiKeys Grape Controller is responsive for the following endpoints
    class ApiKeys < Base
      include VersionOne::Authenticated

      resource :api_keys do
        resource :user do
          get do
            user = current_user
            present user, with: Entities::User
          end
        end

        get do
          api_keys = ApiKey.all

          present api_keys, with: Entities::ApiKey
        end

        params do
          requires :user_id, type: Integer
        end
        post do
          api_key = ApiKey.create!(permitted_params)

          present api_key, with: Entities::ApiKey
        end

        route_param :api_key_id, type: Integer do
          get do
            api_key = ApiKey.find(permitted_params[:api_key_id])

            present api_key, with: Entities::ApiKey
          end

          delete do
            api_key = ApiKey.find(permitted_params[:api_key_id])

            api_key.destroy!

            status 204
          end
        end
      end
    end
  end
end
