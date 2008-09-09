require File.dirname(__FILE__) + '/spec_helper'
describe 'SQLServerAdapter' do
  attr_accessor :connection
  
  before do
    @connection = ActiveRecord::Base.connection
  end
  
  describe "pk_and_sequence_for" do  
    it "should allow SchemaDumper to dump primary key option for pk other than 'id'" do
      schema = StringIO.new
      dumper = ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, schema)
      schema.rewind
      schema.read.should match(/create_table "companies", :primary_key => "cid"/)
    end
    
    it "should return primary key and sequence" do
      connection.pk_and_sequence_for('companies').should == ['cid', nil]
    end
  end
  
  describe "quote_table_name" do
    it "should include owner in table name when dot notation used" do
      connection.quote_table_name('dbo.companies').should == '[dbo].[companies]'
    end
    
    it "should leave out owner if no dot notation used" do
      connection.quote_table_name('companies').should == '[companies]'
    end
  end
end
