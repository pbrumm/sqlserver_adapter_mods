module ActiveRecord
  module ConnectionAdapters
    class SQLServerColumn
    
      # removes adapter specific date and time casting which is broken
      # on Windows. Default AR type casting works properly for SQLServer 
      # on *nix and Windows since Rails 2.0.
      def type_cast(value)
        return nil if value.nil?
        case type
          when :boolean   then value == true or (value =~ /^t(rue)?$/i) == 0 or value.to_s == '1'
          else super
        end
      end
      
    end
  end
end
