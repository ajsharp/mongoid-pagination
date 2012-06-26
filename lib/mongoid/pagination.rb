require 'active_support/core_ext'

module Mongoid
  module Pagination
    extend ActiveSupport::Concern

    module ClassMethods

      # Paginate the results
      #
      # @param [Hash] opts
      # @option [Integer] :page (default: 1)
      # @option [Integer] :limit (default: 25)
      #
      # @return [Mongoid::Criteria]
      def paginate(opts = {})
        return criteria if opts[:limit].blank? and opts[:page].blank? and opts[:offset].blank?

        limit = (opts[:limit] || 25).to_i
        page  = (opts[:page]  || 1).to_i

        if opts[:page].blank?
          offset = (opts[:offset] || 0)
        else
          if page > 1
            offset = (page - 1) * limit
          else
            offset = 0
          end
        end

        per_page(limit).offset(offset)
      end

      # Limit the result set
      #
      # @param [Integer] page_limit the max number of results to return
      # @return [Mongoid::Criteria]
      def per_page(page_limit = 25)
        limit(page_limit.to_i)
      end
    end
  end
end
