module DataMapper
  module Is
    module Paginated
      def is_paginated(options = {})
        extend  DataMapper::Is::Paginated::ClassMethods
      end

      module ClassMethods
        def paginated(options = {})
          page     = options.delete(:page) || 1
          per_page = options.delete(:per_page) || 5
          sort_order = key.map{ |k| ::DataMapper::Query::Direction.new(k,:asc)}
          
          options.reverse_merge!({
            :order => sort_order
          })
          
          page_count = (count(options).to_f / per_page).ceil
          
          options.merge!({
            :limit => per_page, 
            :offset => (page - 1) * per_page
          })
          
          [ page_count , all(options) ]
        end
      end
    end
  end
end
