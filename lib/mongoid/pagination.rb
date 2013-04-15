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
        empty_args = arg_blank?(opts[:limit]) &&
          arg_blank?(opts[:page]) &&
          arg_blank?(opts[:offset])

        return criteria if empty_args

        limit = (opts[:limit] || 25).to_i
        page  = (opts[:page]  || 1).to_i

        if arg_blank?(opts[:page])
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

      private
      def arg_blank?(arg)
        case arg
        when String
          arg !~ /[^[:space:]]/
        else
          arg.nil? || arg == false
        end
      end
    end
  end
end
