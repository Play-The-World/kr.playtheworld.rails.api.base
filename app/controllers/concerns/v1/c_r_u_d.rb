module V1
  module CRUD
    # extend Apipie::DSL::Concern
    extend ActiveSupport::Concern

    module ClassMethods
      def crud_with(object)
        def_param_group :concern do
          param_group object
        end

        def_param_group :data do
          param     :data,              Hash,           desc: "Data", required: true do
            param_group :concern
            property   :relationships,     Hash,           desc: "Relationships", default_value: {}
          end
        end

        def_param_group :response do
          param     :id,                Integer,        desc: "ID", required: true
          property  :type,              [object.to_s],  desc: "Type"
          param_group :data
        end

        include V1::CRUDDocs
      end
    end
  end
end