ActiveRecord::Schema.define(:version => 1) do

  create_table "companies", :primary_key => "cid", :force => true do |t|    
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
