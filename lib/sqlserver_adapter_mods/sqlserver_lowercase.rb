module ActiveRecord
  module ConnectionAdapters
    class SQLServerColumn
    	#lowercasing not sure if this is needed,  for my reads it doesn't matter if I have this or not.
   		def name
   			@name.downcase	
 			end
 		end
 		class SQLServerAdapter
 			# Adding a downcase of the column names in the hash.  this makes it easier to deal with the mixed case column names
 		  private
        def select(sql, name = nil)
          repair_special_columns(sql)

          result = []          
          execute(sql) do |handle|
            handle.each do |row|
              row_hash = {}
              row.each_with_index do |value, i|
                if value.is_a? DBI::Timestamp
                  value = DateTime.new(value.year, value.month, value.day, value.hour, value.minute, value.sec)
                end
                row_hash[handle.column_names[i].downcase] = value
              end
              result << row_hash
            end
          end
          result
        end
 			
 		end

  end
end
